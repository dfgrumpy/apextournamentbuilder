

<cfoutput>
	<form class="row g-3" data-form="playercreate" id="modalForm" autocomplete="off">
        <input type="hidden" name="tournamentid" id="tournamentid" value="#rc.tournament.getid()#">
        <div class="col-md-12">
            <label for="playername" class="form-label">Player Name</label>
            <input type="text" class="form-control" id="playername" name="playername" value=''>
        </div>
        <div class="col-md-6">
            <label for="discord" class="form-label">Discord</label>
            <input type="text" class="form-control" id="discord" name="discord" value=''>
        </div>
        <div class="col-md-6">
            <label for="Twitter" class="form-label">Twitter</label>
            <input type="text" class="form-control" id="Twitter" name="Twitter" value=''>
        </div>
        <div class="col-md-6">
            <label for="Twitch" class="form-label">Twitch</label>
            <input type="text" class="form-control" id="Twitch" name="Twitch" value=''>
        </div>
        <div class="col-md-6">
            <label for="Platform" class="form-label">Platform</label>
            <select id="Platform"  name="Platform" class="form-select">
            <option value="">----</option>
            <option>XBL</option>
            <option>PSN</option>
            <option>PC</option>
            </select>
        </div>

        <div class="col-md-6">
            <label for="inputPassword4" class="form-label">Rank</label>
            <select id="rank"  name="rank" class="form-select">

                <option value="">----</option>
                <cfset ranks = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master', 'Apex Predator']>
                <cfloop item='r' array="#ranks#">
                    <option >#r#</option>
                </cfloop>
            </select>
        </div>
        <div class="col-md-6">
            <label for="Level" class="form-label">Level</label>
            <input type="text" class="form-control" id="Level"  name="Level" value=''>
        </div>

        <div class="col-md-6">
            <label for="Kills" class="form-label">Kills</label>
            <input type="text" class="form-control" id="Kills"  name="Kills" value='' autocomplete="nope">
        </div>

        <div class="col-md-6">
            <label for="Originname" class="form-label">Origin <i id="showorigin" role="button" class="bi bi-eye-fill text-danger fs-6"></i></label>
            <input type="password" class="form-control" id="Originname" name="Originname" value='' autocomplete="nope">
        </div>
        <div class="col-md-6">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="Streaming" name="Streaming">
                <label class="form-check-label" for="Streaming">Streaming Tournament</label>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="trackerLoad" name="trackerLoad">
                <label class="form-check-label" for="trackerLoad">Load Tracker Stats</label>
            </div>
        </div>
            <div class="alert alert-dismissible alert-warning">
                <strong>Note:</strong> Tracker States can only be laoded if platform is pc w/ Origin name or console w/ player name.
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