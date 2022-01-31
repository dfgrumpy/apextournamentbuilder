component accessors="true" {

    property beanFactory;
    property formatterService;
	property securityService;
	property sessionService;
	property userService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function default( rc ) {
        var instant = variables.beanFactory.getBean( "instant" );
		rc.today = variables.formatterService.longdate( instant.created() );
	}
	
	public void function sitelink( rc ) {

		var customurl = variables.fw.getitem();
		var tourneyowner = getuserService().getByCustomURL(variables.fw.getitem());

		if (! isNull(tourneyowner)) {
			variables.fw.redirect('tournament.mytournaments');
		}
	
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
}
