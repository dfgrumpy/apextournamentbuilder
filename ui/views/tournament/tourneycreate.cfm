

<cfimport prefix="fields" taglib="/ui/customtags/formfields">

<div class="container mt-4">
    <cfif !session.loginuser.getStatus()>
        <div class="alert alert-dismissible alert-warning">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        <h4 class="alert-heading">Warning!</h4>
        <p class="mb-0">Your email address has not been verified yet.  Once verified, refresh this screen to continue.</p>
      </div>
    </cfif>
  <div class="row justify-content-center">
    <div class="col-12">
        <h2 class="pb-2 border-bottom">Tournament Information</h2>
        <form class="row g-3 needs-validation" novalidate id="tourneyform" method="post" action="<cfoutput>#buildurl('tournament.createtourney')#</cfoutput>" onsubmit="tourneyNS.validateTournamentDates();">
            <input type="hidden" name="regtype" value="<cfoutput>#(rc.type eq 'invitational')? 1:2#</cfoutput>">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="tourneyname" class="form-label">Tournament Name</label>
                    <input type="text" class="form-control" id="tourneyname" name="tourneyname" pattern=".{5,}" required>
                     <div class="invalid-feedback">
                        Name must be at least 5 characters.
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="tourneyname" class="form-label">Contact Email</label>
                    <input type="email" class="form-control" id="contactemail" name="contactemail" >
                    <div class="invalid-feedback">
                        Please Enter an email address.
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-4">
                    <label for="eventdate" class="form-label">Tournament Date / Time</label>
                    <input type="datetime-local" class="form-control" id="eventdate" name="eventdate" step="3600" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#T00:00</cfoutput>" value="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#T00:00</cfoutput>" required>
                     <div class="invalid-feedback">
                        A tournament date is required
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="regend" class="form-label">Tournament Type</label>
                    <select class="form-select mb-3" id="tourneytype" name="tourneytype" required>
                        <option selected disabled value="">Choose...</option>
                        <cfloop array="#rc.tournamenttypes#" item="item">
                           <cfoutput> <option value="#item.getid()#" >#item.getname()#</option>   </cfoutput>                     
                        </cfloop>
                    </select>
                    <div class="invalid-feedback">
                     Please select a valid tournament type.
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="teamsize" class="form-label">Team Size</label>
                    <select class="form-select mb-3" aria-label=".form-select-lg example" id="teamsize" name="teamsize" required>
                        <option selected disabled value="">Choose...</option>
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                    </select>
                    <div class="invalid-feedback">
                     Please select a team size.
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <fields:timezone value="" />
                </div>
                <div class="col-md-6">  
                    <cfif rc.type EQ "invitational">
                        <label for="regenabled" class="form-label">Registration Enabled</label>
                        <input checked class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="regenabled" id="regenabled">
                    </cfif>
                </div>
            </div>

            <cfif rc.type EQ "invitational">
                <div class="row g-3">
                    <div class="col-4">
                        <label for="regstart" class="form-label">Registration Opens</label>
                        <input type="date" class="form-control" id="regstart" name="regstart" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                    </div>
                    <div class="col-4">
                        <label for="regend" class="form-label">Registration Closes</label>
                        <input type="date" class="form-control" id="regend" name="regend" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                    </div>
                    <div class="col-4">
                        <label for="regend" class="form-label">Late Cutoff</label>
                        <input type="date" class="form-control" id="cutoff" name="cutoff" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-3 text-center">
                        <label for="latereg" class="form-label">Allow Late Registration
                            <i style="color: #5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-trigger="focus" tabindex="0" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Allow registration after the close date but before the cut-off date.  These registrations will automatically be marked as alternates."></i>                            
                        </label>
                        <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="latereg" id="latereg">
                    </div>
                    <div class="col-3 text-center">
                        <label for="latereg" class="form-label ">Individual Registration
                            <i style="color: #5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-trigger="focus" tabindex="0" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Enabling this will allow an individual or partial teams to register. Only applies for tournaments with a team size of 2 or more."></i>                            
                        </label>
                        <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="individual" id="individual">
                    </div>
                    <div class="col-3 text-center">
                        <label for="latereg" class="form-label">Require Email
                            <i style="color: #5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-trigger="focus" tabindex="0" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Require registrants to enter an email address. We recommend this to be on so we can send registration status."></i>                            
                        </label>
                        <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="emailrequired" id="emailrequired">
                    </div>
                    <div class="col-3 text-center">
                        <label for="latereg" class="form-label">Lock on Full 
                            <i style="color: #5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-trigger="focus" tabindex="0" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Enabling this will prevent registration after the tournament is full. A FULL tournament has enough registrations to fill the tournament reguardless of approval status."></i>
                        </label>
                        <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="lockonfull" id="lockonfull">
                    </div>
                </div>
            </cfif>
            <div class="row g-3">
            </div>
            <div class="row g-3">
                <div class="col-md-12 ">
                    <label for="exampleFormControlTextarea1" class="form-label">Tournament Description</label>
                    <textarea class="form-control summernote" id="exampleFormControlTextarea1" rows="5" id="tourneydetail" name="tourneydetail"></textarea>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-12 ">
                    <label for="exampleFormControlTextarea2" class="form-label">Tournament Rules</label>
                    <textarea class="form-control summernote" id="exampleFormControlTextarea2" rows="5" id="tourneyrules" name="tourneyrules"></textarea>
                </div>
            </div>

            <div class="alert alert-dismissible alert-primary">
                <div class="col-12 d-md-flex">
                    <div class="d-grid gap-2 col-6 mx-auto ">
                        <cfif session.loginuser.getStatus()>
                            <button class="btn btn-success" type="submit">Create</button>
                        </cfif>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
