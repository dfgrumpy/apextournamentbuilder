
<cfif isNull(rc.detail)>
	<div class="alert alert-warning alert-dismissible" role="alert">
	  <strong>Unable to load email alert detail</strong>
	</div>
<cfelse>
	<iframe width="100%" height="400px" frameborder="0" allowtransparency="true" 
			style="background: #FFFFFF;" id="modalIframe" src="about:blank" srcdoc="<cfoutput>#encodeForHTML(rc.detail.getbody())#</cfoutput>" > 
	</iframe>
	
	</div>
</cfif>

