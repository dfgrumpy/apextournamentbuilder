



<cfimport prefix="displays" taglib="/ui/customtags/display">

<div class="container py-3">
    <main>
        <cfif !isNull(rc.nexttournament)>
            <cfset nextid = rc.nexttournament.getid()>
            <h3 class="border-1 border-bottom border-success">Next Tournament</h3>       
            <displays:tournamentcard rc="#rc#"  detail="true"/>
        </cfif>
        <h3 class="border-1 border-bottom border-info">My Other Tournaments</h3>
       
        <table class="table table-hover ">
            <thead class="table-light">
            <tr>
                <th scope="col">Name</th>
                <th scope="col">Date</th>
                <th scope="col" class="text-center">Players</th>
                <th scope="col">Type</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <cfloop array="#rc.tourneylist#" item="item">
                <cfif item.getid() eq nextid>
                    <cfcontinue>
                </cfif>
                <cfoutput>
                    <tr>
                    <td class="tourneyName">
                        <a href="#buildurl('tournament.detail/tournament/#item.getid()#')#" role="button" class="text-decoration-none">
                        #item.gettournamentname()#
                        </a>
                    </td>
                    <td>#dateformat(item.geteventdate(), 'm/d/yyyy')#</td>
                    <td class="text-center">#item.getPlayer().len()#</td>
                    <td>
                        <i class="bi bi-person-badge fs-5 text-#(item.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(item.getregistrationtype())#"></i>
                        #item?.gettype()?.getname()#            
                    </td>
                    <td class="text-end">


                        <a href="#buildurl('tournament.detail?tournament/#item.getid()#')#" class="btn btn-sm btn-secondary">
                            <i class="bi bi-info-circle-fill"></i> 
                        </a>


                    </td>
                    </tr>
                </cfoutput>
            </cfloop>
            </tbody>
        </table>
    </main>
</div>
  
  
  