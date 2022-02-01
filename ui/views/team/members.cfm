<cfoutput>
    <div class="container px-2">
        <div class="row gx-2">      
            <cfloop item="thisPlayer" array="#rc.players#">
                <div class="col" >       
                        <div class="py-2 bg-dark rounded text-center">
                        <cfset rank = rc.uihelper.apexRankToIcon(thisPlayer.getRank())>
                         <div style="height: 115px; max-height: 115px;">
                            <p style="height: 75px;">
                            <img src="/assets/images/apexranks/#rank#.png"  title="#thisPlayer.getrank()#" style="width: 75px;">
                            </p>
                            #thisplayer.getgamername()#
                        </div>
                        <hr>
                        <dl class="row">
                            <dt class="text-warning">Platform</dt>
                            <dd >#thisplayer.getPlatform()#</dd>
                            <dt class="text-warning">Level</dt>
                            <dd >#thisplayer.getLevel()#</dd>
                            <dt class="text-warning">Kills</dt>
                            <dd >#NumberFormat(thisplayer.getKills())#</dd>
                            <dt class="text-warning">Twitter</dt>
                            <dd >#(thisplayer.gettwitter().len()) ? thisplayer.gettwitter() : 'N/A'#</dd>
                            <dt class="text-warning">Twitch</dt>
                            <dd >#(thisplayer.gettwitch().len()) ? thisplayer.gettwitch() : 'N/A'#</dd>
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