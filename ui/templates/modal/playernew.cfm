

<cfimport prefix="displays" taglib="/ui/customtags/display">

<cfoutput>
	<form class="row g-3" data-form="playercreate" id="modalForm"  autocomplete="off" novalidate>
        <input type="hidden" name="tournamentid" id="tournamentid" value="#rc.tournament.getid()#">
        <div class="col-md-12">
            <label for="playername" class="form-label">Player Name</label>
            <input type="text" class="form-control" id="playername" name="playername"  pattern=".{3,}" value="" required>
            <div class="invalid-feedback">
                Player name must be at least 3 characters
            </div>
        </div>
        <div class="col-md-6">
            <label for="discord" class="form-label">Discord</label>
            <input type="text" class="form-control" id="discord" name="discord" value=''>
        </div>
        <div class="col-md-6">
            <label for="Twitter" class="form-label">Twitter</label>
            <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">@</span>
            <input type="text" class="form-control" id="Twitter" name="Twitter" value=''>
            </div>
        </div>
        <div class="col-md-6">
            <label for="Twitch" class="form-label">Twitch</label>
            <input type="text" class="form-control" id="Twitch" name="Twitch" value=''>
        </div>
        <div class="col-md-6">
            <label for="Platform" class="form-label">Platform</label>
            <select id="Platform"  name="Platform" class="form-select">
            <option value="">----</option>
            <option value="PC">PC</option>
            <option value="PSN">PSN</option>
            <option value="XBL">XBL</option>
            </select>
        </div>

        <div class="col-md-6">
            <label for="inputPassword4" class="form-label">Rank</label>
            <select id="rank"  name="rank" class="form-select">

                <option value="">----</option>
                <cfset ranks = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master', 'Apex Predator']>
                <cfloop item='r' array="#ranks#">
                    <option value="#r#">#r#</option>
                </cfloop>
            </select>
        </div>
        <div class="col-md-6">
            <label for="Level" class="form-label">Level</label>
            <input type="number" class="form-control" id="Level"  name="Level" value=''>
        </div>

        <div class="col-md-6">
            <label for="Kills" class="form-label">Kills</label>
            <input type="number" class="form-control" id="Kills"  name="Kills" value='' autocomplete="nope">
        </div>

        <div class="col-md-6">
            <label for="Originname" class="form-label">Origin <!---             <i id="showorigin" role="button" class="bi bi-eye-fill text-danger fs-6"></i> ---></label>
            <input type="text" class="form-control" id="Originname" name="Originname" value='' autocomplete="nope">
        </div>
        <div class="col-md-6">
            <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  Streaming" data-off="<i class='bi bi-x'></i>  Not Streaming" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="Streaming" id="Streaming">
        </div>
        <div class="col-md-6">
            <input class="toggleControl" data-height="28" type="checkbox" value="1"  data-toggle="toggle"  data-style="slow" data-on="<i class='bi bi-check'></i>  Load Stats" data-off="<i class='bi bi-x'></i>  Don't load stats" data-onstyle="info  py-1 " data-offstyle="danger py-1" data-width="100%"  name="trackerLoad" id="trackerLoad">
        </div>
     
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