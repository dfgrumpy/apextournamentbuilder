<cfoutput>
  <div class="container px-2">
      <div class="row gx-2">      
          <cfloop item="thisPlayer" array="#rc.players#">
              <div class="col" >       
                      <div class="py-2 bg-dark rounded text-center">
                      <cfset rank = rc.uihelper.apexRankToIcon(thisPlayer.getPlayerRank())>
                       <div style="height: 115px; max-height: 115px;">
                          <p style="height: 75px;">
                              <cfif rank.len()>
                                  <img src="/assets/images/apexranks/#rank#.png"  title="#thisPlayer.getPlayerRank()#" style="width: 75px;" <cfif thisPlayer.gettracker()>class="tracker-rank-glow-big"</cfif>>
                              <cfelse>
                                  <i class="bi bi-shield-slash-fill" style="font-size: 4rem; color: grey;"></i>
                              </cfif>
                          </p>
                          <cfif thisplayer.getAlternate()>
                              <span class="bi bi-brightness-low-fill text-warning fs-6" style="height: 25px;"></span>
                          </cfif>    
                          #thisplayer.getgamername()#
                      </div>
                      <hr>
                      <dl class="row">
                          <dt class="text-warning">Platform</dt>
                          <dd >#thisplayer.getPlatform().len() ? thisplayer.getPlatform() : 'Unknown'#</dd>
                          <dt class="text-warning">Level</dt>
                          <dd >#thisplayer.getLevel() neq "" ? thisplayer.getLevel() : 'Unknown'#</dd>
                          <dt class="text-warning">Kills</dt>
                          <dd >#NumberFormat(thisplayer.getKills())#</dd>
                          <dt class="text-warning">Twitter</dt>
                          <dd >#(thisplayer.gettwitter() neq "") ? thisplayer.gettwitter() : 'N/A'#</dd>
                          <dt class="text-warning">Twitch</dt>
                          <dd >#(thisplayer.gettwitch() neq "") ? thisplayer.gettwitch() : 'N/A'#</dd>
                          <dt class="text-warning">Streaming</dt>
                          <dd >#YesNoFormat(thisplayer.getStreaming())#</dd>
                      </dl>
                  </div>
              </div>
          </cfloop>


          <cfloop index="index" from="#rc.players.len()+1#" to="#rc.tournament.getteamsize()#">
              <div class="col rounded" style="height: 485px;">  
                  <div class="py-0 bg-dark rounded text-center">
                      <p class="border border-warning" style="height: 515px; ">&nbsp;
                      
                      </p>
                  </div>     
              </div>
          </cfloop>

      </div>
  </div>
</cfoutput>