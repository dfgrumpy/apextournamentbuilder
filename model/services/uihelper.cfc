component accessors="true" extends="model.base.baseget"    {

	property configService;
	property name="extraJS" type="any" default="";

    function init( ) {
        return this;
    }


	public any function getAllJS() {

		return this.getExtraJS();

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
		var rankid = arrayContainsNoCase(ranks, selRank);
		
		if (rankid) {
			return replacenocase(ranks[rankid], " ", "_");
		}

		return arguments.rank;


	}
	
	public string function apexRankToSort(rank) {

		var passrank = replacenocase(trim(REReplaceNoCase(arguments.rank,'([^0-9]+).*','\1','ALL')), " ", "_");
		var ranks = ['Bronze','Silver','Gold','Platinum','Diamond','Master','Apex_Predator'];
		var selRank = listfirst(passrank, ' ');
		var rankid = arrayContainsNoCase(ranks, selRank);
		
		if (rankid) {
			return rankid;
		}

		return 0;


	}

	public boolean function canReloadTrackerStats(player) {

		var thisPlayer = arguments.player;
		if (!thisPlayer.getPlatform().len()) {
			return false;
		} else if (thisPlayer.getPlatform() == "pc" && !thisPlayer.getoriginname().len()) {
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


}

