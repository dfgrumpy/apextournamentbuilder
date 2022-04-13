
<cfheader statuscode="500" statustext="Request Failure">


<cfimport prefix="displaypanels" taglib="/ui/customtags/display">

<cfif ! structKeyExists(rc, 'errorguid')>
	<cfset rc.errorguid = '7A0CE683-9999-ZZZZ-85496DBAD49F06E0'>
</CFIF>

<cfif cgi.SERVER_NAME contains "localll">
	<displaypanels:errordump hidedisplay="false" />
<cfelse>
	<div class="container">
		<div class="bg-primary p-5 rounded mt-3">
			<h1 class="text-info">Well this is embarrassing</h1>
			<p class="lead">If you are seeing this then something has gone wrong.  Apparently, our developer has failed to handle something propperly and you got an error.  We have been notified and will look into the issue.</p>
		</div>
		
	</div>
	<displaypanels:errordump hidedisplay="true" />
</cfif>



