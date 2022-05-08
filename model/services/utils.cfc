component accessors="true" hint="for team items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	property playerService;
	





	public any function getPlayerFromFormFields( required data, required any playernum = 1 ) {
	
		num = arguments.playernum;
		customdata = [];

		if  (arguments.data.tournament.hasCustomConfig()){
			customdata = getPlayerCustomFromData(arguments.data, num);
		}

		var player = {
			'playername' : arguments.data.keyExists('playername_#num#') ? arguments.data['playername_#num#'] : '',
			'platform' : arguments.data.keyExists('platform_#num#') ? arguments.data['platform_#num#'] :'',
			'Playerrank' : arguments.data.keyExists('rank_#num#') ? arguments.data['rank_#num#'] :'',
			'originname' : arguments.data.keyExists('originname_#num#') ? arguments.data['originname_#num#'] :'',
			'discord' : arguments.data.keyExists('discordname_#num#') ? arguments.data['discordname_#num#'] :'',
			'Twitter' : arguments.data.keyExists('twittername_#num#') ? arguments.data['twittername_#num#'] :'',
			'twitch' : arguments.data.keyExists('twitchname_#num#') ? arguments.data['twitchname_#num#'] :'',
			'streaming' : arguments.data.keyExists('streaming_#num#') ? arguments.data['streaming_#num#'] :'0',
			'Level' : '',
			'Kills' : '',
			'tracker' : false,
			'playerexists' : false,
			'playersaved' : false,
			'alternate' : arguments.data.keyExists('alternate') ? arguments.data.alternate : 0,
			'approved' : 0
		};


		if (customdata.len()) {
			player.customdata = customdata;
		}

		return player;

	}


	public any function buildShortLink(required string sourcekey){

		for (var i = 1; i lte 1000; i++) {

			try {
				var shortlink = generateShortLink();

				var data = {'shortlink': shortlink, 'linkkey' : arguments.sourcekey};
				
				var thisShort = entityNew("shortlink", data);
				entitysave(thisShort);
				ormflush();
				break;
				
			} catch(any e){ }
		}

		return shortlink;

	}


	private any function generateShortLink(){

		var chars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9";
  		//<!--- our radix is the total number of possible characters --->   
  		var radix=listlen(chars);
		var shortlink="";

		for (x = 1; x lte 8; x++){
			randnum=RandRange(1, radix);
         	shortlink= shortlink & listGetAt(chars,randnum);
		}

		return shortlink;

	}



	public any function verifyShortLink(required string shortlink){

		return  entityload("shortlink", {shortlink=arguments.shortlink}, true);

	}

	/*  SanitizeFilename - Sanitize a string to be safe for use as a filename by removing directory paths and invalid characters.	
		SanitizeFilename(filename, rulesList, replacementCharacter);
		rulesList: convertspacestounderscores, convertspacestodashes, convertdashtounderscore, convertunderscoretodash
		rulesList: nodash, forcelowercase, forceuppercase
		replacementCharacter: default = ""
		NOTE: Lowercases extension
		Written by SunStar Media https://www.sunstarmedia.com/
		3/18/2015 Initial UDF
		4/25/2018 Updated w/optional ICU4J support (to convert foreign characters to Latin-ASCII)
			https://gist.github.com/JamoCA/ec4617b066fc4bb601f620bc93bacb57
			Tested to pass NaughtyStrings test https://github.com/minimaxir/big-list-of-naughty-strings
		3/11/2021 Modernized, added maxLength, default unsafeCharRegex and fixed some bugs on edge cases;
		returns empty string if filename is "unrepairably safe".
	*/
	public string function localSanitizeFileName(
		string s="",
		string rules="",
		string replacementCharacter="",
		numeric maxLength=255,
		string unsafeCharRegex="[^A-Za-z0-9\-_]"unsafeCharRegex="[^A-Za-z0-9\-_]"
	) output=false hint="Sanitize a string to be safe for use as a filename by removing directory paths and invalid characters." {
		local.windowsReservedRe = "^(con|prn|aux|nul|com[0-9]|lpt[0-9])(\.[^.]*)?$";
		local.response = trim(javacast("string", arguments.s));
		local.response = listLast(listLast(local.response, "/"), "\").replaceAll("(?ms)\<[^>]*\>", "");
		if (left(local.response,1) is "." and listlen(local.response,".") is 1){
			return "";
		}

		/* Transliterate ICU4J CFC (optional; converts foreign characters to latin equivalents
			if (NOT structkeyExists(server, "Transliterator")){
				server.transliterator = createObject("component","transliterator");
			}
			local.response = server.Transliterator.transliterate('Latin-ASCII; [:Nonspacing Mark:] Remove; NFC;', local.response);
		*/
		/* JUnidecode https://github.com/gcardone/junidecode
			if (not structkeyExists(server, "jUnidecodeLib")){
				server.jUnidecodeLib = createObject("java", "net.gcardone.junidecode.Junidecode");
			}
			local.response = server.jUnidecodeLib.unidecode( local.response );
			local.response = trim(replaceNoCase(local.response, "[?]", "", "all"));
		*/
		
		local.ext = "";
		if (listLen(local.response,".") gt 1){
			local.ext = trim(listLast(local.response, "."));
		}
		local.response = trim(reReplaceNoCase(local.response, local.windowsReservedRe, "", "one"));
		if (ListLen(local.response,".") gt 1){
			if ((len(local.response) - len(local.ext)-1) gt 0){
				local.response = left(local.response, len(local.response) - len(local.ext)-1);
			}
			local.ext = trim(reReplaceNoCase(local.ext, local.windowsReservedRe, "", "one"));
			local.ext = rereplace(local.ext, "[^A-Za-z0-9]", "", "all");
		}

		if (len(arguments.unsafeCharRegex)){
			local.response = local.response.replaceAll(arguments.unsafeCharRegex, arguments.replacementCharacter);
		}

		if (listFindNoCase(arguments.rules, "convertSpacesToUnderscores")){
			local.response = local.response.replaceAll(" ", "_");
		} else if (listFindNoCase(arguments.rules, "convertSpacesToDashes")){
			local.response = local.response.replaceAll(" ", "-");
		}
		if (listFindNoCase(arguments.rules, "convertDashToUnderscore")){
			local.response = local.response.replaceAll("[\-]", "_");
		} else 	if (listFindNoCase(arguments.rules, "convertUnderscoreToDash")){
			local.response = local.response.replaceAll("[\_]", "-");
		} else {
			if (listFindNoCase(arguments.rules, "noDash")){
				local.response = local.response.replaceAll("[\-]", arguments.replacementCharacter);
			}
			if (listFindNoCase(arguments.rules, "noUnderscore")){
				local.response = local.response.replaceAll("[\_]", arguments.replacementCharacter);
			}
		}
		if (listFindNoCase(arguments.rules, "forceLowercase")){
			local.response = lCase(local.response);
		} else if (listFindNoCase(arguments.rules, "forceUppercase")){
			local.response = uCase(local.response);
		}
		local.extLength = len( local.ext );
		if (local.extLength) local.extLength += 1;
		if (arguments.maxLength gt 0 and (len(local.response)+local.extLength) gt arguments.maxLength){
			local.response = left(local.response, arguments.maxLength - local.extLength);
		}
		if (not local.extLength and not len(local.response)){
			local.response = "";
		} else if (not local.extLength){
			/* no extension */
		} else {
			local.response = local.response & "." & lCase(local.ext);
		}
		return local.response;
	}


	/**
	 * queryToCsv
	 * Allows us to pass in a query object and returns that data as a CSV.
	 * This is a refactor of Ben Nadel's method, http://www.bennadel.com/blog/1239-Updated-Converting-A-ColdFusion-Query-To-CSV-Using-QueryToCSV-.htm
	 * @param  {Query} 		q 				{required}	The cf query object to convert. E.g. pass in: qry.execute().getResult();
	 * @param  {Boolean} 	hr 				{required}	True if we should include a header row in our CSV, defaults to TRUE
	 * @param  {String} 	d 		 		{required}	Delimiter to use in CSV, defaults to a comma (,)
	 * @return {String}          								CSV content
	 */
	public string function queryToCsv(required query q, required boolean hr = true, required string d = ",", required string cols = ''){
		
		if (arguments.cols.len()) {
			var colNames	= listToArray( arguments.cols );
		} else {
			var colNames	= listToArray( lCase(arguments.q.columnlist) );
		}
		var	newLine 	= (chr(13) & chr(10));
		var	buffer 		= CreateObject('java','java.lang.StringBuffer').Init();

		// Check if we should include a header row
		if(arguments.hr){
			// append our header row 
			buffer.append( 
			  ArrayToList(colNames,arguments.d) & newLine
			);

		}

		// Loop over query and build csv rows
		for(var i=1; i <= arguments.q.recordcount; i=i+1){

			// this individual row
			var thisRow = [];

			// loop over column list
			for(var j=1; j <= arrayLen(colNames); j=j+1){

				// create our row
				thisRow[j] = replace( replace( arguments.q[colNames[j]][i],',','','all'),'""','""""','all' );

			}

			// Append new row to csv output
			buffer.append(
				JavaCast( 'string', ( ArrayToList( thisRow, arguments.d ) & iif(i < arguments.q.recordcount, "newLine","") ) )
			);
		}

		return buffer.toString();

	};


	public any function getCustomFromData(required any tourneydata){
		var tdata = arguments.tourneydata;
		var result = [];
		var idx = 1;
		for (i = 1; i <= 3; i++){
			item = 'CUSTOMLABEL_#i#';
			if ( (structKeyExists(tdata, item) && structKeyExists(tdata, "CUSTOMTYPE_#i#")) ||  structKeyExists(tdata, "customrow_#i#") ){
				result[idx] = {
					'type': structKeyExists(tdata, "CUSTOMTYPE_#i#") ? tdata['CUSTOMTYPE_#i#'] : '',
					'label': structKeyExists(tdata, "CUSTOMLABEL_#i#") ? tdata['CUSTOMLABEL_#i#'] : '',
					'values':structKeyExists(tdata, "CUSTOMVALUES_#i#") ? tdata['CUSTOMVALUES_#i#'] : '',
					'required': structKeyExists(tdata, "CUSTOMREQUIRED_#i#") ? 1:0,
					'rowid': structKeyExists(tdata, "customrow_#i#") ? tdata['customrow_#i#']:0,
					'delete': structKeyExists(tdata, "customdelete_#i#") ? 1:0
					
			 	}
			 	idx++;
			}
		}
		return result;

	}
	




	public any function getPlayerCustomFromData( required data, required any playernum = 1 ) {
		
		var thisTourney = arguments.data.tournament;

		var config = thisTourney.getCustomConfig();
		var thisVal = '';
		var idx = 1;
		for (conf in config) {

			field = "customfield_#conf.getid()#_#arguments.playernum#";

			if (structKeyExists(data, field)) {
				thisVal =  data['#field#']
			} else {
				if (conf.getType() eq 3){
					thisVal = 0;
				}
			}


			items[idx] = {'parentid' : conf.getid(),
					'value' : thisVal,
					'type' : conf.gettype()
			}

	
			idx++;
		}

		return items;

	}


	public any function getPlayerCustomFromEdit( required data, required any playernum = 1 ) {

		var counter = 1;
		var customVals = [];
		for (item in arguments.data) {
			if (item contains "customfield_") {
				customVals[counter] = {'parentid': item.listlast("_"), 'value' : arguments.data['#item#']};
				counter++;
			}
		}
	
		return customVals;

	}
	


}			