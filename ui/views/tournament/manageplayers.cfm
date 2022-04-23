

<div class="container py-3">
    <cfoutput>
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
                                <h1 class="card-title pricing-card-title">#rc.tournament.countPlayersInTournament()#</h1>
                                <ul class="list-unstyled mt-3 mb-4">
                                <li>Players Registered</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <cfset closeDays = datediff('d', now(), rc.tournament?.getregistrationend() ?: rc.tournament?.geteventdate())>
                        <div class="card rounded-3 shadow-sm text-white border-#rc.uihelper.closeDaysToClassColor(closeDays)#">
                            <div class="card-body">
                                <h1 class="card-title pricing-card-title">#closeDays#</h1>
                                <ul class="list-unstyled mt-3 mb-4">
                                <li>Days till Reg Close</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card rounded-3 shadow-sm text-white border-info">
                            <div class="card-body">
                                <h1 class="card-title pricing-card-title">#rc.tournament.countStreamersForTournament()#</h1>
                                <ul class="list-unstyled mt-3 mb-4">
                                <li>Players Streaming</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card rounded-3 shadow-sm text-white border-#rc.uihelper.filledTeamsToClassColor(rc.tournament.filledTeamsForTournament(), rc.tournament.getteamsize())#">
                            <div class="card-body">
                                <h1 class="card-title pricing-card-title">                                    
                                    <cfif rc.tournament.getType().getHasTeams() || rc.tournament.getTeamSize() gt 1>
                                        #rc.tournament.filledTeamsForTournament()#
                                    <cfelse>
                                        N/A
                                    </cfif>
                                </h1>
                                <ul class="list-unstyled mt-3 mb-4">
                                <li>Registered Teams</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
  <main>
    <table class="table table-hover table-bordered" id="sortableTable">
    <thead class="table-light">
        <tr>
        <th scope="co-1"></th>
        <th scope="col">Player</th>
        <th scope="col" class="text-center">Rank</th>
        <th scope="col" class="text-center">Platform</th>

        <cfif rc.tournament.getType().getHasTeams() || rc.tournament.getTeamSize() gt 1>
            <th scope="col" class="text-center">Team</th>
        </cfif>
        <th scope="col" class="text-center">Streaming</th>
        <td class="text-end" data-orderable="false">
            <cfif  rc.tournament.hasplayer()>
                <a href="<cfoutput>#buildurl('tournament.export/tournament/#rc.tournament.getid()#')#</cfoutput>" target="_blank" type="button" class="btn btn-sm btn-primary playerExportBtn" data-tournamentid="<cfoutput>#rc.tournament.getid()#</cfoutput>"  data-bs-toggle="tooltip" data-bs-placement="top" title="Export Players">
                    <i class="bi bi-cloud-download-fill"></i>
                </a>
            </cfif>
            <cfif rc.tournament.getType().getHasTeams() || rc.tournament.getTeamSize() gt 1>
                <a href="<cfoutput>#buildurl('tournament.teamsoverview/tournament/#rc.tournament.getid()#')#</cfoutput>" class="btn btn-sm btn-primary teamAdminBtn"  data-bs-toggle="tooltip" data-bs-placement="top" data-bs-toggle="tooltip" data-bs-placement="top" title="Manage tournament teams">                  
                    <i class="bi bi-people-fill"></i>
                </a>
            </cfif>
            <cfif rc.tournament.countPlayersInTournament() lt 60>
                <button type="button" class="btn btn-sm btn-info playerAddBtn" data-tournamentid="<cfoutput>#rc.tournament.getid()#</cfoutput>"  data-bs-toggle="tooltip" data-bs-placement="top" title="Add player">
                    <i class="bi bi-person-plus-fill"></i>
                </button>
            </cfif>
        </th>
        </tr>
    </thead>
    <tbody class="table-dark">
        <cfset counter = 0>
        <cfloop array="#rc.tournament.getPlayer()#" item="item">
            <cfif item.getApproved() neq 1>
                <cfcontinue>
            </cfif>
            <cfset counter = incrementValue(counter)>
            <cfoutput>
                <tr>
                    <th scope="row">#counter#</th>
                    <td>
                        <cfif item.getAlternate()>
                            <i class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></i>
                        </cfif>    
                        #item.getgamername()#
                    </td>
                    <td class="text-center" data-order="#rc.uihelper.apexRankToSort(item.getPlayerRank())#">
                        <cfset rank = rc.uihelper.apexRankToIcon(item.getPlayerRank())>
                        <cfif rank.len()>
                            <img src="/assets/images/apexranks/#rank#.png" width="30px" title="#item.getPlayerRank()#" <cfif item.gettracker()>class="tracker-rank-glow"</cfif>>
                        <cfelse>
                            <i class="bi bi-shield-slash-fill" style="font-size: 1.3rem; color: grey;" title="Unknown Rank"></i>
                        </cfif>
                    </td>
                    <td class="text-center"  data-order="#item.getPlatform()#">
                        <i class="bi bi-#rc.uihelper.platformToIcon(item.getPlatform())# fs-6"></i>
                    </td>

                    <cfif rc.tournament.getType().getHasTeams() || rc.tournament.getTeamSize() gt 1>
                        <td class="text-center">
                            <cfif item.hasteam()>
                                #item.getTeam().getName()#
                            </cfif>
                        </td>
                    </cfif>
                    <td class="text-center"  data-order="#item.getstreaming()#">
                        <cfif item.getstreaming()>
                            <i class="bi bi-wifi text-success fs-6"></i>
                        <cfelse>
                            <i class="bi bi-wifi-off text-danger fs-6"></i>
                        </cfif>
                    </td>
                    <td class="text-end">
                        
                    <button type="button" data-playerid="#item.getid()#" data-playername="#item.getgamername()#" class="btn btn-sm btn-secondary playerdetailBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Edit player detals">
                        <i class="bi bi-pencil-fill"></i>
                    </button>

                    <cfif rc.uihelper.canReloadTrackerStats(item)>
                        <button type="button"  data-playerid="#item.getid()#" class="btn btn-sm btn-warning playerTrackerBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Refresh Tracker Data">
                            <i class="bi bi-arrow-repeat"></i>
                        </button>
                    </cfif>
                    <button type="button"  data-playerid="#item.getid()#" class="btn btn-sm btn-danger playerDeleteBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Delete player">
                        <i class="bi bi-trash"></i>
                    </button>

                    </td>
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
    </table>
</main>
</div>

			
