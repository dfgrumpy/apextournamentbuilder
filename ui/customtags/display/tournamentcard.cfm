<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>

<cfset variables.fw = caller.this />

<cfparam name="attributes.detail" default="true" >
<cfparam name="attributes.showregister" default="true" >

<cfif attributes.rc.keyexists('nexttournament')>
    <cfset thisTourney = attributes.rc.nexttournament>
<cfelse>
    <cfset thisTourney = attributes.rc.tournament>
</cfif>

<cfif structKeyExists(session, 'publicAcessType') && !structKeyExists(session, 'loginuser')>
    <cfset attributes.detail = false>
</cfif>

<div class="row" >
    <div class="col">
        <cfoutput>
        <div class="card text-white bg-primary mb-5  shadow-sm rounded">
            <div class="card-header">
                <div class="row">
                    <div class="col text-start">                    
                        <h4 class="mb-0">
                        <i class="bi bi-person-badge fs-5 text-#(thistourney.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#attributes.rc.uihelper.regTypeToString(thistourney.getregistrationtype())#"></i> 
                        
                        <cfif attributes.detail or structKeyExists(session, 'loginuser')>                        
                            <a href="#variables.fw.buildurl('tournament.detail/tournament/#thistourney.getid()#')#" role="button" class="text-decoration-none">
                        <cfelse>
                            <a href="#variables.fw.buildurl('tournament.view')#/#attributes.rc.foundkey#" role="button" class="text-decoration-none">                            
                        </cfif>
                        #thistourney.gettournamentname()#
                        </a>
                        </h4>
                    </div>
                    <cfif structKeyExists(session, 'loginuser')>
                        <div class="col text-end">
                            <div class="btn-group dropend mb-0 pb-0">
                                <button type="button" class="btn btn-info  btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                Manage Tournament
                                </button>
                                <ul class="dropdown-menu dropdown-menu-light rounded-0 p-2 border-light">

                                    <cfif variables.fw.getItem() NEQ "detail">
                                        <li class="m-1 pb-1">
                                        <a href="#variables.fw.buildurl('tournament.detail?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-secondary rounded-0">
                                            <i class="bi bi-info-circle-fill me-1"></i> Details
                                        </a>
                                        </li>
                                    </cfif>
                                    <li class="m-1 pb-1">
                                    <a href="#variables.fw.buildurl('tournament.edit?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-info rounded-0">
                                        <i class="bi bi-pencil-fill me-1"></i> Edit Tournament
                                    </a>
                                    </li>
                                    <cfif thistourney.getType().getHasTeams() || thistourney.getTeamSize() gt 1>
                                        <li class="m-1 pb-1">
                                            <a href="#variables.fw.buildurl('tournament.teamsoverview?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-secondary rounded-0">
                                                <i class="bi bi-people-fill me-1"></i> Manage Teams
                                            </a>
                                        </li>
                                        <li class="m-1 pb-1">
                                            <a href="#variables.fw.buildurl('tournament.teambuilder?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-primary rounded-0">
                                                <i class="bi bi-people-fill me-1"></i> Team Builder
                                            </a>
                                        </li>
                                    </cfif>
                                    <li class="m-1 pb-1">
                                        <a href="#variables.fw.buildurl('tournament.manageplayers?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-warning rounded-0" >
                                            <i class="bi bi-person-fill me-1"></i> Manage Players
                                        </a>
                                    </li>
                                    <li class="m-1 pb-1">
                                        <a href="#variables.fw.buildurl('tournament.manageapprovals?tournament/#thistourney.getid()#')#" class="dropdown-item btn text-light btn-success rounded-0" >
                                            <i class="bi bi-person-check-fill me-1"></i> Manage Approvals
                                        </a>
                                    </li>
                                    <cfif variables.fw.getItem() NEQ "mytournaments">
                                        <li><hr class="dropdown-divider"></li>
                                        <li class="m-1 pb-1">
                                            <a data-tournamentid="#thistourney.getid()#" data-relocate="true" class="btn text-light btn-danger dropdown-item tournamentDeleteBtn  rounded-0">
                                                <i class="bi bi-trash-fill me-1"></i> Delete Tournament
                                            </a>
                                        </li>
                                    </cfif>
                                </ul>
                            </div>
                        </div>                        
                    <cfelseif structKeyExists(session, 'publicAcessType')>  
                        <div class="col text-end">
                            <cfif session.publicAcessType eq 3 &&  thistourney.hasteam()>
                                <a href="#variables.fw.buildurl('tournament.view')#/#attributes.rc.foundkey#/teams" type="button" class="btn btn-sm btn-info teamAddBtn" data-tournamentid="#thistourney.getid()#" >
                                    <i class="bi bi-people-fill me-2"></i>View Teams
                                </a>
                            <cfelse>
                                <cfif attributes.showregister && attributes.rc.uihelper.canRegisterForTournament(thistourney)>
                                    <a type="button" class="btn btn-sm btn-success teamAddBtn" data-tournamentid="#thistourney.getid()#" href="#variables.fw.buildurl('tournament.register')#/#attributes.rc.foundkey#/">
                                        <i class="bi bi-people-fill me-2"></i>Register for Tournament
                                    </a>
                                <cfelse>                                
                                    <h5><span class="badge bg-danger">Registration Closed</span></h5>
                                </cfif>
                            </cfif>
                        </div>
                    </cfif>
                </div>
            </div>
            <div class="card-body">               
                <div class="row row-cols-2">                    
                    <div class="col text-center col-4">
                        <div class="row row-cols-2">
                            <div class="card rounded-3 shadow-sm text-white border-success m-1"  style="height: 145px; width: 145px;">
                                <div class="card-body">
                                    <h1 class="card-title pricing-card-title">#thistourney.countPlayersInTournament('ALL', false)#</h1>
                                    <ul class="list-unstyled mt-3 mb-4">
                                    <li>Players Registered</li>
                                    </ul>
                                </div>
                            </div>
                            <cfset closeDays = attributes.rc.uihelper.getDaysToRegClose(thistourney)>
                            <div class="card rounded-3 shadow-sm text-white border-#attributes.rc.uihelper.closeDaysToClassColor(closeDays)# m-1"  style="height: 145px; width: 145px;">
                                <div class="card-body">
                                    <h1 class="card-title pricing-card-title">#closeDays#</h1>
                                    <ul class="list-unstyled mt-3 mb-4">
                                    <li>Days till Reg Closes</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <cfif structKeyExists(session, 'loginuser')>
                            <div class="row row-cols-2">
                                <div class="m-1 card rounded-3 shadow-sm text-white border-#attributes.rc.uihelper.filledTeamsToClassColor(thistourney.filledTeamsForTournament(), thistourney.getteamsize())#"  style="height: 145px;  width: 145px;">
                                    <div class="card-body">
                                        <h1 class="card-title pricing-card-title">                                            
                                            <cfif thistourney.getType().getHasTeams() || thistourney.getTeamSize() gt 1>
                                                #thistourney.filledTeamsForTournament()#
                                            <cfelse>
                                                N/A
                                            </cfif>                                                
                                        </h1>
                                        <ul class="list-unstyled mt-3 mb-4">
                                        <li>Filled Teams</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="m-1 card rounded-3 shadow-sm text-white border-info"  style="height: 145px;  width: 145px;">
                                    <div class="card-body">
                                        <h1 class="card-title pricing-card-title">#thistourney.countStreamersForTournament()#</h1>
                                        <ul class="list-unstyled mt-3 mb-4">
                                        <li>Players Streaming</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>   
                        <cfelse>
                            <cfif thistourney.getid() eq 27 or thistourney.getid() eq 28>
                                <img src='/assets/images/military_png2.jpg' width="250">    
                            </cfif>
                        </cfif>
                    </div>
                    <div class="col col-8 text-white">
                        <div class="container">
                            <cfif !attributes.detail>
                                <div class="row">
                                    <div class="col-4">
                                    Tournament Host:
                                    </div>
                                    <div class="col">
                                        #thistourney.getOwner().getfullname()#
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-4">
                                    Contact Email:
                                    </div>
                                    <div class="col">
                                        #thistourney.getcontactemail()#
                                    </div>
                                </div>
                            </cfif>
                            <div class="row mt-2">
                                <div class="col-4">
                                Event Date:
                                </div>
                                <div class="col">
                                    #datetimeformat(thistourney.geteventdate(), 'MMMM d, YYYY - h:nn tt')#
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-4">
                                Time Zone:
                                </div>
                                <div class="col">
                                    #thistourney.gettimezone()#
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-4">
                                    Tournament Type:
                                </div>
                                <div class="col-4">
                                    #thistourney?.gettype()?.getname()#
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-4">
                                    Registration Type:
                                </div>
                                <div class="col-3">
                                   #attributes.rc.uihelper.regTypeToString(thistourney.getregistrationtype())#
                                </div>
                                <div class="col-3 text-end">
                                    Team Size:
                                </div>
                                <div class="col-2">
                                    #thistourney.getteamsize()#
                                </div>
                            </div>

                            <cfif attributes.detail>
                                <div class="row mt-2">
                                    <div class="col-4">
                                        Registration Enabled:
                                    </div>
                                    <div class="col-3">
                                        <cfif thistourney.getregistrationenabled()>
                                            <span class="badge bg-success">Yes</span>
                                        <cfelse>
                                            <span class="badge bg-danger">No</span>
                                        </cfif>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-4">
                                        Other Attributes:
                                    </div>
                                    <div class="col-8">
                                        <span class="badge bg-#thistourney.getindividual() ? 'success': 'danger'#">Individual Registration</span>
                                        <span class="badge bg-#thistourney.getemailrequired() ? 'success': 'danger'#">Email Required</span>
                                        <span class="badge bg-#thistourney.getlockonfull() ? 'success': 'danger'#">Lock On Full</span>
                                        <span class="badge bg-#thistourney.getallowlate() ? 'success': 'danger'#">Late Allowed</span>

                                    </div>
                                </div>
                            </cfif>
                            <cfif thistourney.getregistrationenabled()>
                                <div class="row mt-4 mb-1 pb-1 bg-secondary">
                                    <div class="col-8">
                                        Registration Dates:
                                    </div>
                                    <div class="col-4 text-end">
                                        <cfif thistourney.getallowlate()>
                                            <span class="badge bg-success">Late Allowed</span>
                                        <cfelse>
                                            <span class="badge bg-danger">No Late Reg</span>
                                        </cfif>
                                    </div>
                                </div>
                                <div class="row">                            
                                    <div class="col text-end">
                                        Opens: 
                                    </div> 
                                    <div class="col">
                                        #dateformat(thistourney.getregistrationstart(), 'm/dd/yyyy')#
                                    </div>
                                    <div class="col text-end">
                                        Closes:
                                    </div>
                                    <div class="col">
                                        #dateformat(thistourney.getregistrationend(), 'm/dd/yyyy')#
                                    </div>

                                    <cfif structKeyExists(session, 'loginuser') && thistourney.getallowlate()>
                                        <div class="col text-end">
                                            Cutoff:
                                        </div>
                                        <div class="col">
                                            #dateformat(thistourney.getregistrationcutoff(), 'm/d/yyyy')#
                                        </div>
                                    </cfif>
                                </div>
                            </cfif> 
                            <cfif structKeyExists(session, 'loginuser')>
                                <div class="progress mt-2"  style="padding: 0; height: 2px;">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>        
                                <div class="row mt-3">
                                    <div class="col-6">
                                        Public Tournament URL <i class="copyToClipboardBtn bi bi-clipboard-plus" type="button" data-clipboard="#attributes.rc.uihelper.getBaseURL()#/t/#thistourney.getviewkeyShort()# "></i>:
                                    </div>
                                    <div class="col-12 text-center mt-2">
                                        #attributes.rc.uihelper.getBaseURL()#/t/#thistourney.getviewkeyShort()#                                    
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-6">
                                        Admin URL <i class="copyToClipboardBtn bi bi-clipboard-plus" type="button" data-clipboard="#attributes.rc.uihelper.getBaseURL()#/t/#thistourney.getadminkeyShort()#"></i>:
                                    </div>
                                    <div class="col-12 text-center mt-2">
                                        <!--- #attributes.rc.uihelper.getBaseURL()#/t/#thistourney.getadminkeyShort()#                                     --->
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-6">
                                        Chat Bot Command:
                                    </div>
                                    <div class="col-12 text-left mt-2">
                                        !addcom !tourney $(urlfetch #attributes.rc.uihelper.getBaseURL()#/remote/mytournament/t/#thistourney.getviewkeyShort()#)
                                    </div>
                                </div>
                            </cfif>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
               &nbsp;
            </div>
        </div>
        </cfoutput>
    </div>  
</div>
