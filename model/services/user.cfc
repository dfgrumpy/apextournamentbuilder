component accessors="true" hint="for security items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property emailService;
	
	public any function getUser( data ){
		return entityloadByPK("user", arguments.data);
	}


	public any function getUserByEmail( emailAddress ){
		return entityload("user", {email=arguments.emailAddress}, true);
	}

	public any function getByCustomURL( required string customurl ){
		return entityload("user", {customurl=arguments.customurl}, true);
	}

	public any function getUserByResetLink( resetlink ){
		return entityload("loginreset", {resetlink=arguments.resetlink}, true);
	}
	public any function getUserByVerifyCode( verifycode ){
		return entityload("user", {verifycode=arguments.verifycode}, true);
	}
	

	public any function saveUserRegistration(required struct regData) {
        
		var exists = getUserByEmail(regdata.email);
		if (!isNull(exists)) {
			return;
		}
		var hashPW = getsecurityService().hashString(regData.password);
		var usrStruct = {
			firstname: regdata.fname,
			lastname: '',
			email: regdata.email,
			password: hashPW.hash,
			salt: hashPW.salt,
			securityrole: entityloadbyPK("role", 2),
			status: 0,
			verifycode : getsecurityService().generateKey()
		};
        
		var thisUser = entityNew("user", usrStruct);
		entitysave(thisUser);
		ormflush();

        return thisUser;

	}

	public void function forgotpassword(required model.cfc.user user, required string accountEmail){
		var thisUser = arguments.user;

		getsecurityService().createForgotLink(thisUser);
		entityreload(thisUser);
		getEmailService().sendForgotEmail(thisUser);

	}



	public any function saveResetPassword(required struct data){


		var thisUser = getUserByResetLink(getSessionService().getResetLink()).getuser();

		if (arguments.data.emailaddr != thisuser.getEmail()) {
			return false;
		}

		var hashPW = getsecurityService().hashString(arguments.data.password);

		updUserPassword(thisUser, hashpw, true);

		return true;


	}


	public any function updUserPassword( user, password, isReset = false){

		var thisUser =arguments.user;
		thisUser.setPassword(arguments.password.hash);
		thisUser.setSalt(arguments.password.salt);
		thisUser.setresetlockout(0);

		if (arguments.isReset) { // remove reset link record
			entityDelete(entityloadbyPK("loginreset", thisUser.getloginreset().getId()));
		}

		Entitysave(thisUser);
		ormflush();
		return true;

	}
	

}