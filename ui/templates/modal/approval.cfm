

<cfimport prefix="fields" taglib="/ui/customtags/formfields">

<cfoutput>
	
	
	<form data-form="ticketApproval" id="modalForm" data-keyboard="false" data-backdrop="static" enctype="multipart/form-data" >
		<input type="hidden" name="ticketid" id="ticketid" value="#rc.ticketid#">
		<cfif structkeyexists(rc, 'subtask')>
			<input type="hidden" name="subtask" id="subtask" value="true">
		</cfif>
		<div class="panel-body">
			
			
			<cfif rc.approved eq 0>
				<div class="form-group">					
					<label class="control-label" for="notApproveReason" >Reason for not approving <span class="glyphicon glyphicon-asterisk" aria-hidden="true" style="color:red"></span></label>
					<select class="selectpicker form-control requireField" id="notApproveReason" name="notApproveReason" data-size="auto">
						<option value="" selected="selected"></option>
						<cfloop array="#rc.approvalReasons#" item="ar">
							<option value="#ar.getid()#">#ar.getReason()#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">				
					<fields:fileupload required="false" label="File Attachment" jirafield="fileupload" />				
				</div>
			</cfif>


			
			<div class="form-group">
				<label class="control-label" for="approvalNote" >Notes: <span class="glyphicon glyphicon-asterisk" aria-hidden="true" style="color:red"></span></label>
				<textarea class="form-control requireField" rows="5" id="approvalNote" name="approvalNote"></textarea>
			</div>
		</div>
	</form>
</cfoutput>