


<cfoutput>
<div class="container py-3" style="max-width: 1320px;" id="tournamentInfo" data-teamsize="#rc.tournament.getteamsize()#" data-tournamentid="#rc.tournament.getid()#">
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col text-start">
                    <h5 class="mb-0">
                        <a class="text-decoration-none" href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" tabindex="-1" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View Tournament Detials" role="button">
                            <i class="pe-2   bi bi-person-badge fs-5 text-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#"></i>#rc.tournament.gettournamentname()#                    
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
            <div class="row text-center">
                <div class="col">
                    <div class="progress"  style="height: 5px;">
                        <div id="teamCompletionProgress" data-maxteams="#rc.maxteams#" class="progress-bar bg-#(rc.tournament.getregistrationtype() eq 1)? 'success':'warning'#" role="progressbar" style="width: #rc.teamprogress#%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="max-width: 1320px;">

        <div class="row">
          <div class="col-3 ps-0" >

            <!--- <cfif rc.tournament.countPlayersInTournament('ALL', true)> --->

                <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="manual-tab" data-bs-toggle="tab" data-bs-target="##manualContent" type="button" role="tab" aria-controls="manual" aria-selected="true">Manual</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="automatic-tab" data-bs-toggle="tab" data-bs-target="##automaticContent" type="button" role="tab" aria-controls="automatic" aria-selected="false">Automatic</button>
                    </li>
                </ul>


                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="manualContent" role="tabpanel" aria-labelledby="nav-home-tab">
                        <div class="alert alert-info m-0 p-0" role="alert">
                            <p class="fs-6 text-center m-0 mt-1">Drag players to teams or <br>from teams to master list</p>
                        </div>
                        <div class="d-grid gap-2 mt-0">        
                            <div class="btn-group pt-1">
                                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-funnel-fill"></i> <span id="platformLabel">Platform</span>
                                </button>
                                <ul class="dropdown-menu ">
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="platform" data-value="all">--- All ---</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="platform" data-value="PC">PC</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="platform" data-value="Console">Console</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="platform" data-value="0">Unknown</button></li>                        
                                </ul>
                                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-funnel-fill"></i> <span id="rankLabel">Rank</span>
                                </button>
                                <ul class="dropdown-menu ">
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="all">--- All ---</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Apex Predator"><img src="/assets/images/apexranks/apex_predator.png" height="20px" class="me-0 pe-2">Apex Predator</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Master"><img src="/assets/images/apexranks/master.png" height="20px" class="me-0 pe-2">Master</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Diamond"><img src="/assets/images/apexranks/diamond.png" height="20px" class="me-0 pe-2">Diamond</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Platinum"><img src="/assets/images/apexranks/platinum.png" height="20px" class="me-0 pe-2">Platinum</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Gold"><img src="/assets/images/apexranks/gold.png" height="20px" class="me-0 pe-2">Gold</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Silver"><img src="/assets/images/apexranks/silver.png" height="20px" class="me-0 pe-2">Silver</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="Bronze"><img src="/assets/images/apexranks/bronze.png" height="20px" class="me-0 pe-2">Bronze</button></li>
                                    <li><button class="dropdown-item playerFilterDDBTN" type="button" data-filter="rank" data-value="0"><span class="bi bi-shield-slash-fill  pe-2" style="font-size: 1rem; color: grey;" title="Unknown Rank"></span> Unknown</button></li>
                                </ul>
                            </div>
                        </div>
                        <ul class="list-group list-group-sortable-source list border border-secondary playerList bg-light" style="max-height: 530px; min-height: 45px; overflow-y:auto">
                            <cfloop array="#rc.noTeamPlayers#" item="player">
                                <cfif len(player.getplatform()) && player.getplatform() eq "PC">
                                    <cfset sortplatform = "PC">
                                <cfelse>
                                    <cfset sortplatform = len(player.getplatform()) ? 'Console':'0'> 
                                </cfif>
                                <cfset sortrank = player.getPlayerRank().len() ? rc.uihelper.apexRankToSortString(player.getPlayerRank()) : 0>
                                

                                <li data-playerid="#player.getid()#" class="list-group-item d-flex justify-content-between align-items-center" data-teamid="0"  data-playerid="#player.getid()#" data-platform="#sortplatform#" data-rank="#sortrank#">
                                    <span role="button" class="playerdetailBtn" data-playerid="#player.getid()#" data-playername="#player.getgamername()#">
                                        <cfset rank = rc.uihelper.apexRankToIcon(player.getPlayerRank())>
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
                                    <i class="bi bi-grip-vertical" style="font-size: 1.1rem; color: orange; cursor: grab;" role="button"></i>
                                </li>
                            </cfloop>
                        </ul>
                    </div>

                    <div class="tab-pane fade " id="automaticContent" role="tabpanel" aria-labelledby="nav-home-tab">
                        

                        <div class="card-body">
                            <label for="teamsize" class="form-label fs-5"> Autofill teams by:</label>
                            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="autofilltype" name="autofilltype">
                                <option value="0"  >-----</option>
                                <option value="1" >Random</option>
                                <option value="2" >Rank</option>
                                <option value="3" >Rank Group</option>
                            </select>
                            <hr>
                            <p class="fs-5">Extra Conditions:</p>
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <input class="form-check-input me-1" type="checkbox" value="1" name="singleconsole" id="singleconsole">
                                    One console player per team
                                    <p> <small>If possible, each team should have at least one console player.</small></p>
                                </li>
                                <li class="list-group-item list-group-item-danger">
                                    <input class="form-check-input me-1" type="checkbox" value="1" name="resetall" id="resetall">
                                    Reset All Teams
                                    <p>
                                        <small>This will remove all players from teams before running autofill.<br><br> 
                                        <strong>THIS WILL AFFECT PLAYERS THAT REGISTERED AS A TEAM.</strong><br><br> 
                                        <strong>THIS IS PERMANENT AND IRREVERSIBLE.</strong>
                                        </small>
                                    </p>
                                </li>
                            </ul>
                            <hr>

                            <div class="d-grid gap-2">
                                <button type="button" class="mt-0 btn btn-info autofillBtn" data-tournamentid="#rc.tournament.getid()#" >
                                    Process Autofill
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            <!--- <cfelse>
                <div class="alert alert-light text-center" role="alert">
                    <p class="text-danger">There are no approved players.</p>                        
                    <div class="d-grid gap-2">
                        <a class="btn btn-primary text-decoration-none" href="#buildurl('tournament.manageplayers?tournament/#rc.tournament.getid()#')#" role="button">
                            <i class="bi bi-person-fill me-2"></i>Manage Players
                        </a>
                    </div>
                </div>
            </cfif> --->

            <cfif rc.missingteams gt 0>
                <div class="d-grid gap-2">
                    <button type="button" class="mt-2 btn btn-sm btn-info teamAddBtn" data-tournamentid="#rc.tournament.getid()#"  data-bs-toggle="tooltip" data-bs-placement="top" title="Add Team">
                        <i class="bi bi-people-fill me-2"></i>Add Team
                    </button>
                    <button type="button" class="mt-0 btn btn-sm btn-warning teamGenerateAddBtn" data-missingteams='#rc.missingteams#' data-tournamentid="#rc.tournament.getid()#"  data-bs-toggle="tooltip" data-bs-placement="top" title="Fill tournament to max teams">
                        <i class="bi bi-people-fill me-2"></i>Generate Remaining Teams
                    </button>
                </div>
            </cfif>
        </div>
            <div class="col-9">
                <cfif rc.teamcountapproved gt 20>
                    
                <div class="alert alert-danger text-center" >
                    <strong>Warning!</strong> There are more than 20 teams approved for this tournament.
                </div>            

                </cfif>

                <div class="row mb-2">
                    <cfloop array="#rc.tournament.getTeam()#" index="team">
                        <cfif team.getApproved() neq 1>
                            <cfcontinue>
                        </cfif>
                        <div class="col col-3 px-1 mb-2">
                            <div class="card text-white bg-primary border-#rc.uihelper.playerCountToColor(team.getplayer().len(), rc.tournament.getteamsize())#" >
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-10 text-start teamDetailBtn" role="button"  id="teamName#team.getid()#" data-teamid="#team.getid()#">
                                             #team.getname()#
                                        </div>
                                        <div class="col-2 text-end">
                                            <i class="bi bi-pencil-fill text-end editTeamBtn" data-teamid="#team.getid()#" data-teamname="#team.getname()#" role="button"></i>
                                        </div>
                                    </div>
                                </div>
                                <ul class="list-group list-group-sortable-teams list-group-flush text-nowrap overflow-hidden  bg-secondary" style="min-height: 130px;" data-teamid="#team.getid()#">
                                    
                                    <cfloop array="#team.getplayer()#" index="player">
                                        <li class="list-group-item d-flex  justify-content-between text-start" data-playerid="#player.getid()#" data-platform="#len(player.getplatform()) ? player.getplatform() : '0'#" data-rank="#len(player.getPlayerRank()) ? player.getPlayerRank() : '0'#">
                                            <cfset rank = rc.uihelper.apexRankToIcon(player.getPlayerRank())>
                                            <span role="button" class="playerdetailBtn" data-playerid="#player.getid()#" data-playername="#player.getgamername()#">
                                            <cfif rank.len()>
                                                <img src="/assets/images/apexranks/#rank#.png" height="20px" title="#player.getPlayerRank()#" class="m-0 <cfif player.gettracker()>tracker-rank-glow-small</cfif>"> 
                                            <cfelse>
                                                <span class="bi bi-shield-slash-fill" style="font-size: 1rem; color: grey;" title="Unknown Rank"></span>
                                            </cfif>

                                            <cfif player.getAlternate()>
                                                <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                                            </cfif>    
                                            #player.getgamername()#
                                            </span>
                                            <i class="bi bi-grip-vertical" style="font-size: 1.1rem; color: orange; cursor: grab;" role="button"></i>
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

