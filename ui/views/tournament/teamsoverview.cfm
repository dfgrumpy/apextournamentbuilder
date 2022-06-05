



<cfoutput>

<div class="container py-3">
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col text-start">
                    <h5 class="mb-0">
                        <a class="text-decoration-none" href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Tournament Detials">
                            <i class="me-2 bi bi-person-badge fs-5 text-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#"></i>#rc.tournament.gettournamentname()#                    
                        </a>
                    </h5>
                </div>
                <div class="col text-end">
                    <h5 class="mb-0">
                        #dateformat(rc.tournament.geteventdate(), 'long')#
                        <div class="btn-group dropend mb-0 pb-0 ms-2">
                            <button type="button" class="btn btn-info  btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-list"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-light rounded-0 p-2 border-light">
                                <cfif rc.tournament.getType().getHasTeams() || rc.tournament.getTeamSize() gt 1>
                                    <li class="m-1 pb-1">
                                        <a href="#buildurl('tournament.teamsoverview?tournament/#rc.tournament.getid()#')#" class="dropdown-item btn text-light btn-secondary rounded-0">
                                            <i class="bi bi-people-fill me-1"></i> Manage Teams
                                        </a>
                                    </li>
                                    <li class="m-1 pb-1">
                                        <a href="#buildurl('tournament.teambuilder?tournament/#rc.tournament.getid()#')#" class="dropdown-item btn text-light btn-primary rounded-0">
                                            <i class="bi bi-people-fill me-1"></i> Team Builder
                                        </a>
                                    </li>
                                </cfif>
                                <li class="m-1 pb-1">
                                    <a href="#buildurl('tournament.manageplayers?tournament/#rc.tournament.getid()#')#" class="dropdown-item btn text-light btn-warning rounded-0" >
                                        <i class="bi bi-person-fill me-1"></i> Manage Players
                                    </a>
                                </li>
                                <li class="m-1 pb-1">
                                    <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#')#" class="dropdown-item btn text-light btn-success rounded-0" >
                                        <i class="bi bi-person-check-fill me-1"></i> Manage Approvals
                                    </a>
                                </li>
                            </ul>
                        </div>         
                    </h5>
                </div>
            </div>
        </div>
        <div class="card-body">               
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
                    
                    <div class="card rounded-3 shadow-sm text-white border-info">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.teamcountapproved#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Teams Approved</li>
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
        </div>
    </div>
    <main>
        <div class="card text-white bg-primary mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col-3 text-start">                    
                        <h5 class="mb-0">
                            Teams Overview     (#rc.teamcounts.recordcount#)            
                        </h5>
                    </div>
                    <div class="col  text-end">
                        <cfif rc.missingteams neq 0>
                            <button type="button" class="btn btn-sm btn-info teamAddBtn" data-tournamentid="<cfoutput>#rc.tournament.getid()#</cfoutput>"  data-bs-toggle="tooltip" data-bs-placement="top" title="Add player">
                                <i class="bi bi-people-fill"></i> Add Team
                            </button>
                        </cfif>
                    </div>
                </div>
            </div>
            <div class="card-body" style="min-height: 550px;">               
                <div class="row row-cols-2 ">                    
                    <div class="col col-4">
                        <div class="d-grid gap-2 mt-0 mb-1">    
                            <div class="btn-group pt-1">
                                <button type="button" id="teamRenameBtn" class="btn btn-sm btn-primary d-none teamActionBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Rename Team">
                                    <i class="bi bi-pencil me-2"></i> Rename
                                </button>
                                <button type="button" id="teamDeleteBtn" class="btn btn-sm btn-danger d-none teamActionBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Team">
                                    <i class="bi bi-trash me-2"></i> Delete
                                </button>
                            </div>
                        </div>
                        <div class="list-group eam-list-group-scroll border border-secondary teamDetailList" style="max-height: 475px; overflow-y:auto">
                            <cfloop query="#rc.teamcounts#">
                            <button type="button" data-teamid="#id#" class="list-group-item d-flex justify-content-between align-items-center btn-link teamDetailListBtn">
                                <span id="teamName#id#">
                                    <cfif alternate>
                                        <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                                    </cfif>  
                                    #name#
                                </span>
                            <span class="badge bg-#rc.uihelper.playerCountToColor(playercount, rc.tournament.getteamsize())#" >#playercount#</span>
                            </button>
                            </cfloop>
                        </div>

                        <div class="d-grid gap-2 mt-1 mb-1">    
                            <form id="teamfilterForm" class="row" method="post" action="#buildurl('tournament.teamsoverview/tournament/#rc.tournament.getid()#')#">
                            <div class="btn-group" role="group">
                                <input type="checkbox" value="1" class="btn-check" id="approvedonly" name="approvedonly" autocomplete="off" <cfif rc.approvedonly>checked</cfif>  onchange="$('##teamfilterForm').submit();">
                                <label class="btn btn-outline-info btn-sm" for="approvedonly">Approved Only</label>                              
                                <input type="checkbox" value="1" class="btn-check" id="showalternate" name="showalternate" autocomplete="off" <cfif rc.showalternate>checked</cfif>  onchange="$('##teamfilterForm').submit();">
                                <label class="btn btn-outline-info btn-sm" for="showalternate">Show Alternates</label>
                              </div>                      
                            </form>
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
