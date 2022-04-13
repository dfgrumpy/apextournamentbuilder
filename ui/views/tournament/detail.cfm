<!---  
TODO: if logged into any account you should be able to register
TODO: if logged in loading tournament via public url should ignore logged in user
--->

<cfimport prefix="displays" taglib="/ui/customtags/display">
<cfoutput>
    <div class="container py-3">
        <cfif rc.keyExists('showeditsave')>
            <div class="alert alert-success alert-dismissible fade show text-center " role="alert">
                <strong>Done!</strong> Edits to the tournament have been saved.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </cfif>
        <main>
            
            <displays:tournamentcard rc="#rc#" detail="true" />
                
            
            <cfif !structKeyExists(session, 'loginuser') && !rc.uihelper.canRegisterForTournament(rc.tournament)>
                <div class="alert alert-secondary" role="alert">
                    <h4 class="alert-heading text-danger">Registration Closed</h4>
                    <p>Registration for this tournament is now closed.  We look forward to seeing you at future events.</p>
                    <hr>
                    <p class="mb-0">If you have any questions please use the contact email above.</p>
                </div>
            </cfif>

            <div class="col-12" style="padding: 0;">
                <p class="fs-4 mb-2 border-2 border-bottom border-top  border-info">Tournament Details: </p>
                <div class="card text-dark bg-light mb-3">
                    <div class="card-body">
                        #rc.tournament.getdetails()#
                    </div>
                </div>
            </div>
            <cfif rc.tournament.getrules().len()>
                <div class="col-12 mt-4" style="padding: 0;">
                    <p class="fs-4 mb-2 border-2 border-bottom border-top border-danger">Tournament Rules: </p>
                    <div class="card text-dark bg-light mb-3">
                        <div class="card-body">
                            #rc.tournament.getrules()#
                        </div>
                    </div>
                </div>
            </cfif>
        </main>
    </div>
</cfoutput>
