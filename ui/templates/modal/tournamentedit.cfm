<cfoutput>
	<form class="row g-3 needs-validation" data-form="tournamentedit" id="modalForm" autocomplete="off" novalidate>
        <div class="row g-3">
            <div class="col-md-12">
                <label for="tourneyname" class="form-label">Tournament Name</label>
                <input type="text" class="form-control" id="tourneyname" name="tourneyname" pattern=".{5,}" value="#rc.tournament.gettournamentname()#" required>
                <div class="invalid-feedback">
                    Name must be at least 5 characters.
                </div>
            </div>
        </div>
        <div class="row g-3">
            <div class="col-md-12">
                <label for="tourneyname" class="form-label">Tournament Contact Email</label>
                <input type="email" class="form-control" id="contactemail" name="contactemail" value="#rc.tournament.getcontactemail()#" >
                <div class="invalid-feedback">
                   Please Enter an email address.
                </div>
            </div>
        </div>
        <div class="row g-3">
            <div class="col-md-6">
                <label for="eventdate" class="form-label">Tournament Date</label>
                <input type="datetime-local" class="form-control" id="eventdate" name="eventdate" step="3600" min="#dateformat(now(), 'yyyy-mm-dd')#" value="#rc.tournament.geteventdateForForm()#" required>
                <div class="invalid-feedback">
                    A tournament date is required
                </div>
            </div>

            <div class="col-md-6">
                <label for="teamsize" class="form-label">Team Size</label>
                <select class="form-select form-select-lg mb-3 is-invalid" aria-label=".form-select-lg example" id="teamsize" name="teamsize" <Cfif rc.tournament.hasTeam()>disabled</cfif>>
                    <option value="1" <cfif rc.tournament.getteamsize() eq 1>selected</cfif>>One</option>
                    <option value="2" <cfif rc.tournament.getteamsize() eq 2>selected</cfif>>Two</option>
                    <option value="3" <cfif rc.tournament.getteamsize() eq 3>selected</cfif>>Three</option>
                </select>                
                <Cfif rc.tournament.hasTeam()>
                    <div class="invalid-feedback">
                        Tournament has teams so size can't be changed.
                    </div>
                </cfif>
            </div>
        </div>

        <cfif ! IsNull(rc.tournament.getregistrationstart())>
            <div class="row g-3">
                <div class="col-6">
                    <label for="regstart" class="form-label">Registration Opens</label>
                    <input type="date" class="form-control" id="regopens" name="regstart" value="#dateformat(rc.tournament.getregistrationstart(), 'yyyy-mm-dd')#" required>
                    
                </div>
                <div class="col-6">
                    <label for="regend" class="form-label">Registration Closes</label>
                    <input type="date" class="form-control" id="regend" name="regend" value="#dateformat(rc.tournament.getregistrationend(), 'yyyy-mm-dd')#" required>
                </div>
            </div>        
        </cfif>
        <div class="row g-3">
            <div class="col-md-6 mx-auto">
                <cfif ! IsNull(rc.tournament.getregistrationstart())>
                    <label for="latereg" class="form-label">Allow Late Registration?</label>
                    <input class="toggleControl" data-height="48" type="checkbox" value="1" <cfif rc.tournament.getallowlate() eq 1>checked</cfif> data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check-lg'></i>  Yes" data-off="<i class='bi bi-x-lg'></i>  No" data-onstyle="info  py-2 fs-5" data-offstyle="danger py-2 fs-5" data-width="100%"  name="latereg" id="latereg">
                </cfif>
            </div>
            <div class="col-md-6">
                <label for="regend" class="form-label">Tournament Type</label>
                <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="tourneytype" name="tourneytype">
                    <cfloop array="#rc.tournamenttypes#" item="item">
                        <option value="#item.getid()#" <cfif rc.tournament.gettype().getid() eq item.getid()>selected</cfif>>#item.getname()#</option>                        
                    </cfloop>
                </select>
            </div>
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
        <!--- This button is here to js can force browser validation --->
        <button class="btn btn-primary visually-hidden" id="forceValidationBtn" type="submit" ></button>
    </form>
</cfoutput>
