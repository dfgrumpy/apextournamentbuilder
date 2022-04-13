


<cfoutput>
    <div class="container py-3" <cfif rc.tournament.hasteam()>style="max-width: 1320px;"</cfif> id="tournamentInfo" data-teamsize="#rc.tournament.getteamsize()#" data-tournamentid="#rc.tournament.getid()#">
        <div class="card text-white bg-primary mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col text-start">
                        <h5 class="mb-0">
                            <a href="#buildurl('tournament.view')#/#rc.foundkey#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Tournament Detials" role="button" class="text-decoration-none">
                                <i class="me-2 bi bi-person-badge fs-5 text-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#"></i>#rc.tournament.gettournamentname()#                    
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
        </div>
        <div class="container" <cfif rc.tournament.hasteam()>style="max-width: 1320px;"</cfif>>
            <div class="row">
                <div class="col-12">

                    <cfif ! rc.tournament.hasteam()>

                        <div class="h-100 p-5 bg-light border rounded-3 text-center">
                            <h1 class="display-5 fw-bold text-dark ">There are no teams for this tournament yet</h1>
                            <small>(Nothing to see here.  Move along.  Seriously, there is nothing here.)  </small>
                          </div>
                    <cfelse>
                        <div class="row mb-2">
                            <cfloop array="#rc.tournament.getTeam()#" index="team">
                                <cfif team.getApproved() neq 1>
                                    <cfcontinue>
                                </cfif>
                                <div class="col col-3 p-1 mb-1" style="width: 259px;">
                                    <div class="card text-white bg-primary border-#rc.uihelper.playerCountToColor(team.getplayer().len(), rc.tournament.getteamsize())#" >
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-12   text-center teamDetailBtn"  role="button"  id="teamName#team.getid()#" data-teamid="#team.getid()#">
                                                    #team.getname()#
                                                </div>
                                            </div>
                                        </div>
                                        <ul class="list-group list-group-sortable-teams list-group-flush text-nowrap overflow-hidden  bg-secondary" style="min-height: 120px;" data-teamid="#team.getid()#">
                                            <cfloop array="#team.getplayer()#" index="player">
                                                <li class="list-group-item d-flex  justify-content-between text-start" data-playerid="#player.getid()#" data-platform="#len(player.getplatform()) ? player.getplatform() : '0'#" data-rank="#len(player.getPlayerRank()) ? player.getPlayerRank() : '0'#">
                                                    <cfset rank = rc.uihelper.apexRankToIcon(player.getPlayerRank())>
                                                    <span class="playerdetailBtn" data-playerid="#player.getid()#" data-playername="#player.getgamername()#">
                                                    <cfif rank.len()>
                                                        <img src="/assets/images/apexranks/#rank#.png" height="20px" title="#player.getPlayerRank()#" class="m-0"> 
                                                    <cfelse>
                                                        <span class="bi bi-shield-slash-fill" style="font-size: 1rem; color: grey;" title="Unknown Rank"></span>
                                                    </cfif>
                                                    <cfif player.getAlternate()>
                                                        <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                                                    </cfif>    
                                                    #player.getgamername()#
                                                    </span>
                                                </li>
                                            </cfloop>
                                        </ul>
                                    </div>  
                                </div>       
                            </cfloop>
                        </div>
                    </cfif>
                </div>
            </div>
          </div>
        </div>
    </div>
    </cfoutput>
    
    