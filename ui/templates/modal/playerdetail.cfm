

<cfoutput>
	<form class="row g-3" data-form="playerdetail" id="modalForm" data-keyboard="true" data-backdrop="static" autocomplete="off">
        <input type="hidden" name="playerid" id="playerid" value="#rc.player.getid()#">
        <div class="col-md-12">
            <label for="playername" class="form-label">Player Name</label>
            <input type="text" class="form-control" id="playername" name="playername" value='#rc.player.getGamerName()#'>
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
                        <option <cfif rc.player.getrank() contains r>selected</cfif>>#r#</option>
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
            <label for="Originname" class="form-label">Origin <i id="showorigin" role="button" class="bi bi-eye-fill text-danger fs-6"></i></label>
            <input type="password" class="form-control" id="Originname" name="Originname" value='#rc.player.getOriginname()#'>
        </div>
        <div class="col-md-8">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="Streaming" name="Streaming" <cfif rc.player.getStreaming()>checked</cfif>>
                <label class="form-check-label" for="flexSwitchCheckChecked">Streaming Tournament</label>
            </div>
        </div>

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