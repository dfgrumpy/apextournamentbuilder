<cfoutput>
<div class="row row-cols-1 row-cols-md-2 text-center">
    <div class="col ">
        <div class="card-header text-center alert-short rounded-0 rounded-top border-dark  <cfif rc.section eq 'player'>text-success</cfif>" role="button" id="playerApprovalTab">
          Players
        </div>   
        <div class="row row-cols-1 row-cols-md-3 text-center ">
            <div class="col ">
                <div class="card  rounded-0 rounded-bottom shadow-sm text-white border-info">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="playercountregistered">#rc.tournament.countPlayersInTournament('all', false)#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Registered</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col ">
                <div class="card rounded-0 rounded-bottom shadow-sm text-white border-warning">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="playercountpending">#rc.tournament.countPlayersInTournament(0, false)#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Pending</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col ">
                <div class="card rounded-0 rounded-bottom shadow-sm text-white border-success">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="playercountapproved">#rc.tournament.countPlayersInTournament(1, false)#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Approved</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>   
    <div class="col">   
        <div class="card-header text-center alert-short rounded-0 rounded-top border-dark <cfif rc.section eq 'team'>text-success</cfif>"  role="button" id="teamApprovalTab">
            Teams
        </div>   
        <div class="row row-cols-1 row-cols-md-3 text-center  ">
            <div class="col">                    
                <div class="card rounded-0 rounded-bottom  shadow-sm text-white border-info">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="teamcountregistered">#rc.tournament.filledTeamsForTournament('all')#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Registered</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card rounded-0 rounded-bottom  shadow-sm text-white border-warning">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="teamcountpending">#rc.tournament.filledTeamsForTournament(0)#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Pending</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card rounded-0 rounded-bottom  shadow-sm text-white border-success">
                    <div class="card-body">
                        <h1 class="card-title pricing-card-title" id="teamcountapproved">#rc.tournament.filledTeamsForTournament(1)#</h1>
                        <ul class="list-unstyled mt-3 mb-4">
                        <li>Approved</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>   
    </div>      
</div>

<form method="get" action="#buildurl('tournament.manageapprovals?tournament/#rc.tournament.getid()#')#" id="sectionForm"></form>
</cfoutput>