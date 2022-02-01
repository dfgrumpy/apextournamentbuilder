


<div class="container py-3">
  <main>
<table class="table table-hover ">
  <thead class="table-light">
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Name</th>
      <th scope="col">Date</th>
      <th scope="col"  class="text-center">Players</th>
      <th scope="col">Type</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
    <cfloop array="#rc.tourneylist#" item="item">
        <cfoutput>
            <tr>
            <th scope="row">#item.getid()#</th>
            <td class="tourneyName">#item.gettournamentname()#</td>
            <td>#dateformat(item.geteventdate(), 'm/d/yyyy')#</td>
            <td class="text-center">#item.getPlayer().len()#</td>
            <td>
              <i class="bi bi-person-badge fs-5 text-#(item.getregistrationtype() eq 1)? 'success':'warning'#"  data-bs-toggle="tooltip" data-bs-placement="top" title="#rc.uihelper.regTypeToString(item.getregistrationtype())#"></i>
              #item?.gettype()?.getname()#            
            </td>
            <td class="text-end">
                <a href="#buildurl('tournament.detail/tournament/#item.getid()#')#" class="btn btn-sm btn-secondary"  data-bs-toggle="tooltip" data-bs-placement="top" title="View tournament detals"data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">                  
                  <i class="bi bi-info-lg"></i>
                </a>
                <a href="#buildurl('tournament.manageteams?tournament/#item.getid()#')#" role="button" class="btn btn-sm btn-primary"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage Teams">
                  <i class="bi bi-people-fill"></i>
                </a>
                <a href="#buildurl('tournament.manageplayers?tournament/#item.getid()#')#" role="button" class="btn btn-sm btn-warning"  data-bs-toggle="tooltip" data-bs-placement="top" title="Manage players in tournament">
                  <i class="bi bi-person-fill"></i>
                </a>
                <button type="button"  data-tournamentid="#item.getid()#" class="btn btn-sm btn-info tournamentEditeBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Edit tournament information">
                    <i class="bi bi-pencil-fill"></i>
                </button>
                <button type="button"  data-tournamentid="#item.getid()#" class="btn btn-sm btn-danger tournamentDeleteBtn"  data-bs-toggle="tooltip" data-bs-placement="top" title="Delete tournament">
                    <i class="bi bi-trash-fill"></i>
                </button>
            </td>
            </tr>
        </cfoutput>
    </cfloop>
  </tbody>
</table>
</main>
</div>


