



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
            <cfif rc.tournament.getindividual() && rc.tournament.getteamsize() eq 1>
                <cfinclude template="/ui/includes/manageapprovalplayer.cfm">
            <cfelseif rc.tournament.getindividual()>
                <cfinclude template="/ui/includes/manageapprovaldual.cfm">
            <cfelse>
                <cfinclude template="/ui/includes/manageapprovalteam.cfm">
            </cfif>
        </div>
        <cfif rc.keyExists('teamcountapproved')>
            <div class="alert alert-danger text-center <cfif rc.teamcountapproved lt 21>d-none</cfif>" id="gtMaxAlert" >
                <strong>Warning!</strong> There are more than 20 teams already approved for this tournament.
            </div>            
        </cfif>
    </div>
    <main>                          
        <cfif rc.section eq 'team'>
            <cfinclude template="/ui/includes/approveteam.cfm">
        <cfelse>
            <cfinclude template="/ui/includes/approveplayer.cfm">
        </cfif>
        
    </main>
</div>
</cfoutput>
