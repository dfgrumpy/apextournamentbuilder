    <cfoutput>
<div class="container py-3">
    <div class="card text-white bg-primary mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col text-start">                    
                    <h4 class="mb-0">
                    #rc.tournament.gettournamentname()#                    
                    </h4>
                </div>
                <div class="col text-end">

                <a href="#buildurl('tournament.manageplayers?tournament/#rc.tournament.getid()#')#" role="button" class="btn btn-sm btn-warning"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">
                  <i class="bi bi-people"></i>
                </a>
                <button type="button"  data-tournamentid="#rc.tournament.getid()#" class="btn btn-sm btn-info tournamentEditeBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Edit tournament information">
                    <i class="bi bi-pencil"></i>
                </button>
                <button type="button"  data-relocate="true" data-tournamentid="#rc.tournament.getid()#" class="btn btn-sm btn-danger tournamentDeleteBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Delete tournament">
                    <i class="bi bi-trash"></i>
                </button>

                </div>
            </div>
        </div>
        <div class="card-body">               
            <div class="row row-cols-3 ">                    
                <div class="col text-center col-2">
                    <div class="card rounded-3 shadow-sm text-white border-success mb-3" style="height: 145px;">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.tournament.getPlayer().len()#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Players Registered</li>
                            </ul>
                        </div>
                    </div>
                    <cfset closeDays = datediff('d', now(), rc.tournament?.getregistrationend() ?: rc.tournament?.geteventdate())>
                    <div class="card rounded-3 shadow-sm text-white border-#rc.uihelper.closeDaysToClassColor(closeDays)#"  style="height: 145px;">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#closeDays#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Days to Reg Close</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col text-center col-2">
                    <div class="card rounded-3 shadow-sm text-white border-info mb-3"  style="height: 145px;">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.tournament.filledTeamsForTournament()#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Filled Teams</li>
                            </ul>
                        </div>
                    </div>
                    <div class="card rounded-3 shadow-sm text-white border-info"  style="height: 145px;">
                        <div class="card-body">
                            <h1 class="card-title pricing-card-title">#rc.tournament.countStreamersForTournament()#</h1>
                            <ul class="list-unstyled mt-3 mb-4">
                            <li>Players Streaming</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col col-8">
                    <div class="container">
                        <div class="row">
                            <div class="col-4">
                            Tournament Host:
                            </div>
                            <div class="col">
                                #rc.tournament.getOwner().getfullname()#
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                            Event Date:
                            </div>
                            <div class="col">
                                #dateformat(rc.tournament.geteventdate(), 'long')#
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                                Tournament Type:
                            </div>
                            <div class="col-3">
                                #rc.tournament?.gettype()?.getname()#
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                                Registration Type:
                            </div>
                            <div class="col-3">
                               #rc.uihelper.regTypeToString(rc.tournament.getregistrationtype())#
                            </div>
                            <div class="col-3 text-end">
                                Team Size:
                            </div>
                            <div class="col-2">
                                #rc.tournament.getteamsize()#
                            </div>
                        </div>
                        <cfif rc.tournament.getregistrationtype() eq 2>
                            <div class="row mt-4 mb-1 pb-1 bg-secondary">
                                <div class="col-8">
                                    Registration Dates:
                                </div>
                                <div class="col-4 text-end">
                                    <cfif rc.tournament.getallowlate()>
                                        <span class="badge rounded-pill bg-success">Late Allowed</span>
                                    <cfelse>
                                        <span class="badge rounded-pill bg-danger">No Late Reg</span>
                                    </cfif>
                                </div>
                            </div>
                            <div class="row">                            
                                <div class="col text-end">
                                    Starts: 
                                </div> 
                                <div class="col">
                                    #dateformat(rc.tournament.getregistrationstart(), 'M/D/yyyy')#
                                </div>
                                <div class="col text-end">
                                    Closes:
                                </div>
                                <div class="col">
                                    #dateformat(rc.tournament.getregistrationend(), 'M/D/yyyy')#
                                </div>
                            </div>
                        </cfif>

                        <div class="row mt-4">                            
                            <div class="col-12" style="padding: 0;">
                            <div class="card text-dark bg-light mb-3">
                                <div class="card-body">
                                    #rc.tournament.getdetails()#
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

			
    </cfoutput>
