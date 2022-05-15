
<cfimport prefix="fields" taglib="/ui/customtags/formfields">
<cfoutput>
    <div class="container mt-4">
        <div class="row justify-content-center ">
          <div class="col-12">
              <h2 class="pb-2 border-bottom">Edit Tournament Information</h2>
              <form class="row g-3 needs-validation"  id="tourneyform" method="post" action="#buildurl('tournament.saveedit')#" onsubmit="tourneyNS.validateTournamentDates();" novalidate>
                  <input type="hidden" name="tournamentid" value="#rc.tournament.getid()#">
                  <div class="row g-3">
                      <div class="col-md-6">
                          <label for="tourneyname" class="form-label">Tournament Name</label>
                          <input type="text" class="form-control" id="tourneyname" name="tourneyname" pattern=".{5,}" required value="#rc.tournament.gettournamentname()#">
                           <div class="invalid-feedback">
                              Name must be at least 5 characters.
                          </div>
                      </div>
                      <div class="col-md-6">
                          <label for="tourneyname" class="form-label">Contact Email</label>
                          <input type="email" class="form-control" id="contactemail" name="contactemail" value="#rc.tournament.getcontactemail()#" >
                          <div class="invalid-feedback">
                              Please Enter an email address.
                          </div>
                      </div>
                  </div>
                  <div class="row g-3">
                      <div class="col-md-4">
                          <label for="eventdate" class="form-label">Tournament Date / Time</label>
                          <input type="datetime-local" class="form-control" id="eventdate" name="eventdate" step="3600" min="#dateformat(now(), 'yyyy-mm-dd')#T00:00" value="#rc.tournament.geteventdateForForm()#" required>
                           <div class="invalid-feedback">
                              A tournament date is required
                          </div>
                      </div>
                      <div class="col-md-4">
                          <label for="regend" class="form-label">Tournament Type</label>
                          <select class="form-select mb-3" id="tourneytype" name="tourneytype" required>
                              <cfloop array="#rc.tournamenttypes#" item="item">
                                  <option value="#item.getid()#" <cfif rc.tournament.gettype().getid() eq item.getid()>selected</cfif> >#item.getname()#</option>                        
                              </cfloop>
                          </select>
                          <div class="invalid-feedback">
                           Please select a valid tournament type.
                          </div>
                      </div>
                      <div class="col-md-4">
                          <label for="teamsize" class="form-label">Team Size</label>
                          <select class="form-select mb-3" aria-label=".form-select-lg example" id="teamsize" name="teamsize" <cfif rc.tournament.hasTeam()>disabled<cfelse>required</cfif>>
                              <option value="1" <cfif rc.tournament.getteamsize() eq 1>selected</cfif>>One</option>
                              <option value="2" <cfif rc.tournament.getteamsize() eq 2>selected</cfif>>Two</option>
                              <option value="3" <cfif rc.tournament.getteamsize() eq 3>selected</cfif>>Three</option>
                          </select>
                          <cfif rc.tournament.hasTeam()>
                            <div id="teamsizeHelp" class="form-text">
                                Tournament has teams so size is locked.
                            </div>
                        <cfelse>
                            <div class="invalid-feedback">
                             Please select a team size.
                            </div>
                        </cfif>
                      </div>
                  </div>
                  <div class="row g-3">
                      <div class="col-md-6">
                        <fields:timezone value="#rc.tournament.gettimezone()#" />                          
                      </div>
                      <div class="col-md-6">  
                          <cfif rc.tournament.getregistrationtype() eq 1>
                              <label for="regenabled" class="form-label">Registration Enabled</label>
                              <input <cfif rc.tournament.getregistrationenabled()>checked</cfif> class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="fast" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="regenabled" id="regenabled">
                          </cfif>
                      </div>
                  </div>
      
                  <cfif rc.tournament.getregistrationtype() eq 1>
                      <div class="row g-3">
                          <div class="col-4">
                              <label for="regstart" class="form-label">Registration Opens</label>
                              <input type="date" class="form-control" id="regstart" name="regstart" min="#dateformat(dateadd('d', -90, rc.tournament.geteventdate()), 'yyyy-mm-dd')#" value="#dateformat(rc.tournament.getregistrationstart(), 'yyyy-mm-dd')#" required>
                          </div>
                          <div class="col-4">
                              <label for="regend" class="form-label">Registration Closes</label>
                              <input type="date" class="form-control" id="regend" name="regend" min="#dateformat(dateadd('d', -90, rc.tournament.geteventdate()), 'yyyy-mm-dd')#" value="#dateformat(rc.tournament.getregistrationend(), 'yyyy-mm-dd')#" required>
                          </div>
                          <div class="col-4">
                              <label for="regend" class="form-label">Late Cutoff</label>
                              <input type="date" class="form-control" id="cutoff" name="cutoff" min="#dateformat(dateadd('d', -90, rc.tournament.geteventdate()), 'yyyy-mm-dd')#" value="#dateformat(rc.tournament.getregistrationcutoff(), 'yyyy-mm-dd')#" required>
                          </div>
                      </div>
                      <div class="row g-3">
                          <div class="col-3 text-center">
                              <label for="latereg" class="form-label">Allow Late Registration
                                  <i style="color: ##5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-container="body" data-bs-trigger="focus" tabindex="0" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Allow registration after the close date but before the cut-off date. These registrations will automatically be marked as alternates."></i>                            
                              </label>
                              <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="latereg" id="latereg" <cfif rc.tournament.getallowlate()>checked</cfif>>
                          </div>
                          <div class="col-3 text-center">
                              <label for="individual" class="form-label ">Individual Registration
                                  <i style="color: ##5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-container="body" data-bs-trigger="focus" tabindex="0" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Enabling this will allow an individual or partial teams to register. Only applies for tournaments with a team size of 2 or more."></i>                            
                              </label>
                              <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="individual" id="individual" <cfif rc.tournament.getindividual()>checked</cfif>>
                          </div>
                          <div class="col-3 text-center">
                              <label for="emailrequired" class="form-label">Require Email
                                  <i style="color: ##5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-container="body" data-bs-trigger="focus" tabindex="0" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Require registrants to enter an email address. We recommend this to be on so we can send registration status."></i>                            
                              </label>
                              <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="emailrequired" id="emailrequired" <cfif rc.tournament.getemailrequired()>checked</cfif>>
                          </div>
                          <div class="col-3 text-center">
                              <label for="lockonfull" class="form-label">Lock on Full 
                                  <i style="color: ##5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-container="body" data-bs-trigger="focus" tabindex="0" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Enabling this will prevent registration after the tournament is full. A FULL tournament has enough registrations to fill the tournament reguardless of approval status."></i>
                              </label>
                              <input class="toggleControl" data-height="48" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="success py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="lockonfull" id="lockonfull" <cfif rc.tournament.getlockonfull()>checked</cfif>>
                          </div>
                      </div>
                  </cfif>
                  <div class="row g-3">
                  </div>
                  <div class="row g-3">
                      <div class="col-md-12 ">
                          <label for="exampleFormControlTextarea1" class="form-label">Tournament Description</label>
                          <textarea class="form-control summernote" id="exampleFormControlTextarea1" rows="5" id="tourneydetail" name="tourneydetail">#rc.tournament.getdetails()#</textarea>
                      </div>
                  </div>
                  <div class="row g-3">
                      <div class="col-md-12 ">
                          <label for="exampleFormControlTextarea2" class="form-label">Tournament Rules</label>
                          <textarea class="form-control summernote" id="exampleFormControlTextarea2" rows="5" id="tourneyrules" name="tourneyrules">#rc.tournament.getrules()#</textarea>
                      </div>
                  </div>

                  <cfif rc.tournament.hasCustomConfig()>      
                    <div class="row g-3">
                        <div class="col-md-12 ">                            
                            <fields:tournamentcustom fields="#rc.tournament.getCustomConfig()#" />       
                        </div>
                    </div>
                </cfif>
                  <div class="row g-3">
                        <div class="col-md-3 pe-0 text-end">

                            <div class="alert alert-secondary  pe-0 rounded-0 text-info">
                                    <input class="form-check-input" type="checkbox" value="1" id="linkreset" name="linkreset">
                                    <label class="form-check-label" for="linkreset">
                                    Reset URL Links
                                    </label>
                            </div>
                        </div>
                        <div class="col-md-9 ps-0">                            
                            <div class="alert alert-secondary  ps-0 rounded-0">
                                <span class="ms-3">
                                   <strong>This will generate new admin and registration links for the tournament.</strong>
                                </span>
                            </div>
                        </div>
                  </div>
                  <div class="alert alert-primary">
                      <div class="col-12 text-center">
                            <div class="row">
                                <div class="d-grid gap-2 col-3 mx-auto">
                                    <button class="btn btn-warning" type="button" onclick="history.go(-1);">Cancel</button>
                                </div>
                                <div class="d-grid gap-2 col-3 mx-auto">
                                    <button class="btn btn-success w-20" type="submit">Save Changes</button>
                                </div>
                            </div>
                      </div>
                  </div>
                  
              </form>
          </div>
      </div>
</cfoutput>