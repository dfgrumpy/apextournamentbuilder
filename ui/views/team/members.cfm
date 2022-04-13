<cfoutput>
    <div class="container px-2">

        
        <cfif rc.keyExists('approval') && rc.players.len()>
            <div class="row  border-bottom border-dark border-3 mb-2">     
                <cfif rc.players[1].getTeam().getApproved() neq 0>
                    <div class="offset-4 col-4 mb-2">    
                <cfelse>
                    <div class="offset-2 col-8 mb-2">    
                </cfif>
                    <div class="btn-group pt-1 d-flex" roll="group">
                        <cfif rc.players[1].getTeam().getApproved() eq 1>
                            <button type="button" id="rescindTeamBtn" class="btn btn-sm btn-danger rescindTeamBtn" data-teamid="#rc.teamid#">
                                <i class="bi bi-x-lg me-2"></i> Rescind Approval
                            </button>
                        <cfelseif rc.players[1].getTeam().getApproved() eq -1>
                            <button type="button" id="rescindRejectTeamBtn" class="btn btn-sm btn-danger rescindRejectTeamBtn" data-teamid="#rc.teamid#">
                                <i class="bi bi-x-lg me-2"></i> Rescind Rejection
                            </button>
                        <cfelse>
                            <button type="button" id="approveTeamBtn" class="btn btn-sm btn-success approveTeamBtn" data-teamid="#rc.teamid#">
                                <i class="bi bi-check-lg me-2"></i> Approve Team
                            </button>
                            <button type="button" id="rejectTeamBtn" class="btn btn-sm btn-danger rejectTeamBtn" data-teamid="#rc.teamid#">
                                <i class="bi bi-trash me-2"></i> Reject Team
                            </button>
                        </cfif>
                    </div>
                </div>
            </div>
        </cfif>
        <div class="row gx-2">      
            <cfloop item="thisPlayer" array="#rc.players#">
                <div class="col" >       
                    <div class="py-2 bg-dark rounded text-center">
                        <cfset rank = rc.uihelper.apexRankToIcon(thisPlayer.getPlayerRank())>
                         <div style="height: 115px; max-height: 115px;">
                            <p style="height: 75px;">
                                <cfif rank.len()>
                                    <img src="/assets/images/apexranks/#rank#.png"  title="#thisPlayer.getPlayerRank()#" style="width: 75px;" <cfif thisPlayer.gettracker()>class="tracker-rank-glow-big"</cfif>>
                                <cfelse>
                                    <i class="bi bi-shield-slash-fill" style="font-size: 4rem; color: grey;"></i>
                                </cfif>
                            </p>
                            <cfif thisplayer.getAlternate()>
                                <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                            </cfif>  
                            #thisplayer.getgamername()#
                        </div>
                        <hr>
                        <dl class="row">
                            <dt class="text-warning">Platform</dt>
                            <dd >#thisplayer.getPlatform().len() ? thisplayer.getPlatform() : 'Unknown'#</dd>
                            <dt class="text-warning">Level</dt>
                            <dd >#thisplayer.getLevel() neq "" ? thisplayer.getLevel() : 'Unknown'#</dd>
                            <dt class="text-warning">Kills</dt>
                            <dd >#NumberFormat(thisplayer.getKills())#</dd>
                            <dt class="text-warning">Twitter</dt>
                            <dd >#(thisplayer.gettwitter() neq "") ? thisplayer.gettwitter() : 'N/A'#</dd>
                            <dt class="text-warning">Twitch</dt>
                            <dd >#(thisplayer.gettwitch() neq "") ? thisplayer.gettwitch() : 'N/A'#</dd>
                            <dt class="text-warning">Streaming</dt>
                            <dd >#YesNoFormat(thisplayer.getStreaming())#</dd>
                        </dl>
                    </div>
                </div>
            </cfloop>


            <cfloop index="index" from="#rc.players.len()+1#" to="#rc.tournament.getteamsize()#">
                <div class="col rounded" style="height: 485px;">  
                    <div class="py-0 bg-dark rounded text-center">
                        <p class="border border-warning" style="height: 515px; ">&nbsp;
                        
                        </p>
                    </div>     
                </div>
            </cfloop>

        </div>
    </div>
</cfoutput>