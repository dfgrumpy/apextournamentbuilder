

<cfimport prefix="displays" taglib="/ui/customtags/display">
<cfimport prefix="fields" taglib="/ui/customtags/formfields">



<cfoutput>
<div class="container mt-4">
    <main>            
        <displays:tournamentcard rc="#rc#" detail="false" showregister="false" />
    </main>

    <div class="row justify-content-center">

        <cfif rc.keyExists('saveerror')>
            <div class="col-12">
                <div class="alert alert-danger" role="alert">
                    <p>There was an error saving the registration : <strong>#rc.saveerror.detail#</strong></p>
                    <p class="border-top mt-2 pt-3">Please correct this error and try again.</p>
                </div> 
            </div>
        </cfif>

        <div class="col-12">
            <h2 class="pb-2 border-bottom">Registration Information</h2>
        </div>

        <div class="col-12">
            <cfif ! rc.uihelper.canRegisterForTournament(rc.tournament)>
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
                    <input type="hidden" name="canregisterpc" id="canregisterpc"  value="#rc.canregisterpc#">
                    <input type="hidden" name="canregisterdate" id="canregisterdate"  value="#rc.canregisterdate#">

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="teamname" class="form-label">Team Name</label>
                            <input type="text" class="form-control" id="teamname" name="teamname" pattern=".{2,}" value="#rc.teamname#" <cfif ! rc.tournament.getindividual()>required</cfif>>
                            <div class="invalid-feedback">
                                Team Name must be at least 2 characters.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="playeremail" class="form-label">Your Email Address</label>
                            <input type="email" class="form-control" id="playeremail" name="playeremail" value="#rc.playeremail#" <cfif rc.tournament.getemailrequired()>required</cfif>>
                            <div class="invalid-feedback">
                                Please Enter an email address.
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <cfset customfields = rc.tournament.hasCustomConfig()>
                        <cfloop index="i" from="1" to="#rc.tournament.getteamsize()#">
                            <div class="col">                       
                                <displays:playerreg rc="#rc#" playernumber="#i#" teamsize="#rc.tournament.getteamsize()#" individual="#rc.tournament.getindividual()#"/>
                                <cfif customfields>
                                    <displays:playerregcustom rc="#rc#" playernumber="#i#" teamsize="#rc.tournament.getteamsize()#" individual="#rc.tournament.getindividual()#"/>
                                </cfif>
                            </div>
                        </cfloop>
                    </div>

                    <div class="alert alert-dismissible alert-primary">
                        <div class="col-12 d-md-flex">
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
