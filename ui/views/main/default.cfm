<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->

<div class="container py-3">
  <main>
    <section class="py-0 text-center container">
      <div class="row py-lg-5">
        <div class="col-lg-10 col-md-8 mx-auto">
          <h1 class="fw-light">Create Your Apex Legends Tournament</h1>
          <p class="lead text-muted">
              Start by either entering your competitors or have them signup on their own.
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
                <li>Notifications</li>
                <li>Stats linking</li>
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
                <li>Team or Individual</li>
                <li>Admin Controls</li>
                <li>Notifications</li>
                <li>Stats linking</li>
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


