<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>

<cfparam name="attributes.value" default="" >

<cfset tfields = attributes.fields>
<cfset hasLocked = 0>

<cfoutput>

    <div class="accordion accordion-flush" id="accordionFlushExample">
        <div class="accordion-item">
          <h2 class="accordion-header" id="flush-headingOne">
            <button class="accordion-button collapsed btn-info" type="button" data-bs-toggle="collapse" data-bs-target="##flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
              Custom Fields
            </button>
          </h2>
          <div id="flush-collapseOne" class="accordion-collapse collapse show" aria-labelledby="flush-headingOne" data-bs-parent="##accordionFlushExample">
            <div class="accordion-body" style="padding-left: 0; padding-right: 0;">
                <table class="table table-sm">
                    <thead>
                        <tr>
                          <th scope="col" style="width: 20px;"></th>
                          <th scope="col" style="width: 125px;">Type</th>
                          <th scope="col" style="width: 200px;">Label</th>
                          <th scope="col">
                            Values
                            <i style="color: ##5bc0de;" class="bi bi-question-circle-fill" role="button" data-bs-trigger="focus" tabindex="0" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Selection options.  Only used when type SELECT is chosen."></i>
                        </th>
                        <th scope="col" style="width: 50px;">Required</th>
                          <th scope="col" style="width: 20px;">Delete</th>
                        </tr>
                      </thead>
                      <tbody>
                        <cfloop index="i" from="1" to="3">
                            <cfset thisField = ArrayIsDefined(tfields, i) ? tfields[i]:[]>
                            <cfset isLocked = thisfield?.isFieldInUse() ?: 0>
                            <cfset hasLocked = hasLocked+isLocked>
                            <input type="hidden" name="customrow_#i#" value="#thisField?.getid()#">
                            <tr class="<cfif isLocked>bg-warning</cfif>">
                            <th scope="row">#i#</th>
                            <td>
                                <select class="form-select" aria-label=".form-select-lg example" id="customtype_#i#" name="customtype_#i#" <cfif isLocked>disabled</cfif>>
                                    <option selected disabled value=""></option>
                                    <option value="1" <cfif thisField?.gettype() eq 1>selected</cfif>>Text</option>
                                    <option value="2" <cfif thisField?.gettype() eq 2>selected</cfif>>Select</option>
                                    <option value="3" <cfif thisField?.gettype() eq 3>selected</cfif>>Yes/No</option>
                                </select>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="customlabel_#i#" name="customlabel_#i#" value="#thisField?.getlabel()#" <cfif isLocked>disabled</cfif>>
                            </td>
                            <td>                                            
                                <input type="text" class="form-control" id="customvalues_#i#" name="customvalues_#i#" value="#thisField?.getvalues()#"  <cfif isLocked>disabled</cfif> <cfif thisField?.gettype() eq 2>required</cfif>>
                            </td>
                            <td>
                                <input class="toggleControl" data-height="50" type="checkbox" value="1" data-toggle="toggle"  data-style="quick" data-on="<i class='bi bi-check-lg'></i>" data-off="<i class='bi bi-x-lg'></i>" data-onstyle="success" data-offstyle="danger" data-width="100%"  name="customrequired_#i#" id="customrequired_#i#" <cfif thisField?.getrequired() ?: 0>checked</Cfif>  <cfif isLocked>disabled</cfif>>
                            </td>
                            <td class="text-center">
                                <cfif thisField?.getid() ?: 0>
                                    <input class="form-check-input" type="checkbox" id="customdelete_#i#" name="customdelete_#i#" value="1">
                                </cfif>
                            </td>
                            </tr>
                        </cfloop>
                      </tbody>
                  </table>
                <cfif hasLocked>
                    <div class="alert alert-warning">
                        <p class="mb-0"> NOTE: Fields are in use and can only be deleted</p>
                        </div>
                </cfif>                
            </div>
          </div>
        </div>
      </div>


</cfoutput>

