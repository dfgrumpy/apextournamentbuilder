

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="//cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
	<link href="/assets/css/libraries/bootstrap.min.css" rel="stylesheet">
	<link href="//cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css" rel="stylesheet">
	<link href="//cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <link href="//gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet" >
	
	<link href="/assets/css/section/<cfoutput>#rc.action#</cfoutput>.css" rel="stylesheet">
	<link href="/assets/css/main.css" rel="stylesheet">
	<title>Apex Tournament Builder <cfoutput>#rc?.title#</cfoutput></title>
  </head>
  <body>
	<div class="container py-3" style="max-width: 960px;">
		<header>
			<div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
			<a href="/" class="d-flex align-items-center text-decoration-none">
				<span class="fs-4"><img src="/assets/images/apex-logo-F74B0C9FCD-seeklogo.com.png" style="height: 40px;" > Tournament Builder</span>
			</a>

			<nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
				<cfif structKeyExists(session, 'loginuser')>
					<a class="py-2 me-3 text-decoration-none" href="<cfoutput>#buildurl('main.default')#</cfoutput>">Create New</a>
					<a class="py-2 me-3 text-decoration-none" href="<cfoutput>#buildurl('tournament.mytournaments')#</cfoutput>">My Tournaments</a>
					<a class="py-2 text-decoration-none" href="<cfoutput>#buildurl('main.logout')#</cfoutput>">Logout</a>
				<cfelse>
					<a class="py-2  text-decoration-none" href="<cfoutput>#buildurl('main.login')#</cfoutput>">Login</a>
				</cfif>
			</nav>
			</div>
		</header>
	</div>

	<cfoutput>#body#</cfoutput>	<!--- body is result of views --->


	<!---toast base code --->
	<div class="toast-container position-absolute p-3 top-0 start-50 translate-middle-x" id="toastPlacement" data-original-class="toast-container position-absolute p-3">
		<div class="toast align-items-center text-white border-0 hide" role="alert" aria-live="assertive" aria-atomic="true" id="toastHeader">
			<div class="d-flex">
				<div class="toast-body" id="toastBody">asdfasdf asdfasdf
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>
	<!---Modal base code --->
	<div class="modal fade" id="baseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="true" >
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel"></h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body" id="myModalBody">
			</div>
			<div class="modal-footer justify-content-between">
				<div class="d-grid gap-2 col-4 ">
				<button type="button" class="btn btn-default text-center btn-small py-2" data-bs-dismiss="modal"><i class="glyphicon glyphicon-remove"></i> Close</button>
				</div>
				<div class="d-grid gap-2 col-4 text-end">
				<button type="button" class="btn btn-success text-center btn-small py-2" id="myModalSave"><i class="glyphicon glyphicon-ok"></i> <span>Save</span></button>
				</div>
			</div>
			</div>
		</div>
	</div>

  </body><!-- include summernote css/js -->

  	<script src="//cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="//cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="//cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script src="//gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
	<!--- try and load any section specific JS file --->
	<cfif fileExists('#variables.webrootPath#/assets/js/section/#getSection()#.js')>
		<script src="/assets/js/section/<cfoutput>#getSection()#.js#application.cachebuster#</cfoutput>"></script>
	</cfif>

	<cfoutput>
		<script src="/assets/js/site.js#application.cachebuster#"></script>
		<script src="/assets/js/ui.js#application.cachebuster#"></script>
		<script src="/assets/js/ajax.js#application.cachebuster#"></script>
		<script src="/assets/js/util.js#application.cachebuster#"></script>
		<script src="/assets/js/events.js#application.cachebuster#"></script>
		
	</cfoutput>

	<script>
		

		$(function () {
	  		mainNS.init();
		
			// load any event handlers for the current page
			eventsNS.init('<cfoutput>#getSectionAndItem()#</cfoutput>');		
		});
	</script>
