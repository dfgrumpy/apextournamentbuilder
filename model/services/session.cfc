component accessors="true" hint="for interacting with a users session data"  extends="model.base.baseget"      {


	public string function isUserLoggedIn() hint="checks to make sure user has a valid session userid"  {

		if (len(this.getuserLoginId()) && this.getuserLoginId() != 0){
			return true;
		}

		return false;

	}


	public void function rotateMemorySession() hint="creates new session for user" {

		// may throw error that session is invalid
		try {
			sessionrotate();
	    } catch(any e){ }

	}

	public any function createSession(required user) hint="creates a user's session" {
		rotateMemorySession();
		this.setuserLoginId(arguments.user.getid());
		user.setlastlogin(now());
		Entitysave(user);
		return true;
		
	}
	
	public any function setLoginUser() hint="sets the user model for the logged in user into the session" {		
		var thisUser = entityloadByPK("user", this.getuserloginid());
		setVar('loginuser', thisuser);
		// force entity merge into session
		getloginuser();
	} 
	
	
	public void function endSession() hint="Ends a user's session" {
		// invalidate j2ee session
		if (!isNull(getPageContext().getSession())) {
			getPageContext().getSession().invalidate();
		}
		SessionInvalidate();
		rotateMemorySession();
	}


	public any function getFullSession(){
		return session;
	}

	/* the persistant object needs to be reloaded into this request */
	public any function getloginuser(){
		return entitymerge(session.loginuser);
	}

	public any function hasSession(){
		return structKeyExists(session, "loginuser");
	}


	public struct function getSessionKeys(required array keys){
		var results = {};
		var keyCount = arrayLen(arguments.keys);

		for( var i=1; i lte keyCount; i++ ){
			results[arguments.keys[i]] = session[arguments.keys[i]];
		}

		return results;
	}

	public void function resetSessionScope(string exceptions=""){
		var sessionScope = this.getFullSession();
		// make sure to keep the ColdFusion specific Session keys around
		arguments.exceptions = listAppend(arguments.exceptions, "sessionId,urlToken");

		// loop through the session and kill the keys
		for( var key in sessionScope ){
			if( !listFindNoCase(arguments.exceptions, key) ){
				// kill the key from the struct
				structDelete(sessionScope, key);
			}
		}
	}


	public any function getVar(string configKey, any configValue){
		return get(argumentCollection=arguments);
	}

	public void function setVar(required string configKey, required any configValue, any persist = false){
		set(argumentCollection=arguments);
	}

	public void function deleteVar(required string configKey, any persist = false){
		// kill the key from the session scope
		structDelete(this.getFullSession(), configKey);
	}
	
	public any function WSChannelKey(){
		return listfirst(session.sessionid, '.');
	}
	
	public any function getSessionIdSmall(){
		return hash(session.sessionid);
	}
	
	


	private any function get(string configKey, any configValue){
		arguments.source = session;
		return super.get(argumentCollection=arguments);
	}

	private any function has(string configKey, any configValue){
		return structKeyExists(session, configKey);
	}
	private void function set(required string configKey, required any configValue, any persist = false){
		session["#arguments.configKey#"] = arguments.configValue;
	}

}