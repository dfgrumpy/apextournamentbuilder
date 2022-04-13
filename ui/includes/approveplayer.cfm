<cfoutput>
<div class="card text-white bg-primary mb-3">
    <div class="card-header">
        <div class="row">
            <div class="col-5 text-start">                    
                <h5 class="mb-0">                            
                    <cfif rc.viewtype eq 1>
                        Approved Players
                    <cfelseif rc.viewtype eq -1>
                        Rejected Players                                
                    <cfelse>
                        Pending Player Approvals
                    </cfif>    
                </h5>
            </div>
            <div class="col  text-end">
                <cfif rc.viewtype neq -1>
                    <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/-1/section/#rc.section#')#" role="button" class="btn btn-sm btn-danger"  data-bs-toggle="tooltip" data-bs-placement="top">
                        <i class="bi bi-person-fill"></i> Show Rejected
                    </a>
                </cfif>
                <cfif rc.viewtype neq 1>
                    <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/1/section/#rc.section#')#" role="button" class="btn btn-sm btn-success"  data-bs-toggle="tooltip" data-bs-placement="top">
                        <i class="bi bi-person-fill"></i> Show Approved
                    </a>
                </cfif>
                <cfif rc.viewtype neq 0>
                    <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/0/section/#rc.section#')#" role="button" class="btn btn-sm btn-warning"  data-bs-toggle="tooltip" data-bs-placement="top">
                        <i class="bi bi-person"></i> Show Pending
                    </a>
                </cfif>
            </div>
        </div>
    </div>
    <div class="card-body" style="min-height: 550px;">               
        <table class="table table-hover table-bordered" id="sortableTable">
            <thead class="table-light">
                <tr>
                    <th scope="col">Player</th>
                    <th scope="col" class="text-center">Rank</th>
                    <th scope="col" class="text-center">Platform</th>                
                    <th scope="col" class="text-center">Streaming</th>
                    <th class="text-end" data-orderable="false"></th>
                </tr>
            </thead>
            <tbody class="table-dark">
                <cfset counter = 0>
                <cfloop array="#rc.tournament.getPlayer()#" item="item">
                    <cfif item.getApproved() != rc.viewtype || item.hasTeam()>
                        <cfcontinue>
                    </cfif>
                    <cfset counter = incrementValue(counter)>
                    <cfoutput>
                        <tr data-playerid="#item.getid()#">
                            <td>
                                <cfif item.getAlternate()>
                                    <i class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></i>
                                </cfif>    
                                <span  role="button" class="playerdetailBtn" data-playerid="#item.getid()#" data-playername="#item.getgamername()#">#item.getgamername()#</span>
                            </td>
                            <td class="text-center drop-shadow" data-order="#rc.uihelper.apexRankToSort(item.getPlayerRank())#">
                                <cfset rank = rc.uihelper.apexRankToIcon(item.getPlayerRank())>
                                <cfif rank.len()>
                                    <img src="/assets/images/apexranks/#rank#.png" width="30px" title="#item.getPlayerRank()#" <cfif item.gettracker()>class="tracker-rank-glow"</cfif>>
                                <cfelse>
                                    <i class="bi bi-shield-slash-fill" style="font-size: 1.3rem; color: grey;" title="Unknown Rank"></i>
                                </cfif>
                            </td>
                            <td class="text-center"  data-order="#item.getPlatform()#">
                                <i class="bi bi-#rc.uihelper.platformToIcon(item.getPlatform())# fs-6" title="#item.getPlatform()#"></i>
                            </td>
        
                            <td class="text-center"  data-order="#item.getstreaming()#">
                                <cfif item.getstreaming()>
                                    <i class="bi bi-wifi text-success fs-6" title="Yes"></i>
                                <cfelse>
                                    <i class="bi bi-wifi-off text-danger fs-6" title="No"></i>
                                </cfif>
                            </td>
                            <td class="text-end">
                                <cfif item.getApproved() eq 1>
                                    <button type="button" id="rescindPlayerBtn" class="btn btn-sm btn-danger rescindPlayerApproveBtn" data-playerid="#item.getid()#">
                                        <i class="bi bi-x-lg me-2"></i> Rescind Approval
                                    </button>
                                <cfelseif item.getApproved() eq -1>
                                    <button type="button" id="rescindPlayerTeamBtn" class="btn btn-sm btn-danger rescindPlayerRejectBtn" data-playerid="#item.getid()#">
                                        <i class="bi bi-x-lg me-2"></i> Rescind Rejection
                                    </button>
                                <cfelse>
                                    <button type="button" id="rejectPlayerBtn" class="btn btn-sm btn-danger rejectPlayerBtn" data-playerid="#item.getid()#">
                                        <i class="bi bi-trash me-0"></i> Reject
                                    </button>
                                    <button type="button" id="approvePlayerBtn" class="btn btn-sm btn-success approvePlayerBtn" data-playerid="#item.getid()#">
                                        <i class="bi bi-check-lg me-0"></i> Approve
                                    </button>
                                </cfif>
        
                            </td>
                        </tr>
                    </cfoutput>
                </cfloop>
            </tbody>
        </table>
    </div>
</div>
</cfoutput>