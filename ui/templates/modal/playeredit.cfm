

<cfimport prefix="displays" taglib="/ui/customtags/display">

<cfoutput>
	<form class="row g-3" data-form="playerdetail" id="modalForm" data-keyboard="true" data-backdrop="static"   autocomplete="off" novalidate>
        <input type="hidden" name="playerid" id="playerid" value="#rc.player.getid()#">
        <div class="col-md-12">
            <label for="playername" class="form-label">Player Name</label>
            <input type="text" class="form-control" id="playername" name="playername" value='#rc.player.getGamerName()#'  pattern=".{3,}" required>
            <div class="invalid-feedback">
                Player name must be at least 3 characters
            </div>
        </div>
        <div class="col-md-6">
            <label for="discord" class="form-label">Discord</label>
            <input type="text" class="form-control" id="discord" name="discord" value='#rc.player.getDiscord()#'>
        </div>
        <div class="col-md-6">
            <label for="Twitter" class="form-label">Twitter</label>
            <input type="text" class="form-control" id="Twitter" name="Twitter" value='#rc.player.getTwitter()#'>
        </div>
        <div class="col-md-6">
            <label for="Twitch" class="form-label">Twitch</label>
            <input type="text" class="form-control" id="Twitch" name="Twitch" value='#rc.player.getTwitch()#'>
        </div>
        <div class="col-md-6">
            <label for="Platform" class="form-label">Platform</label>
            <select id="Platform"  name="Platform" class="form-select">
                <option value="">----</option>
            <option <cfif rc.player.getPlatform() eq "xbl">selected</cfif>>XBL</option>
            <option <cfif rc.player.getPlatform() eq "psn">selected</cfif>>PSN</option>
            <option <cfif rc.player.getPlatform() eq "pc">selected</cfif>>PC</option>
            </select>
        </div>

        <div class="col-md-6">
            <label for="inputPassword4" class="form-label">Rank</label>
            <select id="rank"  name="rank" class="form-select">
                
                <option value="">----</option>
                    <cfset ranks = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master', 'Apex Predator']>
                    <cfloop item='r' array="#ranks#">
                        <option <cfif rc.player.getPlayerRank() contains r>selected</cfif>>#r#</option>
                    </cfloop>

            </select>
        </div>
        <div class="col-md-6">
            <label for="Level" class="form-label">Level</label>
            <input type="text" class="form-control" id="Level"  name="Level" value='#rc.player.getlevel()#'>
        </div>

        <div class="col-md-6">
            <label for="Kills" class="form-label">Kills</label>
            <input type="text" class="form-control" id="Kills"  name="Kills" value='#rc.player.getKills()#'>
        </div>

        <div class="col-md-6">
            <label for="Originname" class="form-label">Origin</label>
            <input type="text" class="form-control" id="Originname" name="Originname" value='#rc.player.getOriginname()#'>
        </div>
        <div class="col-md-6">
            <input <cfif rc.player.getStreaming()>checked</cfif> class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  Streaming" data-off="<i class='bi bi-x'></i>  Not Streaming" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="Streaming" id="Streaming">
        </div>
        <div class="col-md-6">
            <input <cfif rc.player.getAlternate()>checked</cfif> class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-x'></i>  Alternate" data-off="<i class='bi bi-check'></i> Not Alternate" data-onstyle="danger  py-1 " data-offstyle="success py-1" data-width="100%"  name="alternate" id="alternate">
        </div>



        <cfset rc.tournament = rc.player.getTournament()>
        <cfif rc.tournament.hasCustomConfig()>
            <div class="col-md-12">   
                <div class="col-md-12">
                    <div class="progress mt-2"  style="padding: 0; height: 2px;">
                        <div class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>  
                </div>
                <displays:playerregcustomedit rc="#rc#" playernumber="1" teamsize="1" individual="1"/>
            </div>
        </cfif>

        <!--- This button is here to js can force browser validation --->
        <button class="btn btn-primary visually-hidden" id="forceValidationBtn" type="submit" ></button>
    </form>
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