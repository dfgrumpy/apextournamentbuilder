

<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>

<cfset variables.fw = caller.this />

<cfset thisTourney = attributes.rc.tournament>



<cfset num = attributes.playernumber>
<cfset teamsize = attributes.teamsize>


<cfif  attributes.rc.keyexists('playerreg') && isArray(attributes.rc.playerreg)>
    <cfset thisPlayer = attributes.rc.playerreg[num]>
    <cfloop array="#thisTourney.getCustomConfig()#" item="item">
        <cftry>
            <cfset thisPlayer['customfield_#item.getid()#_#num#'] = structFindValue(thisPlayer, item.getid(), "one")[1].owner.value>
        <cfcatch type="any">
            <cfset thisPlayer['customfield_#item.getid()#_#num#'] = item.gettype() eq 3 ? 0 : ''>
        </cfcatch>
        </cftry>
    </cfloop>
<cfelse>    
    <cfset thisPlayer = {}>
    <cfloop array="#thisTourney.getCustomConfig()#" item="item">
        <cfset thisPlayer['customfield_#item.getid()#_#num#'] = item.gettype() eq 3 ? 0 : ''>
    </cfloop>
</cfif>



<cfoutput>
<div class="card text-white bg-primary mb-3 mt-2" style="max-width: 60rem;">
    <div class="card-body">       

        <cfloop array="#thisTourney.getCustomConfig()#" item="item">

            <cfswitch expression="#item.getType()#">
                <cfcase value="1">
                    <p>
                        <label for="customfield_#item.getid()#_#num#" class="form-label">#item.getlabel()#</label>
                        <input type="text" class="form-control" id="customfield_#item.getid()#_#num#" name="customfield_#item.getid()#_#num#" value="#thisPlayer['customfield_#item.getid()#_#num#']#" <cfif item.getrequired()>required</cfif>>
                    </p>
                </cfcase>
                <cfcase value="2">
                    <p>
                        <label for="customfield_#item.getid()#_#num#" class="form-label">#item.getlabel()#</label>
                        <select id="customfield_#item.getid()#_#num#"  name="customfield_#item.getid()#_#num#" class="form-select" <cfif item.getrequired()>required</cfif>>
                            <option value="">----</option>
                            <cfloop index="itemval" list="#item.getvalues()#"> 
                                <option value="#itemval#" <cfif thisPlayer['customfield_#item.getid()#_#num#'] eq itemval>selected</cfif>>#itemval#</option>                                
                            </cfloop>
                        </select>
                    </p>
                </cfcase>
                <cfcase value="3">
                    <p>
                        <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  #item.getlabel()# : Yes" data-off="<i class='bi bi-x'></i> #item.getlabel()# : No" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="customfield_#item.getid()#_#num#" id="customfield_#item.getid()#_#num#" <cfif thisPlayer['customfield_#item.getid()#_#num#']>checked</cfif>>           
                    </p>
                </cfcase>
            </cfswitch>
        </cfloop>

    </div>
</div>

</cfoutput>