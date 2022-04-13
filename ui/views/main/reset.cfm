



<div class="container">
	<div class="row justify-content-center">
		<div class="col-10">

			<cfif structKeyExists(rc, 'fail')>
				<div class="alert alert-danger alert-warning">
					Unable to reset password. Email address submitted was invalid.
				</div>
			</cfif>
		</div>
	</div>
	<div class="row justify-content-center">
	  <div class="col-4">
	   	  <div class="card text-dark bg-light mb-4" >        
			<div class="card-body">
				<h5 class="card-title">We just need a couple pieces of info to reset your password.</h5>
				<p class="card-text">
					Please fill in the form to the right.
				</p>
			</div>
		  </div>
	  </div>
	  <div class="col-6">	   
		  <div class="alert alert-danger infoIncompleteForm d-none" role="alert">
			  Please fill out the form before continuing.
		  </div>
		  <div class="card text-white bg-primary mb-4" >
			  <div class="card-header">Your information</div>
			  <div class="card-body">
				  <p class="card-text">

					
					<form  action="<cfoutput>#buildurl('main.resetprocess')#</cfoutput>" id="forgotResetForm" method="post" class="needs-validation" novalidate>
						<div class="mb-3">
							<label for="email" class="form-label">Email address</label>
							<input class="form-control" type="email" id="emailaddr" name="emailaddr" required >
							<div class="invalid-feedback">
								Please enter the email address for your account
							</div>
						</div>
						<div class="mb-3">
							<label for="password" class="form-label">New Password</label>
							<input class="form-control" type="password" id="password" name="password" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"  required>
							<div class="invalid-feedback">
								Password must be at lest 8 characters and contain at lest 1 alpha and 1 numeric character.
							</div>
						</div>
						<div class="d-grid gap-2">
							<button type="submit" class="btn btn-success" >Reset Password</button>
						</div>                  
					</form>
  
				  </p>
			  </div>
			  </div>
	  </div>
	</div>
	
  </div>