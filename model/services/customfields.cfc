component {
	
	public string function saveCustomFields( required array data, required any tournament ) {


		for (item in arguments.data) {
			try {
			var customfield = {
				'type' : item.type,
				'label' : item.label,
				'values' : item.values,
				'required' : item.required,
				'tournament' : arguments.tournament
			}
	
			var thisConfig = entityNew("customconfig", customfield);
			entitysave(thisConfig);
			} catch(any e){ }
		}


	}

	public string function updateCustomFields( required array data, required any tournament ) {
		
		for (item in arguments.data) {

			thisItem = entityLoadByPK('customconfig', isNumeric(item.rowid) ? item.rowid: 0);
			if (isNull(thisItem)) {
				// this is a new item create instead
				createMe = [item]; 
				saveCustomFields(createMe, arguments.tournament);
			} else {
				if(item.delete) {
					// remove any data for entry
					queryexecute('delete from customdata where parentid = :pid', {pid: thisItem.getid()});
					entityDelete(thisItem);

				} else if (item.label.len()) {
					thisitem.settype(item.type);
					thisitem.setlabel(item.label);
					thisitem.setvalues(item.values);
					thisitem.setrequired(item.required);
					thisitem.settype(item.type);
					entitysave(thisItem);
				}
			}
		}
		ormflush();
	}

	



	public string function savePlayerCustomData( required any data, required any player ) {

		for (item in arguments.data.CUSTOMDATA) {

			var thisItem = entityload('customdata', {parentid = item?.parentid ?: 0, player = arguments.player}, true);

			if (isNull(thisItem)) {

				var customData = {
					'parentid' : item.parentid,
					'value' : item.value,
					'player' : arguments.player
				}
				var thisData = entityNew("customdata", customData);
				entitysave(thisData);

			} else {
				thisitem.setvalue(item.value);
				entitysave(thisItem);

			}
			ormflush();
		}

	}





	public string function savePlayerCustomDataEdit( required any data, required any player ) {

		customConf = player.getTournament().getCustomConfig();

		var found = 0;
		var remitems = '';
		for (field in customConf) {
			found = 0;
			for (item in arguments.data) {
				if (item.parentid == field.getid()) {
					found = 1;
					var thisItem = entityload('customdata', {parentid = item?.parentid ?: 0, player = arguments.player}, true);
					if (isNull(thisItem)) {
						var customData = {
							'parentid' : item.parentid,
							'value' : item.value,
							'player' : arguments.player
						}
						var thisData = entityNew("customdata", customData);
						entitysave(thisData);
		
					} else {
						thisitem.setvalue(item.value);
						entitysave(thisItem);		
					}
				}
			}

			if (! found) {
				remitems = listappend(remitems, field.getid());
			}

		}
		if (remitems.listlen()) {
			queryExecute('delete from customdata where parentid in (#remitems#) and playerid = #arguments.player.getid()#');
		}

		ormflush();

	}


	public any function addCustomToExport( required any exportData, required any tournament) {

		var thisData = arguments.exportData;
		var thisTourney = arguments.tournament;
		var customIds = '';
		var customNames = '';
		var playerCustom = [];
		var idx = 1;
		var truw = 1;
		var pc = {};

		var customs = thisTourney.getcustomconfig();

		// no custom data.. return
		if (! customs.len()) { 
			return {'customfields':'', 'data': thisdata};
		}

		for (c in customs) {
			customIds = listappend(customIds, c.getid());
			thisName = reReplaceNoCase(c.getlabel(), '[^a-z0-9_]', '_', "ALL");
			customNames = listappend(customNames, thisName);
			thisData.AddColumn("#thisName#", "VarChar", [])
		}

		// get all custom values
		customVals = queryExecute('select cd.value, cd.parentid, cd.playerid from customdata cd where playerid in (#valuelist(thisData.id)#) order by cd.playerid, cd.parentid')

		for (rows in thisData) {			
			playerCustom[idx] = {'playerid_': rows.id};
			for (cid in listtoArray(customIds, ',')) {
				cdataQry = queryExecute( "select * from customVals where parentid = #cid# and playerid = #rows.id#", {}, { dbtype="query" } );
				structInsert(playerCustom[idx], "#cid#", "#cdataQry.value#");
			}
			idx++;
		}

		// convert player custom data to structure for searching
		pc.playerCustom = playerCustom;

		trow = 1;
		for (p in thisData) {	

			item = structFindValue(pc, thisData.id, 'one');
			if (isArray(item)) {
				tpcdata = item[1].owner;
				for (i = 1; i <= customIds.listlen(); i++) {

					querySetCell(thisData, "#customNames.listGetAt(i)#", tpcdata['#customIds.listGetAt(i)#'], trow);

				}

			}

			trow++;
		}

		return {'customfields':customNames, 'data': thisData};
	}


}

