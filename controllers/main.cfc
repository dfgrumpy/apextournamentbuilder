component accessors="true" {

    property beanFactory;
    property formatterService;
	property securityService;
	property sessionService;
	property userService;
	property utilsService;
	property configService;
	property emailService;
	property errorHandlerService;
	property apexaipService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	

	public void function mailtest( rc ) {

		newuser = getuserservice().getUser(9);
		getEmailService().sendVerification(newuser);

		abort;

	}

	

	public void function apitest( rc ) {

		
		var player = entityLoadByPK('player', rc.playerid);
		var stats = getapexaipService().getPlayerProfilev2(player.getoriginname(), player.getalapiPlatform());

		writeDump(stats.deserializeJson());
		
		writeDump(getapexaipService().getTrackedDataFromAPIResultv2(stats));
		abort;
	}

	public void function default( rc ) {
		
		if (rc.keyExists('showConfig') && rc.showConfig == 'crafter') {
			writeDump(getConfigService().getBaseConfig());abort;
		}
	}
	
	public void function sitelink( rc ) {

		var customurl = variables.fw.getitem();
		var tourneyowner = getuserService().getByCustomURL(variables.fw.getitem());


	}
	
	public void function logout( rc ) {
		// logout user
		getsessionService().endSession();
		variables.fw.redirect( action = 'main.default' );
	}

	public void function loginprocess( rc ) {
		var validLogin = getSecurityService().validateLogin(rc.emailaddress, rc.password);


		if (! isObject(validLogin) ){
			variables.fw.redirect('main.login/invalid/true');
		} else {
			getsessionService().createSession(validLogin);
			variables.fw.redirect('tournament.mytournaments');
		}
		


	}

	public void function reset( rc ) {
		var thisUser = getuserService().getUserByResetLink(rc.link);

		if (isNull(thisUser)){
			variables.fw.redirect( action = 'main.default' );
		} else {
			// save the passed in link to reference later
			getSessionService().setresetlink(rc.link);
		}

	}

	public void function resetprocess( rc ) {

		// is reset link not in session.  Can't continue
		if (!len(getSessionService().getResetLink())) {
			variables.fw.redirect( action = 'main.default' );
		}

		var result = getUserService().saveResetPassword(rc);

		if (! result) {
			variables.fw.redirect( action = 'main.reset', querystring= 'link/#getSessionService().getResetLink()#/fail' );
		} else {
			rc.loginreset = true;
			variables.fw.redirect( action = 'main.default', append="loginreset" );
		}
	}

	public void function verify( rc ) {
		var thisUser = getuserService().getUserByVerifyCode(rc.link);
		
		if (isNull(thisUser)){
			variables.fw.redirect( action = 'main.default' );
		} else {
			thisUser.setstatus(1);
			entitySave(thisuser);
			ormflush();
		}
	
	}


	public void function error(rc){

		try {
			rc.errorguid = geterrorHandlerService().logError(request);
		}
        catch(Any e){ 
		}
	
		variables.fw.setLayout('error');

	}
}
