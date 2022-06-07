
<cfset request.layout = false>
<cfheader name="Content-Disposition" value="inline; filename=#rc.exportname#"> 
<cfcontent type="text/csv">

<cfif  isnull(rc.tournament) || ! rc.tournament.hasplayer()>
	<cfabort> <!---// normally we don't abort but here we want to as we are just generating an export that has no content--->
</cfif>

<cfoutput>
    #rc.exprotData#
</cfoutput>