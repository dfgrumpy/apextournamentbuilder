


<div class="container">
  
  <div class="row justify-content-center">
    <div class="col-4">
     
        <div class="card text-dark bg-light mb-4" >        
        <div class="card-body">
            <h5 class="card-title">Tell us about yourself</h5>
            <p class="card-text">This will create you an account so you can come back and manage your tournament later.  <p>Also, once you have an account you can create multiple tournaments under the same account.</p></p>
        </div>
        </div>

        <div class="card text-white bg-dark mb-4">
            <div class="card-header"></div>
            <div class="card-body">
                <h4 class="card-title">Already have an account?</h4>
                <p class="card-text">

                    <div class="d-grid gap-2">
                        <a class="btn btn-info" type="button" href="<cfoutput>#buildurl('main.login')#</cfoutput>">Login</a>
                    </div>
                </p>
            </div>
        </div>
    </div>
    <div class="col-4">
     
        <div class="alert alert-danger infoIncompleteForm d-none" role="alert">
            Please fill out the form before continuing.
        </div>
        <div class="card text-white bg-primary mb-4" >
            <div class="card-header">Your information</div>
            <div class="card-body">
                <p class="card-text">
                    <form id="infoForm" method="post" action="<cfoutput>#buildurl('tournament.userregister')#</cfoutput>">
                    <div class="mb-3">
                        <label for="fname" class="form-label">Your Name</label>
                        <input type="text" class="form-control" id="fname" name="fname" >
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp">
                        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-success" id="registerContinueBtn" onclick="mainNS.processRegister()">Continue</button>
                    </div>                  
                    </form>

                </p>
            </div>
            </div>
    </div>
  </div>
  
</div>