
<cfoutput>
<div class="row row-cols-1 row-cols-md-4 text-center">
    <div class="col">
        <div class="card rounded-3 shadow-sm text-white border-success">
            <div class="card-body">
                <h1 class="card-title pricing-card-title">#rc.tournament.countPlayersInTournament('ALL', false)#</h1>
                <ul class="list-unstyled mt-3 mb-4">
                <li>Players Registered</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="col">
        
        <div class="card rounded-3 shadow-sm text-white border-danger">
            <div class="card-body">
                <h1 class="card-title pricing-card-title" id="teamcountunapproved">#rc.teamcountunapproved#</h1>
                <ul class="list-unstyled mt-3 mb-4">
                <li>Teams Not Approved</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="col">
        <div class="card rounded-3 shadow-sm text-white border-info">
            <div class="card-body">
                <h1 class="card-title pricing-card-title" id="teamcountapproved">#rc.teamcountapproved#</h1>
                <ul class="list-unstyled mt-3 mb-4">
                <li>Teams Approved </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="col">
        <div class="card rounded-3 shadow-sm text-white border-#rc.uihelper.filledTeamsToClassColor(rc.tournament.filledTeamsForTournament(), rc.tournament.getteamsize())#">
            <div class="card-body">
                <h1 class="card-title pricing-card-title">#rc.tournament.filledTeamsForTournament()#</h1>
                <ul class="list-unstyled mt-3 mb-4">
                <li>Registered Teams</li>
                </ul>
            </div>
        </div>
    </div>
</div>
</cfoutput>