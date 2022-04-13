<cfoutput>
    <div class="row row-cols-1 row-cols-md-4 text-center justify-content-md-center">
        <div class="col">
            <div class="card rounded-3 shadow-sm text-white border-success">
                <div class="card-body">
                    <h1 class="card-title pricing-card-title" id="playerCountApproved">#rc.tournament.countPlayersInTournament(1, false)#</h1>
                    <ul class="list-unstyled mt-3 mb-4">
                    <li>Players Approved</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col">
            
            <div class="card rounded-3 shadow-sm text-white border-danger">
                <div class="card-body">
                    <h1 class="card-title pricing-card-title" id="playerCountPending">#rc.tournament.countPlayersInTournament(0, false)#</h1>
                    <ul class="list-unstyled mt-3 mb-4">
                    <li>Players Pending</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card rounded-3 shadow-sm text-white border-info">
                <div class="card-body">
                    <h1 class="card-title pricing-card-title" id="playerCountRejected">#rc.tournament.countPlayersInTournament(-1, false)#</h1>
                    <ul class="list-unstyled mt-3 mb-4">
                    <li>Players Rejected </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>    
</cfoutput>