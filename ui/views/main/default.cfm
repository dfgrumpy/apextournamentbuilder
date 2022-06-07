<div class="container py-3">
  <main>
    <section class="py-0 text-center container">
      <cfif structKeyExists(rc, 'loginreset')>
        <div class="alert alert-dismissible alert-info text-start">
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          <h4 class="alert-heading">All Set!</h4>
          <p class="mb-0">Your password has been reset.  Please login using the login link above.</p>
        </div>
      </cfif>

      <div class="row py-lg-5">

         <div class="col-lg-10 col-md-8 mx-auto">
          <h1 class="fw-light">Create Your Apex Legends Tournament</h1>
          <p class="lead text-muted">
             Select from one of the options below to get started.
          </p>
        </div>
      </div>
    </section>


    <div class="row row-cols-1 row-cols-md-2 mb-2 text-center">
        <div class="col">
          <div class="card mb-4 rounded-3 shadow-sm border-success">
            <div class="card-header py-3">
              <h4 class="my-0 fw-normal">Open Tournament</h4>
            </div>
            <div class="card-body">
              <ul class="list-unstyled mt-3 mb-4">
                <li>Competitors Self Register</li>
                <li>Team and/or Individual</li>
                <li>Admin Controls</li>
                <li>Auto / Manual Team Creation</li>
                <li>Stats Linking</li>
              </ul>
              <a role="button" class="w-100 btn btn-lg btn-primary disabled" href="<cfoutput>#buildurl('tournament.create?step=start&type=open')#</cfoutput>" disabled>Coming Soon</a>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card mb-4 rounded-3 shadow-sm border-warning">
            <div class="card-header py-3">
              <h4 class="my-0 fw-normal">Invitational Tournament</h4>
            </div>
            <div class="card-body">
              <ul class="list-unstyled mt-3 mb-4">
                <li>Manual Entry</li>
                <li>Self Registration Invite Links</li>
                <li>Admin Controls</li>
                <li>Auto / Manual Team Creation</li>
                <li>Stats Linking</li>
              </ul>
              <cfif structKeyExists(session, 'loginuser')>
                <a role="button" class="w-100 btn btn-lg btn-primary" href="<cfoutput>#buildurl('tournament.create?step=tourney&type=invitational')#</cfoutput>">Continue</a>
              <cfelse>
                <a role="button" class="w-100 btn btn-lg btn-primary" href="<cfoutput>#buildurl('tournament.create?step=start&type=invitational')#</cfoutput>">Continue</a>
              </cfif>
            </div>
          </div>
        </div>
        
      </div>

  </main>

</div>


