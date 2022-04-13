
<cfoutput>
	<form class="row g-3 needs-validation" data-form="forgotLogin" id="modalForm" autocomplete="off" novalidate>
        <div class="row g-3">
            <div class="col-md-12">					
			    <input type="email" class="form-control" id="accountEmail" name="accountEmail" placeholder="Email Address" required>
                <div class="invalid-feedback">
                    Please enter your email address
                </div>
            </div>
        </div>
        <!--- This button is here to js can force browser validation --->
        <button class="btn btn-primary visually-hidden" id="forceValidationBtn" type="submit" ></button>
    </form>
</cfoutput>
