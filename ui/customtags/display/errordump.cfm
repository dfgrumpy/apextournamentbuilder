<cfset variables.fw = caller.this />


<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>


<cfoutput>
		
	<!--- courtesy of Andreas Schuldhaus --->
	<div id="errorDumpDiv" style="border: 2px dotted red; padding: 10px;" <cfif attributes.hidedisplay>class="visually-hidden"</cfif>>
		<h1 style="color: red;">ERROR!</h1>
		<div style="width: 100%; text-align: left;">
			<cfoutput>
				<cfif structKeyExists( request, 'failedAction' )>
	                <!--- sanitize user supplied value before displaying it --->
					<p><b>Action:</b> #replace( request.failedAction, "<", "&lt;", "all" )#<br/></p>
				<cfelse>
					<p><b>Action:</b> unknown<br/></p>
				</cfif>
				<p><b>Error:</b> #request.exception.cause.message#<br/></p>
				<p><b>Details:</b> #request.exception.cause.detail#<br/></p>
			</cfoutput>
		</div>
		<br/><br/>
	
		<cfdump var="#request.exception.cause.TagContext#" label="Stack Trace" format="text" >
	
	
	</div>
</cfoutput>


<cfif attributes.hidedisplay>
<script lang="javascript">
	window.addEventListener('click', function (evt) {
	    if (evt.detail === 5) {
	       $('#errorDumpDiv').toggleClass('visually-hidden');	        
	    }
	});
</script>
</cfif>