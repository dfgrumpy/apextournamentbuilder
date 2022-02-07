



<cfoutput>
<div class="container py-3" style="max-width: 1320px;" id="tournamentInfo" data-teamsize="#rc.tournament.getteamsize()#" data-tournamentid="#rc.tournament.getid()#">
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col text-start">
                    <h5 class="mb-0">
                        <a href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Tournament Detials">
                            <i class="pe-2   bi bi-person-badge fs-5 text-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#"></i>#rc.tournament.gettournamentname()#                    
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
                       
                    </div>
                </div>
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-info">
                       
                    </div>
                </div>
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-warning">
                       
                    </div>
                </div>
                <div class="col">
                    <div class="card rounded-3 shadow-sm text-white border-danger">
                       
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="max-width: 1320px;">
        <div class="row">
          <div class="col-3 ps-0" >

                <ul class="list-group list-group-sortable-source list border border-secondary playerList " style="max-height: 530px; overflow-y:auto">
                    <cfloop array="#rc.noTeamPlayers#" item="player">
                    <li data-playerid="#player.getid()#" class="list-group-item d-flex justify-content-between align-items-center" data-teamid="0">
                        <span>
                            <cfset rank = rc.uihelper.apexRankToIcon(player.getRank())>
                            <cfif rank.len()>
                                <img src="/assets/images/apexranks/#rank#.png" height="20px" title="#player.getrank()#" class="m-0"> 
                            <cfelse>
                                <span class="bi bi-shield-slash-fill" style="font-size: 1rem; color: grey;" title="Unknown Rank"></span>
                            </cfif>
                            #player.getgamername()#
                        </span>
                        <i class="bi bi-grip-vertical" style="font-size: 1.1rem; color: orange;" role="button"></i>
                    </li>
                </cfloop>
                </ul>
                <div class="d-grid gap-2">
                    <button type="button" class="mt-2 btn btn-sm btn-info teamAddBtn" data-tournamentid="#rc.tournament.getid()#"  data-bs-toggle="tooltip" data-bs-placement="top" title="Add player">
                        <i class="bi bi-people-fill"></i> Add Team
                    </button>
                </div>
          </div>
            <div class="col-9">
                <div class="row mb-2">
                    <cfloop array="#rc.tournament.getTeam()#" index="team">
                        <div class="col col-3 px-1 mb-2">
                            <div class="card text-white bg-primary border-#rc.uihelper.playerCountToColor(team.getplayer().len(), rc.tournament.getteamsize())#" >
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-10 text-start">
                                             #team.getname()#
                                        </div>
                                        <div class="col-2 text-end">
                                            <i class="bi bi-pencil-fill text-end"></i>
                                        </div>
                                    </div>
                                </div>
                                <ul class="list-group list-group-sortable-teams list-group-flush text-nowrap overflow-hidden " style="min-height: 130px;" data-teamid="#team.getid()#">
                                    
                                    <cfloop array="#team.getplayer()#" index="player">
                                        <li class="list-group-item d-flex  justify-content-between text-start" data-playerid="#player.getid()#">
                                            <cfset rank = rc.uihelper.apexRankToIcon(player.getRank())>
                                            <span>
                                            <cfif rank.len()>
                                                <img src="/assets/images/apexranks/#rank#.png" height="20px" title="#player.getrank()#" class="m-0"> 
                                            <cfelse>
                                                <span class="bi bi-shield-slash-fill" style="font-size: 1rem; color: grey;" title="Unknown Rank"></span>
                                            </cfif>
                                            #player.getgamername()#
                                            </span>
                                            <i class="bi bi-grip-vertical" style="font-size: 1.1rem; color: orange;" role="button"></i>
                                        </li>

                                    </cfloop>
                                    
                                </ul>
                            </div>  
                        </div>       
                    </cfloop>
                </div>
            </div>
        </div>
      </div>
    </div>
</div>
</cfoutput>

