<cfoutput>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-8   ">
        <h2 class="pb-2 border-bottom">Edit Tournament Information</h2>
        <form class="row g-3 needs-validation" novalidate id="tourneyform" method="post" action="">
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
                <div class="col-md-6">
                    <label for="eventdate" class="form-label">Tournament Date</label>
                    <input type="date" class="form-control" id="eventdate" name="eventdate" min="#dateformat(now(), 'yyyy-mm-dd')#" value="#rc.tournament.geteventdate()#" required>
                    <div class="invalid-feedback">
                        A tournament date is required
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="teamsize" class="form-label">Team Size</label>
                    <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="teamsize" name="teamsize">
                        <option value="1" <cfif rc.tournament.getteamsize() eq 1>selected</cfif>>One</option>
                        <option value="2" <cfif rc.tournament.getteamsize() eq 2>selected</cfif>>Two</option>
                        <option value="3" <cfif rc.tournament.getteamsize() eq 3>selected</cfif>>Three</option>
                    </select>
                </div>
            </div>

           <cfif rc.tournament.getregistrationtype() eq 2>
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
                <div class="row g-3">
                    <div class="col-8">
                        Allow late registration?&nbsp;&nbsp;&nbsp;
                        <div class="form-check form-check-inline">
                            <input class="form-check-input " type="radio" name="latereg" id="lateregy" value="yes" <cfif rc.tournament.getallowlate() eq 1>checked</cfif> >
                            <label class="form-check-label" for="lateregy">Yes</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="latereg" id="lateregn" value="no" <cfif rc.tournament.getallowlate() eq 0>checked</cfif> >
                            <label class="form-check-label" for="lateregn">No</label>
                        </div>
                    </div>
                </div>
            </cfif>
            <div class="row g-3">
                <div class="col-md-12 ">
                    <label for="exampleFormControlTextarea1" class="form-label">Tournament Description</label>
                    <textarea class="form-control summernote" id="exampleFormControlTextarea1" rows="5" id="tourneydetail" name="tourneydetail">#rc.tournament.getdetails()#</textarea>
                </div>


            </div>

            <div class="alert alert-dismissible alert-primary ">
                <div class="d-grid gap-2 d-md-flex justify-content-between">
                    <div class="d-grid gap-2 col-4 ">
                        <a href="#buildurl('tournament.detail/tournament/#rc.tournament.getid()#')#" type="button" class="btn btn-danger">Cancel</a>
                    </div>
                    <div class="d-grid gap-2 col-4 text-end">
                        <button class="btn btn-success" type="submit">Save Changes</button>
                    </div>
                </div>
            </div>
        </form>
</div>
</div>
</cfoutput>