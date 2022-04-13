<cfoutput>
	<form class="row g-3 needs-validation" data-form="teamnew" id="modalForm" autocomplete="off" novalidate>
        <div class="row g-3">
            <div class="col-md-12">
                <label for="tourneyname" class="form-label">Team Name</label>
                <input type="text" class="form-control" id="teamname" name="teamname" pattern=".{2,}" value="" required>
                <div class="invalid-feedback">
                    Team name must be at lest 2 characters
                </div>
            </div>
        </div>
        <!--- This button is here to js can force browser validation --->
        <button class="btn btn-primary visually-hidden" id="forceValidationBtn" type="submit" ></button>
    </form>
</cfoutput>
