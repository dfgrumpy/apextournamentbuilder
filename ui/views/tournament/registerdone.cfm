

<cfimport prefix="displays" taglib="/ui/customtags/display">
<cfimport prefix="fields" taglib="/ui/customtags/formfields">



<cfoutput>
    <div class="container mt-4">
        <main>            
            <displays:tournamentcard rc="#rc#" detail="false" showregister="false" />
        </main>

        <div class="row justify-content-center">

            <div class="col-12">
                <h2 class="pb-2 border-bottom">Registration Complete</h2>
            </div>

            <div class="col-12">
                <div class="p-5 mb-4 bg-light rounded-3">
                    <div class="container-fluid py-5">
                      <p class="col-12 fs-4 text-black">Your registration has been processed.  You will be notified when your registration is approved.  <br><br>Good luck in the tournament!</p>
                    </div>
                  </div>
            </div>
        </div>
    </div>

</cfoutput>

