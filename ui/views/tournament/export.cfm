






<cfset request.layout = false>
<cfheader name="Content-Disposition" value="inline; filename=#rc.exportname#"> 
<cfcontent type="application/vnd.msexcel"> 


<cfif  isnull(rc.tournament) || ! rc.tournament.hasplayer()>
	<cfabort> <!---// normally we don't abort but here we want to as we are just generating an export that has no content--->
</cfif>

<cfoutput>
    <table>
        <thead>
            <tr>
                <th>Player Name</th>
                <th>Origin Name</th>
                <th>Discord</th>
                <th>Twitter</th>
                <th>Twitch</th>
                <th>Platform</th>
                <th>Streaming</th>
                <th>Alternate</th>
                <th>Approved</th>
                <th>Rank</th>
                <th>Kills</th>
                <th>Level</th>
                <th>Team</th>
                <th>Created</th>
                <th>Updated</th>
            </tr>
        </thead>

        <cfloop array="#rc.tournament.getplayer()#" item="player">
            <tr>
                <td>#player.getgamername()#</td>
                <td>#player.getoriginname()#</td>
                <td>#player.getdiscord()#</td>
                <td>#player.gettwitter()#</td>
                <td>#player.gettwitch()#</td>
                <td>#player.getplatform()#</td>
                <td>#player.getstreaming().yesnoformat()#</td>
                <td>#player.getalternate().yesnoformat()#</td>
                <td>#player.getapproved().yesnoformat()#</td>
                <td>#player.getplayerrank()#</td>
                <td>#player.getkills()#</td>
                <td>#player.getlevel()#</td>
                <td>#player.getteam()?.getname()#</td>
                <td>#player.getcreated()#</td>
                <td>#player.getupdated()#</td>

            </tr>

        </cfloop>

    </table>
</cfoutput>