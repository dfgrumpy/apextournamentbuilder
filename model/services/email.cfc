component accessors="true" hint="for email items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property apexaipService;
	property tournamentService;
	property configService;
	
	
	public any function sendRegistrationPending(required player, required tournament){



		var emailTemplate = fileread('#application.webrootPath#ui/templates/email/register.html');
		var tourneylink = "#cgi.request_url.replace('index.cfm', 't/#arguments.tournament.getviewkeyShort()#')#"
		var owner = "#arguments.tournament.getOwner().getfullname()# : #arguments.tournament.getcontactEmail()#";

		emailTemplate = emailTemplate.replace("{{title}}", 'Tournament Registration - PENDING');
		emailTemplate = emailTemplate.replace("{{tournamentname}}", arguments.tournament.gettournamentname());
		emailTemplate = emailTemplate.replace("{{eventdate}}", dateformat(arguments.tournament.geteventdate(), 'long'));
		emailTemplate = emailTemplate.replace("{{timezone}}", arguments.tournament.gettimezone());
		emailTemplate = emailTemplate.replace("{{owner}}", owner);
		emailTemplate = emailTemplate.replace("{{tournamentlink}}", tourneylink);


		savecontent variable="contentmsg" {
			writeOutput("<p>Thank you for registering for the tournament.  Your registration is <strong>PENDING</strong> tournament host approval.  Once approved, you will be notified by email.</p>
			<p>Please contact the tournament host if you have any questions.</p>");
		}

		emailTemplate = emailTemplate.replace("{{contentmessage}}", contentmsg);

		sendEmail(arguments.player.getEmail(), 'Tournament Registration - PENDING', emailTemplate);

	}
	public any function sendRegistrationApproved(required player, required tournament){

		var emailTemplate = fileread('#application.webrootPath#ui/templates/email/register.html');
		var tourneylink = "#cgi.request_url.replace('index.cfm', 't/#arguments.tournament.getviewkeyShort()#')#"
		var owner = "#arguments.tournament.getOwner().getfullname()# : #arguments.tournament.getcontactEmail()#";

		emailTemplate = emailTemplate.replace("{{title}}", 'Tournament Registration - APPROVED');
		emailTemplate = emailTemplate.replace("{{tournamentname}}", arguments.tournament.gettournamentname());
		emailTemplate = emailTemplate.replace("{{eventdate}}", datetimeformat(arguments.tournament.geteventdate(), 'MMMM d, YYYY - h:nn tt'));
		emailTemplate = emailTemplate.replace("{{timezone}}", arguments.tournament.gettimezone());
		emailTemplate = emailTemplate.replace("{{owner}}", owner);
		emailTemplate = emailTemplate.replace("{{tournamentlink}}", tourneylink);


		savecontent variable="contentmsg" {
			writeOutput("<p>Congratulations!! Your registration has been <strong>APPROVED</strong> by the tournament host.  We look forward to seeing you at the tournament. </p><p>Good luck.</p>
			<p>Please contact the tournament host if you have any questions.</p>");
		}

		emailTemplate = emailTemplate.replace("{{contentmessage}}", contentmsg);

		sendEmail(arguments.player.getEmail(), 'Tournament Registration - APPROVED', emailTemplate);

	}

	public any function sendRegistrationRejected(required player, required tournament){
		
		var emailTemplate = fileread('#application.webrootPath#ui/templates/email/register.html');

		var tourneylink = "#cgi.request_url.replace('index.cfm', 't/#arguments.tournament.getviewkeyShort()#')#"		
		var owner = "#arguments.tournament.getOwner().getfullname()# : #arguments.tournament.getcontactEmail()#";

		emailTemplate = emailTemplate.replace("{{title}}", 'Tournament Registration - REJECTED');
		emailTemplate = emailTemplate.replace("{{tournamentname}}", arguments.tournament.gettournamentname());
		emailTemplate = emailTemplate.replace("{{eventdate}}", datetimeformat(arguments.tournament.geteventdate(), 'MMMM d, YYYY - h:nn tt'));
		emailTemplate = emailTemplate.replace("{{timezone}}", arguments.tournament.gettimezone());
		emailTemplate = emailTemplate.replace("{{owner}}", owner);
		emailTemplate = emailTemplate.replace("{{tournamentlink}}", tourneylink);


		savecontent variable="contentmsg" {
			writeOutput("<p>Thank you for your interest.  Your registration has been <strong>REJECTED</strong> by the tournament host. 
			<p>Please contact the tournament host if you have any questions.</p>");
		}

		emailTemplate = emailTemplate.replace("{{contentmessage}}", contentmsg);

		sendEmail(arguments.player.getEmail(), 'Tournament Registration - REJECTED', emailTemplate);

	}


	public any function sendEmail(required string toAddress, required string emailSubject, required string emailBody) {

		mailService = new mail(
			to = arguments.toAddress,
			from = getconfigService().getDefaultOutboundEmail(),
			subject = arguments.emailSubject,
			body = arguments.emailBody,
			server = getConfigService().getMailServer(),
			port = getconfigService().getMailPort(),
			username = getconfigService().getmailuser(),
			password = getconfigService().getmailpass(),
			type = 'html',
			usetls = true
			);

		mailService.send();
	}

	public any function sendForgotEmail(required model.cfc.user user) {

		
		var emailTemplate = fileread('#application.webrootPath#ui/templates/email/forgot.html');

		emailTemplate = emailTemplate.replace("{{title}}", '#getConfigService().getappName()# : Password Reset Info');
		emailTemplate = emailTemplate.replace("{{name}}", arguments.user.getFullName());
		emailTemplate = emailTemplate.replace("{{resetlink}}", getconfigService().getURLPrefix() & '/index.cfm/main/reset/link/' & arguments.user.getLoginreset().getresetlink());

		sendEmail(arguments.user.getEmail(), '#getConfigService().getappName()# : Password Reset Info', emailTemplate);


	}


	public any function sendVerification(required model.cfc.user user) {

		
		var emailTemplate = fileread('#application.webrootPath#ui/templates/email/verify.html');

		emailTemplate = emailTemplate.replace("{{title}}", '#getConfigService().getappName()# : Email Verification');
		emailTemplate = emailTemplate.replace("{{name}}", arguments.user.getFullName());
		emailTemplate = emailTemplate.replace("{{verifylink}}", getconfigService().getURLPrefix() & '/index.cfm/main/verify/link/' & arguments.user.getverifycode());

		sendEmail(arguments.user.getEmail(), '#getConfigService().getappName()# : Email Verification', emailTemplate);


	}


}