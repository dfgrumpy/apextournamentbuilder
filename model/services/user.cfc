component accessors="true" hint="for security items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	
	public any function getUser( data ){
		return entityloadByPK("user", arguments.data);
	}


	public any function getUserByEmail( emailAddress ){
		return entityload("user", {email=arguments.emailAddress}, true);
	}

	public any function getByCustomURL( required string customurl ){
		return entityload("user", {customurl=arguments.customurl}, true);
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
			status: 1
		};
        
		var thisUser = entityNew("user", usrStruct);
		entitysave(thisUser);
		ormflush();

        return thisUser;

	}
}