component accessors="true"  extends="framework.one"{



	property securityService;
	property sessionService;
	property settingsService;
	property utilsService;

	variables.webrootPath = getDirectoryFromPath(getCurrentTemplatePath());


	this.name = hash('tournamentcrafter');
	this.sessionManagement=true;
	this.sessionTimeout = createTimespan(0,1,0,0);
	this.datasource = "tournamentcrafter";
	this.ormEnabled = true;
	this.showDebugOutput=false;
	this.wschannels = [{name="apex"} ];

	this.mappings["/ui"] = variables.webrootPath & './ui';
	this.mappings["/views"] = variables.webrootPath & './ui/views';
	this.mappings["/layouts"] = variables.webrootPath & './ui/layouts';
	this.mappings["/approot"] = variables.webrootPath & "./";
	this.customTagPaths = variables.webrootPath & "./ui/customtags";
	this.ormPaths=["/model/cfc"];
	this.ormSettings = {cfclocation=this.ormPaths,
						logsql=true,
						flushatrequestend=true,
						eventhandling=true,
						saveMapping=false,
						dbcreate="update",
        				eventHandling = true
					
	};

	if (
		url.keyExists("orm-rebuild") &&
		getEnvironment() == "dev"
	) {
		this.ormSettings.dbCreate = "dropcreate";
	}

	variables.framework = {
		reloadApplicationOnEveryRequest = false,
		generateSES=true,
		SESOmitIndex=true,
		diEngine = 'none',
		unhandledpaths="/scratch,/assets",
		error = "main.error"
	};

	function setupRequest() {
		request.context.startTime = getTickCount();

		if (cgi.path_info contains "/site/") {
			controller('main.sitelink');
		}

	}


	variables.framework.environments = {
	  dev = { reloadApplicationOnEveryRequest = true, trace = false, error = "main.error"}
	};



	// private functions
	private void function setupApplication(){
		if (structKeyExists(url, 'updateorm') && getEnvironment() == "dev") {
			ormreload();
			abort;
		}
		application.javaProps = createObject( "java", "java.lang.System" ).getProperties();

		application.cachebuster = "?v=" & right(hash(createuuid()), 10);
		application.webrootPath = variables.webrootPath;

		// build up config services
		// config is done as its own factory so the config constants can be built up before the remaining factory is built
		var beanfactoryConfig = new framework.ioc("/approot/model/utils",  {strict="false"} );
		beanfactoryConfig.declareBean("configService", "approot.model.services.config", true, { environment = getEnvironment() } );

		// this is required to load config.  If this doesn't run the code will error.
		var config = beanfactoryConfig.getBean("configService");
		config.setConfigFromFile(getEnvironment());

		// build main factory excluding config
		var beanfactory = new framework.ioc( "/approot/model/services,/approot/model/beans,/approot/model/utils" , {strict="false", exclude = ['config']} );



		// combine both bean factories
		beanfactory.setParent(beanfactoryConfig);
		setBeanFactory( beanfactory );

	}


	public string function getEnvironment(){
		if (
			cgi.server_name contains "local" ||
			cgi.server_name contains "dev" ||
			cgi.dev_mode == true ||
			( application.keyExists( "javaProps" ) ? application.javaProps?.environment : createObject( "java", "java.lang.System" ).getProperties()?.environment ) == "dev"
		) {
			return 'dev';
		}
		return 'prod';
	}

	public any function getFramework(){
		return variables.framework;
	}




	public any function before(){

		// on reinit rebuild settings
		if (structkeyexists(rc, "reinit")){
			StructDelete(application, "systemSettings");
		}

		// Only lock the application scope if we don't have system settings
		if ( ! application.keyExists( "systemSettings" ) ) {
			// lock application scope and check it for the system settings.  If not there... load
			lock type="exclusive"  scope="Application" timeout="60" throwontimeout="true"    {
				if (! structKeyExists(application, 'systemSettings') ){
					application.systemSettings = {};
				}
			}
		}

		var isSecureLocation = getsecurityService().isSecureSection(getSectionanditem());


		if (isSecureLocation && ! getSessionService().isUserLoggedIn()){
			if (getsecurityService().isRedirectSection(cgi.PATH_INFO)) {			
				getSessionService().setEntryURL(cgi.PATH_INFO);
			}

			
			if (getsecurityService().isAjaxRequest()){
				// kill the ajax request and stop.  Global ajax error handler will handle the rest
				cfheader(name="custom-error-message", value="Invalid action detected");
				getpagecontext().getresponse().setstatus( 403 );				
				abort; // prevent anything else from happening.
			}

			

			redirect( action = 'main.default' );
		}

		// we should only hit this on first request after login
		if (getSessionService().isUserLoggedIn()){
			getsessionService().setLoginUser();
		}



		if ( getsection() == 't'){
			linkdata = getUtilsService().verifyShortLink(getitem());

			if (!isNull(linkdata)) {
				redirect( action = 'tournament.view/#linkdata.getlinkkey()#' );
			} else {
				redirect( action = 'main.default' );
			}

		}



	}

	function onMissingView( rc ) {
		// generate modal content return
		if (getSectionAndItem() contains "modal"  && structKeyExists(rc, "content")) {
			request.layout = false; // make sure we don't generate the main layout
			savecontent variable="response" {
				include "/ui/templates/modal/#rc.content#.cfm";
			}
			return view(path='', missingView=response);
		}
		return '';
	}



	function onError( exception ) {

		//writeDump(exception);
		return super.onError( argumentCollection: arguments );


	}



}



