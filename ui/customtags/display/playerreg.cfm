

<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>

<cfset variables.fw = caller.this />

<cfset thisTourney = attributes.rc.tournament>

<cfset individual = attributes.individual>



<cfset num = attributes.playernumber>
<cfset teamsize = attributes.teamsize>


<cfif  attributes.rc.keyexists('playerreg') && isArray(attributes.rc.playerreg)>
    <cfset thisPlayer = attributes.rc.playerreg[num]>
<cfelse>
    <cfset thisPlayer = {
        'playername' :  '',
        'platform' : '',
        'Playerrank' : '',
        'originname' : '',
        'discord' : '',
        'Twitter' : '',
        'twitch' : '',
        'streaming' : '0',
        'Level' : '',
        'Kills' : ''
    }>
</cfif>



<cfif individual and num gt 1>
    <cfset fieldreq = ''>
<cfelseif (individual and num eq 1) or !individual> 
    <cfset fieldreq = 'required'>
<cfelse>
    <cfset fieldreq = 'required'>
</cfif>


<cfoutput>

<div class="card text-white bg-primary mb-3 mt-2" style="max-width: 60rem;">
    <div class="card-header  <cfif thisplayer.keyExists('SAVEERROR')>text-white bg-danger<cfelse>text-white bg-success</cfif>">
            Player #num# <cfif num eq 1 && teamsize gt 1 >( You )</cfif>
            <cfif thisplayer.keyExists('SAVEERROR')><p class="border-top"><strong>ERROR: </strong>#thisplayer.SAVEERROR.detail#</p></cfif>
    </div>
    <div class="card-body">
        <p>
            <label for="playername" class="form-label">Player Name</label>
            <input type="text" class="form-control" id="playername_#num#" name="playername_#num#" value="#thisPlayer.playername#" #fieldreq#>
        </p>
        <p>
            <label for="Platform_#num#" class="form-label">Platform</label>
            <select id="Platform_#num#"  name="Platform_#num#" class="form-select" #fieldreq#>
                <option value="">----</option>
                <option value="PC" <cfif thisPlayer.platform eq 'PC'>selected</cfif>>PC</option>
                <option value="PSN" <cfif thisPlayer.platform eq 'PSN'>selected</cfif>>Playstation</option>
                <option value="XBL" <cfif thisPlayer.platform eq 'XBL'>selected</cfif>>Xbox</option>
            </select>
        </p>
        <p>
            <label for="rank_#num#" class="form-label">Rank</label>
            <select id="rank_#num#"  name="rank_#num#" class="form-select" #fieldreq#>
                <option value="">----</option>
                <cfset ranks = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master', 'Apex Predator', 'None / Unknown']>
                <cfloop item='r' array="#ranks#">
                    <option value="#r#" <cfif thisPlayer.Playerrank eq r>selected</cfif> >#r#</option>
                </cfloop>
            </select>                                
        </p>
        <p>
            <label for="originname_#num#" class="form-label">Origin Name <small class="text-muted">(Stats lookup)</small></label>
            <input type="text" class="form-control" id="originname_#num#" name="originname_#num#" value="#thisPlayer.originname#">
        </p>
        <p class="mb-2">
            <label for="twittername_#num#" class="form-label mb-0">Twitter Name</label>
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1">@</span>
                <input type="text" class="form-control" id="twittername_#num#" name="twittername_#num#" value="#thisPlayer.twitter#">
            </div>
        </p>
        <p>
            <label for="discordname_#num#" class="form-label">Discord Name</label>
            <input type="text" class="form-control" id="discordname_#num#" name="discordname_#num#" value="#thisPlayer.discord#">
        </p>
        <p>
            <label for="twitchname_#num#" class="form-label">Twitch Name</label>
            <input type="text" class="form-control" id="twitchname_#num#" name="twitchname_#num#" value="#thisPlayer.twitch#">
        </p>
        <p>
            <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  Streaming" data-off="<i class='bi bi-x'></i>  Not Streaming" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="Streaming_#num#" id="Streaming_#num#" <cfif thisPlayer.streaming>checked</cfif>>           
        </p>
    </div>
</div>

</cfoutput>