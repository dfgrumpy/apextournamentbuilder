

<div class="container py-3">
    <cfoutput>
        <div class="card text-white bg-primary mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col text-start">
                        <h5 class="mb-0">
                            <a href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Edit Tournament Detials">
                                #rc.tournament.gettournamentname()#                    
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
                        <cfset closeDays = datediff('d', now(), rc.tournament?.getregistrationend() ?: rc.tournament?.geteventdate())>
                        <div class="card rounded-3 shadow-sm text-white border-#rc.uihelper.closeDaysToClassColor(closeDays)#">
                            <div class="card-body">
                                <h1 class="card-title pricing-card-title">#closeDays#</h1>
                                <ul class="list-unstyled mt-3 mb-4">
                                <li>Days to Reg Close</li>
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
    </cfoutput>
  <main>
    <table class="table table-hover table-bordered" id="sortableTable">
    <thead class="table-light">
        <tr>
        <th scope="col">ID</th>
        <th scope="col">Player</th>
        <th scope="col" class="text-center">Rank</th>
        <th scope="col" >Level</th>
        <th scope="col">Platform</th>
        <th scope="col" class="text-center">Team</th>
        <th scope="col" class="text-center">Streaming</th>
        <td class="text-end" data-orderable="false">
            <a href="<cfoutput>#buildurl('tournament.manageteams/tournament/#rc.tournament.getid()#')#</cfoutput>" class="btn btn-sm btn-primary teamAdminBtn"  data-bs-toggle="tooltip" data-bs-placement="top" data-bs-toggle="tooltip" data-bs-placement="top" title="Manage tournament teams">                  
                  <i class="bi bi-people-fill"></i>
            </a>
            <button type="button" class="btn btn-sm btn-info playerAddBtn" data-tournamentid="<cfoutput>#rc.tournament.getid()#</cfoutput>"  data-bs-toggle="tooltip" data-bs-placement="top" title="Add player">
                <i class="bi bi-person-plus-fill"></i>
            </button>
        </th>
        </tr>
    </thead>
    <tbody class="table-dark">
        <cfset counter = 0>
        <cfloop array="#rc.tournament.getPlayer()#" item="item">
            <cfset counter = incrementValue(counter)>
            <cfoutput>
                <tr>
                    <th scope="row">#counter#</th>
                    <td>#item.getgamername()#</td>
                    <td class="text-center" data-order="#rc.uihelper.apexRankToSort(item.getRank())#">
                        <cfset rank = rc.uihelper.apexRankToIcon(item.getRank())>
                        <img src="/assets/images/apexranks/#rank#.png" width="30px" title="#item.getrank()#">
                    </td>
                    <td>#item.getLevel()#</td>
                    <td>#item.getPlatform()#</td>
                    <td class="text-center">
                        <cfif item.hasteam()>
                            #item.getTeam().getName()#
                        </cfif>
                    </td>
                    <td class="text-center"  data-order="#item.getstreaming()#">
                        <cfif item.getstreaming()>
                            <i class="bi bi-wifi text-success fs-6"></i>
                        <cfelse>
                            <i class="bi bi-wifi-off text-danger fs-6"></i>
                        </cfif>
                    </td>
                    <td class="text-end">
                        
                    <button type="button" data-playerid="#item.getid()#" data-playername="#item.getgamername()#" class="btn btn-sm btn-secondary playerdetailBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="View player detals">
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

			
