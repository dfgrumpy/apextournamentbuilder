component accessors="true" extends="model.base.baseget"    {

	property configService;
	property name="extraJS" type="any" default="";

    function init( ) {
        return this;
    }


	public any function getAllJS() {

		return this.getExtraJS();

	}

	public any function getBaseURL() {

		return getConfigService().getURLPrefix();

	}
	public any function formatDisplayDate(item) {

		var baseString = lcase(arguments.item);
		return baseString;

	}


	public any function dateTimeFormatter(item) {
		if (!isDate(arguments.item)){
			return item;
		}

		var d = DateTimeFormat(arguments.item, "short");
				
		
		return d;

	}
	public any function dateFormatter(item) {
		if (!isDate(arguments.item)){
			return arguments.item;
		}
		return dateFormat(arguments.item, "short");
	}


	public string function getEnvironment(){

		if (cgi.server_name contains "local" || cgi.server_name contains "dev" || cgi.dev_mode == true){
			return 'dev';
		}
		return 'prod';
	}


	public string function yesNoDisplay(data){

		if (len(arguments.data)) {
			return yesNoFormat(arguments.data);			
		}
		return 'No';


	}


	public string function apexRankToIcon(rank) {

		var passrank = replacenocase(trim(REReplaceNoCase(arguments.rank,'([^0-9]+).*','\1','ALL')), " ", "_");
		var ranks = ['Bronze','Silver','Gold','Platinum','Diamond','Master','Apex_Predator'];
		var selRank = listfirst(passrank, ' ');
		var rankid = arrayFindNoCase(ranks, selRank);
		
		if (rankid) {
			return replacenocase(ranks[rankid], " ", "_");
		}

		return arguments.rank;


	}
	
	public string function apexRankToSort(rank) {

		var passrank = replacenocase(trim(REReplaceNoCase(arguments.rank,'([^0-9]+).*','\1','ALL')), " ", "_");
		var ranks = ['Bronze','Silver','Gold','Platinum','Diamond','Master','Apex_Predator'];
		var selRank = listfirst(passrank, ' ');
		var rankid = arrayFindNoCase(ranks, selRank);
		
		if (rankid) {
			return rankid;
		}

		return 0;


	}

	public string function apexRankToSortString(rank) {

		var ranks = ['Bronze','Silver','Gold','Platinum','Diamond','Master','Apex_Predator'];
		var rankNum = apexRankToSort(arguments.rank);

		if (rankNum) {
			return ranks[rankNum].replace("_", " ");
		}

		return 0;


	}

	public boolean function canReloadTrackerStats(player) {

		var thisPlayer = arguments.player;
		if (!thisPlayer.getPlatform().len()) {
			return false;
		} else if (thisPlayer.getPlatform() == "pc" && !len(thisPlayer.getoriginname())) {
			return false;			
		}
		return true;

	}


	public string function closeDaysToClassColor(days){
		
		if (arguments.days GT 7) {
			return 'success';
		} else if (arguments.days lte 7 && arguments.days gt 2) {
			return 'warning';
		} else if (arguments.days lte 2) {
			return 'danger';
		}
		return 'primary';

	}

	public string function filledTeamsToClassColor(teams, size){

		// normalizing to values if team size was 3
		if (arguments.size eq 2) {
			arguments.teams = arguments.teams*2;
		} else if (arguments.size eq 1) {
			arguments.teams = arguments.teams*3;
		}

		
		if (arguments.teams gte 20) {
			return 'success';
		} else if (arguments.teams lte 19 && arguments.teams gt 2) {
			return 'warning';
		} else if (arguments.teams lte 2) {
			return 'danger';
		}
		return 'primary';

	}

	public string function regTypeToString(typeNum){

		if (arguments.typeNum == 1) {
			return 'Invitational';
		} else if (arguments.typeNum == 2) {
			return 'Open'
		}
		return 'Not Defined';
	}
		
	public string function playerCountToColor(plcount, tsize){
		
		if (plcount eq tsize) {
			return 'success';
		} else if (plcount lt tsize && plcount neq 0) {
			return 'warning';
		} else if (plcount eq 0) {
			return 'danger';
		}
		return 'primary';

	}

	public string function platformToIcon(platform){
		
		if (arguments.platform == "PC") {
			return 'pc-display-horizontal';
		} else if (arguments.platform == "XBL") {
			return 'xbox';
		} else if (arguments.platform == "PSN") {
			return 'playstation';
		}
		return 'dash-lg';

	}


	public boolean function canRegisterForTournament(tournament) {
		var thisTourney = arguments.tournament;
		var daysToClose  = datediff('d', now(), thisTourney?.getregistrationend() ?: thisTourney?.geteventdate());
		var isOpened  =  datediff('d', now(), thisTourney?.getregistrationstart() ?: dateadd('d', 1, now()) );
		var daysToCutoff  =  datediff('d', now(), thisTourney?.getregistrationcutoff() ?: dateadd('d', 1, now()) );

	
		if (!thisTourney.getregistrationenabled() || isOpened gt 0) {
			return false;
		}

		if (thisTourney.countPlayersInTournament(true) >= getconfigService().getapexmaxplayercount() && thisTourney.getlockonfull()){
			return false;
		}

		if (daysToClose gte 0){
			return true;
		}

		if (thisTourney.getallowlate() && daysToCutoff gte 0) {
			return true;
		}

		return false;

	}


	public string function getDaysToRegClose(tournament){

		var thisTourney = arguments.tournament;

		var close = datediff('d', now(), thistourney?.getregistrationend() ?: thistourney?.geteventdate());

		if (close gte 0) {
			return close;
		}

		
		if (isDate(thistourney.getregistrationcutoff()) && thisTourney.getallowlate() && close lt 0){
			return datediff('d', now(), thistourney.getregistrationcutoff());
		} else {
			return datediff('d', now(), thistourney?.getregistrationend());
		
		}

	}
	



}

