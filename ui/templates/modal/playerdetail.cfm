

<cfoutput>
        <div class="col-md-12">
            <table class="table table-striped table-bordered">
                <tbody>
                  <tr>
                    <td width="40%">Rank</td>
                    <td>
                      <cfset rank = rc.uihelper.apexRankToIcon(rc.player.getPlayerRank())>
                      <cfif rank.len()>
                          <img src="/assets/images/apexranks/#rank#.png" width="30px" class="me-2 <cfif rc.player.gettracker()>tracker-rank-glow</cfif>" title="#rc.player.getPlayerRank()#">
                      <cfelse>
                          <i class="bi bi-shield-slash-fill" style="font-size: 1.3rem; color: grey;" class="me-2" title="Unknown Rank"></i>
                      </cfif>
                      
                      #rc.player.getPlayerRank()#</td>
                  </tr>
                  <tr>
                    <td>Platform</td>
                    <td>#rc.player.getPlatform()#</td>
                  </tr>
                  <tr>
                    <td>Twitter</td>
                    <td>#rc.player.getTwitter()#</td>
                  </tr>
                  <tr>
                    <td>Twitch</td>
                    <td>#rc.player.getTwitch()#</td>
                  </tr>
                  <tr>
                    <td>Discord</td>
                    <td>#rc.player.getDiscord()#</td>
                  </tr>
                  <tr>
                    <td>Level</td>
                    <td>#rc.player.getlevel()#</td>
                  </tr>
                  <tr>
                    <td>Kills</td>
                    <td>#rc.player.getKills()#</td>
                  </tr>
                  <tr>
                    <td>Originname</td>
                    <td>#rc.player.getOriginname()#</td>
                  </tr>
                  <tr>
                    <td>Streaming</td>
                    <td>#YesNoFormat(rc.player.getStreaming())#</td>
                  </tr>
                </tbody>
              </table>
            </div>
        
        </div>
     
</cfoutput>

<script>

    $(function () {
        $('#showorigin').mouseover(function () {
            $('#Originname').attr('type', 'text');
        });
        
        $('#showorigin').mouseout(function () {
            $('#Originname').attr('type', 'password');
        });
    });
</script>