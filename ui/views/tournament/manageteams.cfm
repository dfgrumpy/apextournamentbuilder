



    <cfoutput>
<div class="container py-3">
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col text-start">
                    <h5 class="mb-0">
                        <a href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Tournament Detials">
                            <i class="bi bi-person-badge fs-5 text-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#"></i> #rc.tournament.gettournamentname()#                    
                        </a>
                    </h5>
                </div>
                <div class="col text-end">
                    <h5 class="mb-0">
                        #dateformat(rc.tournament.geteventdate(), 'long')#
                    </h5>
                </div>
            </div>
        </div>
        <div class="card-body">               
            <div class="row row-cols-1 row-cols-md-4 text-center">
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-success">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.tournament.getPlayer().len()#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Players Registered</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    
                    <div class="card rounded-3 shadow-sm text-white border-info">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.teamcounts.recordcount#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Teams Created</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-warning">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.teamcountsEmpty.recordcount#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Empty Teams</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-info">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.tournament.filledTeamsForTournament()#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Filled Teams</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <main>
        <div class="card text-white bg-primary mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col text-start">                    
                        <h5 class="mb-0">
                            Tournament Teams                 
                        </h5>
                    </div>
                </div>
            </div>
            <div class="card-body" style="min-height: 550px;">               
                <div class="row row-cols-2 ">                    
                    <div class="col col-4">
                        <div class="list-group eam-list-group-scroll border border-secondary teamDetailList">
                            <cfloop query="#rc.teamcounts#">
                            <button type="button" data-teamid="#id#" class="list-group-item d-flex justify-content-between align-items-center btn-link teamDetailListBtn">
                            #name#
                            <span class="badge bg-#rc.uihelper.playerCountToColor(playercount, rc.tournament.getteamsize())#" >#playercount#</span>
                            </button>
                            </cfloop>
                        </div>
                    </div>
                    <div class="col col-8 p-0" id="teamContent">
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</cfoutput>
