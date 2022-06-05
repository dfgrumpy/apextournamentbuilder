

<cfimport prefix="displays" taglib="/ui/customtags/display">
<cfimport prefix="fields" taglib="/ui/customtags/formfields">



<cfoutput>
<div class="container mt-4">
    <main>            
        <displays:tournamentcard rc="#rc#" detail="false" showregister="true" />
    </main>

    <div class="row justify-content-center">

        <div class="col-12">
            <h2 class="pb-2 border-bottom">Registration Information</h2>
        </div>

        <div class="col-12">
            <cfif  ! rc.uihelper.canRegisterForTournament(rc.tournament)>
                <div class="alert alert-secondary" role="alert">
                    <h4 class="alert-heading text-danger">Registration Closed</h4>
                    <p>Registration for this tournament is now closed.  We look forward to seeing you at future events.</p>
                    <hr>
                    <p class="mb-0">If you have any questions please use the contact email above.</p>
                </div>
                </div>
            <cfelse>
                <cfif rc.canregisterpc eq 2>
                    <div class="alert alert-info" role="alert">
                        <i class="bi bi-exclamation-triangle-fill text-danger" style="height: 25px;"></i> The tournament is full. However, you can still register.  Please note that you (or your team) will be listed as an alternate.
                    </div> 
                </cfif>
                
                <cfif rc.canregisterdate eq 2>
                    <div class="alert alert-warning" role="alert">
                        <i class="bi bi-exclamation-triangle-fill text-danger" style="height: 25px;"></i> The registration is closed. However, you can still register.  Please note that you (or your team) will be listed as an alternate.
                    </div> 
                </cfif>

                <form class="needs-validation" novalidate id="tourneyform" method="post" action="<cfoutput>#buildurl('tournament.register?#rc.foundkey#')#</cfoutput>">
                    <cfif rc.canregisterpc eq 2 or rc.canregisterdate eq 2>
                        <input type="hidden" name="alternate" id="alternate"  value="1">
                    </cfif>
                    
                    <input type="hidden" name="processregistration" id="processregistration"  value="1">
                    <div class="row mb-3">
                        <cfif rc.tournament.getregistrationsize() gt 1>
                            <div class="col-md-6">
                                <label for="teamname" class="form-label">Team Name <cfif rc.tournament.getindividual()><small>(Not Required)</small></cfif></label>
                                <input type="text" class="form-control" id="teamname" name="teamname" pattern=".{2,}" <cfif ! rc.tournament.getindividual()>required</cfif>>
                                <div class="invalid-feedback">
                                    Team Name must be at least 2 characters.
                                </div>
                            </div>
                        </cfif>
                        <div class="col-md-6">
                            <label for="playeremail" class="form-label">Your Email Address <cfif rc.tournament.getemailrequired()><small class="text-danger">(required)</cfif></label>
                            <input type="email" class="form-control" id="playeremail" name="playeremail" <cfif rc.tournament.getemailrequired()>required</cfif>>
                            <div class="invalid-feedback">
                                Please Enter an email address.
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <cfset customfields = rc.tournament.hasCustomConfig()>
                        <cfloop index="i" from="1" to="#rc.tournament.getregistrationsize()#">
                            <div class="col">                       
                                <displays:playerreg rc="#rc#" playernumber="#i#" teamsize="#rc.tournament.getregistrationsize()#" individual="#rc.tournament.getindividual()#"/>
                                <cfif customfields>
                                    <displays:playerregcustom rc="#rc#" playernumber="#i#" teamsize="#rc.tournament.getregistrationsize()#" individual="#rc.tournament.getindividual()#"/>
                                </cfif>
                            </div>
                        </cfloop>
                    </div>

                    <div class="alert alert-dismissible alert-primary">
                        <div class="col-12 d-md-flex">
                            <div class="d-grid col-5 mx-auto text-center ">
                            <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="fast" data-on="<i class='bi bi-check'></i>  Rules Agreed To" data-off="<i class='bi bi-x'></i>  I agree to tournament Rules" data-onstyle="success  py-1 " data-offstyle="danger py-1" data-width="100%"  name="rulesAgree" id="rulesAgree" required>
                            
                            <span id="rulesView" role="button" data-tournamentid="#rc.tournament.getid()#">(view rules)</span>
                            </div>
                            <div class="d-grid gap-3 col-3 mx-auto ">
                                
                                <button class="btn btn-success" type="submit">Register</button>
                            </div>
                        </div>
                    </div>

                </form>
                <div class="row g-3">
                    
                </div>
            </cfif>
        </div>
    </div>
</div>


</cfoutput>

