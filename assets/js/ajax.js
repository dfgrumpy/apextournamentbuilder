/* 
	code for all ajax app calls to server
*/

siteAjax = {
	
	getBaseURL : function(){
		
		return '//' + window.location.hostname + (location.port.length ? ':' + location.port: '') ;
		
	},
	
	
    
    
	loadModalContent: function (content, title, size) {

    	var url  = siteAjax.getBaseURL() + '/ajax/modal/content/' + content;
		$.ajax({
	        type: "get",
	        url: url
	    }).done(function(result) {
	    	uiNS.setModalContent(title, result);
	    	
	    	if (typeof size !== 'undefined') {
	    		$('#baseModal > .modal-dialog').addClass('modal-lg');
	    	} else {
	    		$('#baseModal > .modal-dialog').removeClass('modal-lg');
	    	}
	    	
	    	$('#baseModal').modal('show');
	    		    	
	    	// activate any tooltips in modal
			$('[data-bs-toggle="tooltip"]').tooltip({
				delay: { "show": 2000, "hide": 100 }
			});
	    	
			// always try to init summernote
			$('.summernote').summernote({
				height: 250,
				disableResizeEditor: true,
				toolbar: [
					['style', ['bold', 'italic', 'underline', 'clear']],
					['para', ['style', 'ul', 'ol', 'paragraph']]
				]

			});

			// activate any toggle ui elements in modal
			$('.toggleControl').bootstrapToggle();

	    }).fail(function() {
    		uiNS.displayNotification('danger', 'An error occurred.');		
		});	
    	
	},
		
	saveFormData : function(package){
		
		$thisData = package;
		
		var url  = siteAjax.getBaseURL() + $thisData.url;
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: JSON.parse($thisData.payload)
	    }).done(function(result) {
	    	util.executeFunctionByName($thisData.handler, window, result);	    	
	    }).fail(function() {
	    	util.executeFunctionByName($thisData.handler, window, false);
		});	
				
	},
	
	doSingleCall: function (payload) {

		var url = siteAjax.getBaseURL() + payload.url;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (! result && 'failmessage' in payload){
				uiNS.displayNotification('danger', payload.failmessage);
				return;
			}

			uiNS.displayNotification('success', payload.donemessage);
			if (payload.reload) {
				setTimeout(function () { location.reload(true); }, 2000);
			}
		}).fail(function () { });

	},


	saveTournamentEdit: function (data) {
		formData = JSON.stringify($('#modalForm').serializeArray());
		package = { modal: true, url: '/ajax/savedata/item/tournamentedit', payload: formData, handler: 'siteAjax.saveTournamentEditResult' };
		siteAjax.saveFormData(package);
	},

	saveTournamentEditResult: function (data) {
		uiNS.setModalHide();
		uiNS.displayNotification('success', 'Tournament edit has been saved. Refreshing... ');
		setTimeout(function () { location.reload(true); }, 1000);
	},

	savePlayerEdit: function (data) {				
		formData = JSON.stringify($('#modalForm').serializeArray());
		package = { modal: true, url: '/ajax/savedata/item/playeredit', payload: formData, handler: 'siteAjax.savePlayerEditResult' };
		siteAjax.saveFormData(package);
	},

	savePlayerEditResult: function (data) {
		uiNS.setModalHide();
		uiNS.displayNotification('success', 'Player edit has been saved. Refreshing... ');
		setTimeout(function () { location.reload(true); }, 1000);  
	},

	saveNewPlayer: function (data) {
		formData = JSON.stringify($('#modalForm').serializeArray());

		if ($('#playername').val().length == 0) {
			uiNS.displayNotification('danger', 'A Player Name is required to create a player.');
			return;
		}
		package = { modal: true, url: '/ajax/savedata/item/playernew', payload: formData, handler: 'siteAjax.saveNewPlayerResult' };
		siteAjax.saveFormData(package);
	},



	saveNewPlayerResult: function (data) {		
		if (typeof data == "boolean" && data) {
			uiNS.setModalHide();
			uiNS.displayNotification('success', 'Player has been created. Refreshing... ');
			setTimeout(function () { location.reload(true); }, 1000);
		} else {
			uiNS.displayNotification('danger', data.detail);
		}
	},

	saveNewTeam: function (data) {
		formData = JSON.stringify($('#modalForm').serializeArray());
		package = { modal: true, url: '/ajax/savedata/item/teamnew', payload: formData, handler: 'siteAjax.saveNewTeamResult' };
		siteAjax.saveFormData(package);
	},

	
	saveNewTeamResult: function (data){

		if (data == 1) {
			uiNS.setModalHide();
			uiNS.displayNotification('success', 'Team has been created. Refreshing... ');
			setTimeout(function () { location.reload(true); }, 1000);
		} else {
			uiNS.displayNotification('danger', 'Error occurred creating team.  Please make sure the team name is unique.');
		}

	},

	loadPlayerTrackerData: function (playerid, reload = false) {

		var url = siteAjax.getBaseURL() + '/ajax/trackerload/playerid/' + playerid;
		var addl = '';
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			
			if (reload) {
				setTimeout(function () { location.reload(true); }, 2000);
				addl = ' Refreshing....';
			}
			
			uiNS.displayNotification('success', 'Player tracker data has been reloaded.' + addl);
		}).fail(function () { });

	},

	deletePlayer: function (playerid, reload = false, playerrow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/deleteplayer/playerid/' + playerid;
		var addl = '';
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			uiNS.displayNotification('success', 'Player has been deleted.' + addl);
			$(playerrow).closest('tr').remove();
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error deleting the player.');			
		});

	},


	deleteTournament: function (tournamentid, reload = false, tourneyrow, relocate = false) {

		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/deleteTournament/tournamentid/' + tournamentid;
		var addl = '';
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (relocate) {
				setTimeout(function () {
					window.location.replace("/tournament/mytournaments");
				}, 2000);
				uiNS.displayNotification('success', 'Tournament has been deleted.');
			} else {
				uiNS.displayNotification('success', 'Tournament has been deleted.' + addl);
				$(tourneyrow).closest('tr').remove();
			}
		}).fail(function () {
			uiNS.displayNotification('danger', 'There was an error deleting the tournament.');
		});

	},

	deleteTeam: function (teamid, reload = false, teamrow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/deleteteam/teamid/' + teamid;
		var addl = '';
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				uiNS.displayNotification('success', 'Team has been deleted.');	
				$(teamrow).remove();	
				$('#teamContent').html('');	

				try {
					$('.teamDetailListBtn')[0].click();
				} catch (e) {   }
			} else {
				uiNS.displayNotification('danger', 'There was an error deleting the team.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error deleting the team.');			
		});

	},


	savePlayerTeamUpdate: function (payload) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/playerteamupdate/'
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: payload
	    }).done(function(result) {
			if (!result) {
				uiNS.displayNotification('danger', 'There was an error updating the player.');					
			}
			
	    }).fail(function() {
			uiNS.displayNotification('danger', 'There was an error updating the player.');					
		});	


	},

	processAutofill: function (payload) {

		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/teammatchmaking/'
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: payload
	    }).done(function(result) {
			if (!result) {
				uiNS.displayNotification('danger', 'There was an error updating the teams.');					
			} else {
				uiNS.displayNotification('success', 'Teams have been populated... Reloading.');		
				setTimeout(function () { location.reload(true); }, 1000);							
			}
			
	    }).fail(function() {
			uiNS.displayNotification('danger', 'There was an error updating the teams.');					
		});	

	},


};



