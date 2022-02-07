component accessors="true" hint="for security items" extends="model.base.baseget"      {

	property userService;
	property sessionService;
	property configService;
	
	property name="itterations" default="6" ;
	property name="secEncoding" default="SHA-512" ;
	property name="algorithm" default="AES" ;
	property name="cryptEncoding" default="hex" ;
	property name="secret" default="xMY82fipzS6cBd1rGudEJQ==" ;


	public struct function hashString(source) hint="generates salt/hash of string"  {
		var salt = Hash(GenerateSecretKey(getalgorithm()), getsecEncoding());
		var hashed = Hash(arguments.source & salt, getsecEncoding(), "utf-8", getItterations());
		return {salt: salt, hash: hashed};
	}


	public string function validateHash(checkString, sourceHash, sourceSalt) hint="validates hash"  {
		var hashed = Hash(checkString & arguments.sourceSalt, getsecEncoding(), "utf-8", getItterations());		

		return (hashed eq arguments.sourceHash) ? 1:0;

	}

	public struct function generateKey(){				
		return hashString(createUUID()).hash.left(15);
	}


	public any function validateLogin(user, pass) hint="validates login"  {
		
		var userObj = getuserService().getUserByEmail(arguments.user);
		
		if (isNull(userObj)) {
			return false;
		} else if (! userObj.getStatus()) {
			return userObj.getStatus();
		} else if (userObj.getStatus() && userObj.getresetlockout() != 1 && validateHash(arguments.pass, userObj.getPassword(), userObj.getSalt())){
			return userObj;			
		}
		
		return false;		

	}
	
	public any function impersonate(user) hint=""  {
		
		var userObj = getuserService().getuser(arguments.user);
			
		if (isNull(userObj)) {
			return false;
		} else if (! userObj.getStatus() || userObj.getsecurityrole().getLevel() LT 3) {
			return false;
		} else {
			return userObj;			
		}
		
		return false;		

	}
	
	
	public string function isSecureSection(section) hint="validates section to see if it is a secure area"  {
		var secureSections = getConfigService().getsecureSections().listtoarray();
		var baseLocation = arguments.section;
		var baseItem = arguments.section.listlast('.');
		var fullLocation = cgi.path_info;
		var secureLocation = 0;

		var isSecure = arrayfind(secureSections,function(item) {

			if (item == baseLocation) { // specific location matches 
				secureLocation = 1;
				return 1;
			}

			if (item.listfind(baseitem, '.') && item.listfind('*', '.')) {
				if (fulllocation contains item.listlast('.')){
					secureLocation = baseitem == 'modal' ? 2:1; // return of 2 means secure modal window					
					return 1;
				}
			}
			return 0;
		});

		return secureLocation;
	
	}
	
		
	public string function isRedirectSection(section) hint="checks to see if url requested can be redirected to post login"  {
		
		var RedirectSections = getConfigService().getRedirectSections().listtoarray();
		for (item in local.RedirectSections) {
			if (arguments.section contains item) {
				return true;
			}
		}
		return false;
	}

	public string function isAjaxRequest(){

		var headers = getHttpRequestData().headers;
		return structKeyExists(headers, "X-Requested-With") and (headers["X-Requested-With"] eq "XMLHttpRequest") ;

	}


		
	public string function encryptString(data) hint="encrypts decryptable string"  {		
		return encrypt(	data, getsecret(), getalgorithm(), getCryptEncoding() ) ;
	}
	
	
	
	public string function decryptString(data) hint="decrypts encrypted string" {		
		return decrypt(	data, getsecret(), getalgorithm(), getCryptEncoding() ) ;
	}
	
	
	

	public string function createForgotLink( user ) hint="create link for forgot login"  {
		
		var hash = hashString(getTickcount()).hash;
		
		arguments.user.setresetlockout(1);
		
		if (arguments.user.hasloginreset()) {
			arguments.user.getloginreset().setresetlink(hash);			
			entitySave(arguments.user);
		} else {			
			var resetObj = entityNew("loginreset", {resetlink:hash, user = arguments.user});
			entitysave(resetObj);
		}
							
		ormflush();
				
		
	}
	

	
	public boolean function canUserManageTournament(tournamentid) {		
		
		res = ormExecuteQuery("select id from tournament where id = :A and owner = :B " ,{A:arguments.tournamentid, B: getSessionService().getloginuser()}, true);

		return isNull(res) ? false:true; // need to return inverse so code reads propery.

	}
	
	



}