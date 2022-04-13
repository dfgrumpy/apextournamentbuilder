<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->


        

<div class="container">

    <cfif StructKeyExists(rc, 'invalid')>
        <div class="row justify-content-center">
            <div class="alert alert-dismissible alert-danger" style="max-width: 500px;">
                <strong>Oops!</strong> Login invalid. Please try again.
            </div>            
        </div>
    </cfif>
    <cfif StructKeyExists(rc, 'exists')>
        <div class="row justify-content-center">
            <div class="alert alert-dismissible alert-warning" style="max-width: 500px;">
                <strong>Oops!</strong> Email address entered already has an account.  Either login, or user a different email address.
            </div>            
        </div>
    </cfif>
    <div class="row justify-content-center">
        
        <main class="form-signin">
        
            <div class="card text-medium bg-primary mb-3">
                <div class="card-header bg-success text-white">Please Sign In</div>
                <div class="card-body">
                    <form method="post" action="<cfoutput>#buildurl('main.loginprocess')#</cfoutput>" class="needs-validation">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="emailaddress"  name="emailaddress" required>
                            <label for="floatingInput">Email Address</label>
                        </div>
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password" required>
                            <label for="floatingPassword">Password</label>
                        </div>
                        
                        <div class="btn-group d-flex" role="group">
                        <button class="w-100 btn btn-lg btn-info" type="button" id="forgotLoginBtn">Forgot Password</button>
                        <button class="w-100 btn btn-lg btn-success" type="submit">Continue</button>
                        </div>
                    </form>

                </div>
            </div>
        </main>
    </div>
</div>
