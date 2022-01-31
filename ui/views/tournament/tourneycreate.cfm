
<div class="container">
  <div class="row justify-content-center">
    <div class="col-8   ">
        <h2 class="pb-2 border-bottom">Enter Tournament Information</h2>
        <form class="row g-3 needs-validation" novalidate id="tourneyform" method="post" action="<cfoutput>#buildurl('tournament.createtourney')#</cfoutput>">
            <input type="hidden" name="regtype" value="<cfoutput>#(rc.type eq 'invitational')? 1:2#</cfoutput>">
            <div class="row g-3">
                <div class="col-md-12">
                    <label for="tourneyname" class="form-label">Tournament Name</label>
                    <input type="text" class="form-control" id="tourneyname" name="tourneyname" pattern=".{5,}" required>
                     <div class="invalid-feedback">
                        Name must be at least 5 characters.
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="eventdate" class="form-label">Tournament Date</label>
                    <input type="date" class="form-control" id="eventdate" name="eventdate" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                     <div class="invalid-feedback">
                        A tournament date is required
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="teamsize" class="form-label">Team Size</label>
                    <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="teamsize" name="teamsize">
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3" selected>Three</option>
                    </select>
                </div>
            </div>

            <cfif rc.type NEQ "invitational">
                <div class="row g-3">
                    <div class="col-6">
                        <label for="regstart" class="form-label">Registration Opens</label>
                        <input type="date" class="form-control" id="regopens" name="regstart" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                    </div>
                    <div class="col-6">
                        <label for="regend" class="form-label">Registration Closes</label>
                        <input type="date" class="form-control" id="regend" name="regend" min="<cfoutput>#dateformat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-8">
                        Allow late registration?&nbsp;&nbsp;&nbsp;
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="latereg" id="lateregy" value="yes">
                            <label class="form-check-label" for="lateregy">Yes</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="latereg" id="lateregn" value="no" checked>
                            <label class="form-check-label" for="lateregn" checked >No</label>
                        </div>
                    </div>
                </div>
            </cfif>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="regend" class="form-label">Tournament Type</label>
                    <select class="form-select form-select-lg mb-3" id="tourneytype" name="tourneytype" required>
                        <option selected disabled value="">Choose...</option>
                        <cfloop array="#rc.tournamenttypes#" item="item">
                           <cfoutput> <option value="#item.getid()#" >#item.getname()#</option>   </cfoutput>                     
                        </cfloop>
                    </select>
                    <div class="invalid-feedback">
                     Please select a valid tournament type.
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-12 ">
                    <label for="exampleFormControlTextarea1" class="form-label">Tournament Description</label>
                    <textarea class="form-control summernote" id="exampleFormControlTextarea1" rows="5" id="tourneydetail" name="tourneydetail"></textarea>
                </div>


            </div>

            <div class="alert alert-dismissible alert-primary">
                <div class="col-12 d-md-flex">
                    <div class="d-grid gap-2 col-6 mx-auto ">
                        <button class="btn btn-success" type="submit">Create</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
