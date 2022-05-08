

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



 
<cfset thisPlayer = {}>
<cfloop array="#thisTourney.getCustomConfig()#" item="item">
    <cfset thisPlayer['customfield_#item.getid()#'] = item.gettype() eq 3 ? 0 : ''>
</cfloop>


<cfif structKeyExists(attributes.rc, 'player')>
    <cfloop array="#attributes.rc.player.getCustomData()#" item="pc">
        <cfset thisPlayer['customfield_#pc.getparentid()#'] = pc.getvalue()>
    </cfloop>
</cfif>



<cfoutput>
    <div class="card text-white bg-primary mb-3" style="max-width: 60rem;">
        <div class="card-header">Custom Data</div>
        <div class="card-body">       
            <cfloop array="#thisTourney.getCustomConfig()#" item="item">
                <cfswitch expression="#item.getType()#">
                    <cfcase value="1">
                        <p>
                            <label for="customfield_#item.getid()#" class="form-label">#item.getlabel()#</label>
                            <input type="text" class="form-control" id="customfield_#item.getid()#" name="customfield_#item.getid()#" value="#thisPlayer['customfield_#item.getid()#']#" <cfif item.getrequired()>required</cfif>>
                        </p>
                    </cfcase>
                    <cfcase value="2">
                        <p>
                            <label for="customfield_#item.getid()#" class="form-label">#item.getlabel()#</label>
                            <select id="customfield_#item.getid()#"  name="customfield_#item.getid()#" class="form-select" <cfif item.getrequired()>required</cfif>>
                                <option value="">----</option>
                                <cfloop index="itemval" list="#item.getvalues()#"> 
                                    <option value="#itemval#" <cfif thisPlayer['customfield_#item.getid()#'] eq itemval>selected</cfif>>#itemval#</option>                                
                                </cfloop>
                            </select>
                        </p>
                    </cfcase>
                    <cfcase value="3">
                        <p>
                            <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  #item.getlabel()# : Yes" data-off="<i class='bi bi-x'></i> #item.getlabel()# : No" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="customfield_#item.getid()#" id="customfield_#item.getid()#" <cfif thisPlayer['customfield_#item.getid()#']>checked</cfif>>           
                        </p>
                    </cfcase>
                </cfswitch>
            </cfloop>
        </div>
    </div>
</cfoutput>