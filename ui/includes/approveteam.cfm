<cfoutput>
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-5 text-start">                    
                    <h5 class="mb-0">
                        
                        <cfif rc.viewtype eq 1>
                            Approved Teams
                        <cfelseif rc.viewtype eq -1>
                            Rejected Teams                                
                        <cfelse>
                            Pending Team Approvals
                        </cfif>
                        (<span id="approvalHDRCount">#rc.teamcounts.recordcount#</span>)            
                    </h5>
                </div>
                <div class="col  text-end">
                    <cfif rc.viewtype neq -1>
                        <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/-1/section/#rc.section#')#" role="button" class="btn btn-sm btn-danger"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">
                            <i class="bi bi-person-fill"></i> Show Rejected
                        </a>
                    </cfif>
                    <cfif rc.viewtype neq 1>
                        <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/1/section/#rc.section#')#" role="button" class="btn btn-sm btn-success"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">
                            <i class="bi bi-person-fill"></i> Show Approved
                        </a>
                    </cfif>
                    <cfif rc.viewtype neq 0>
                        <a href="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#/viewtype/0/section/#rc.section#')#" role="button" class="btn btn-sm btn-warning"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">
                            <i class="bi bi-person"></i> Show Pending
                        </a>
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
                    <div class="list-group eam-list-group-scroll border border-secondary teamDetailList" style="max-height: 475px; min-height: 475px; overflow-y:auto">
                        <cfloop query="#rc.teamcounts#">
                            <button type="button" data-teamid="#id#" data-approval="true" class="list-group-item d-flex justify-content-between align-items-center btn-link teamDetailListBtn">
                                <span >
                                    <cfif alternate>
                                        <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                                    </cfif>  
                                    <span id="teamName#id#">#name#</span>
                                </span>
                                <span class="badge bg-#rc.uihelper.playerCountToColor(playercount, rc.tournament.getteamsize())#" >#playercount#</span>
                            </button>
                        </cfloop>
                        <cfif !rc.teamcounts.recordcount>
                            <div class="list-group-item list-group-item-action bg-warning rounded-0">There is nothing to approve</div>
                        </cfif>
                    </div>

                    <div class="d-grid gap-2 mt-1 mb-1"></div>
                </div>
                <div class="col col-8 p-0" id="teamContent">
                </div>
            </div>
        </div>
    </div>

</cfoutput>