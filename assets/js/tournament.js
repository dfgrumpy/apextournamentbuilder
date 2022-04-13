
/*
    Primary system wide JS file for tournament specific items
*/

// tournament function
tourneyNS = {


    init: function () {
       


    },

    processPlayerTeamUpdate: function (player, team, type) {        
        payload = {'playerid': player, 'teamid': team, 'type': type};
        siteAjax.savePlayerTeamUpdate(payload);
    },



    processTeamFill: function () {        

		formData = JSON.stringify($('#modalForm').serializeArray());
		package = { modal: true, url: '/ajax/savedata/item/teamfill', payload: formData, handler: 'tourneyNS.processTeamFillResult' };
		siteAjax.saveFormData(package);
    },

    processTeamFillResult: function( data ){
		if (data) {
			uiNS.setModalHide();
			uiNS.displayNotification('success', 'Teams have been created. Refreshing... ');
			setTimeout(function () { location.reload(true); }, 1000);
		} else {
			uiNS.displayNotification('danger', 'There was an error creating the teams.');
		}
    },


    processTeamEdit: function () {        

		formData = JSON.stringify($('#modalForm').serializeArray());
		package = { modal: true, url: '/ajax/savedata/item/teamedit', payload: formData, handler: 'tourneyNS.processTeamEditResult' };
		siteAjax.saveFormData(package);
    },

    processTeamEditResult: function( data ){

		if (data) {
			uiNS.setModalHide();
			uiNS.displayNotification('success', 'Teams name update has been saved.');
            teamdata = JSON.parse(formData);
            $('#teamName' + teamdata[0].value).text(teamdata[1].value);
		} else {
			uiNS.displayNotification('danger', 'There was an error updating the team name. Team names must be unique.');
		}
    },

    processAutofill: function( data ){

		if ($('#autofilltype').val() == 0) {
			return;
		}

		payload = {
				'filltype' : $('#autofilltype').val(),
				'console': $('#singleconsole').prop("checked"), 
				'reset': $('#resetall').prop("checked"),
				'tournamentid' : data
			};

		siteAjax.processAutofill(payload);

	},



	approveChoiceComfirm: function(type, item){

		if (type == 1) {
			message= '<p>Are you sure you wish to <strong class="text-success">APPROVE</strong> this team?</p><p>Once approved you can edit details on the players in the team.</p>';
			btnTxt = 'Approve';
		} else if (type == 2) {
			message= '<p>Are you sure you wish to <strong class="text-danger">REJECT</strong> this team?</p><p>If you change your mind later you can rescind the rejection.</p>';
			btnTxt = 'Reject';
		} else if (type == 3) {
			message= '<p>Are you sure you wish to <strong class="text-warning">Rescind</strong> the approval for this team?</p><p>Team will be put back in pending status.</p>';
			btnTxt = 'Rescind';
		} else if (type == 4) {
			message= '<p>Are you sure you wish to <strong class="text-warning">Rescind</strong> the rejection for this team?</p><p>Team will be put back in pending status.</p>';
			btnTxt = 'Rescind';
		} else if (type == 5) {
			message= '<p>Are you sure you wish to <strong class="text-success">APPROVE</strong> this player?</p><p>Once approved you can edit details on the player and assign to a team.</p>';
			btnTxt = 'Approve';
		} else if (type == 6) {
			message= '<p>Are you sure you wish to <strong class="text-danger">REJECT</strong> this player?</p><p>If you change your mind later you can rescind the rejection.</p>';
			btnTxt = 'Reject';
		} else if (type == 7) {
			message= '<p>Are you sure you wish to <strong class="text-warning">Rescind</strong> the approval for this player?</p><p>Player will be put back in pending status.</p>';
			btnTxt = 'Rescind';
		} else if (type == 8) {
			message= '<p>Are you sure you wish to <strong class="text-warning">Rescind</strong> the rejection for this player?</p><p>Player will be put back in pending status.</p>';
			btnTxt = 'Rescind';
		}

		if (type <= 4) {
			var thisTeam = $('.list-group-item-secondary').data('teamid');
			var srcField = $('.list-group-item-secondary');
		} else {
			var thisPlayer = $(item).data('playerid');
			var srcField = $(item).closest('tr');
		}


		bootbox.confirm({
			message: message,
			closeButton: false,
			buttons: {
				cancel: {
					label: 'Cancel',
					className: 'btn btn-danger me-4 btn-sm' 
				},
				confirm: {
					label: btnTxt,
					className: 'btn btn-success btn-sm'
				}
			},
			callback: function (result) {
				if (result) {
					if (type == 1) {
						tourneyNS.approveTeam(thisTeam, false, $(srcField));
					} else if (type == 2) {
						tourneyNS.rejectTeam(thisTeam, false, $(srcField));
					} else if (type == 3) {
						tourneyNS.rescindTeam(thisTeam, false, $(srcField), 1);
					} else if (type == 4) {
						tourneyNS.rescindTeam(thisTeam, false, $(srcField), 2);
					} else if (type == 5) {
						tourneyNS.approvePlayer(thisPlayer, false, $(srcField));
					} else if (type == 6) {
						tourneyNS.rejectPlayer(thisPlayer, false, $(srcField));
					} else if (type == 7) {
						tourneyNS.rescindPlayer(thisPlayer, false, $(srcField), 1);
					} else if (type == 8) {
						tourneyNS.rescindPlayer(thisPlayer, false, $(srcField), 2);
					}					
				}
			}
		});

	},


	approveTeam: function (teamid, reload = false, teamrow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/approveteam/teamid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				uiNS.displayNotification('success', 'Team has been approved.');	
				$(teamrow).remove();	
				$('#teamContent').html('');	
				$('#approvalHDRCount').text($('#approvalHDRCount').text()-1);
				$('#teamcountunapproved').text($('#teamcountunapproved').text()-1);
				$('#teamcountapproved').text(parseInt($('#teamcountapproved').text())+1);	
		
				if ( parseInt($('#teamcountapproved').text()) > 20){
					$('#gtMaxAlert').removeClass('d-none');
				} else {
					$('#gtMaxAlert').addClass('d-none');					
				}

				$('.teamDetailList').scrollTop(0);		
			} else {
				uiNS.displayNotification('danger', 'There was an error approving the team.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error approving the team.');			
		});

	},

	approvePlayer: function (teamid, reload = false, playerRow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/approveplayer/playerid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				uiNS.displayNotification('success', 'Player has been approved.');	
				$(playerRow).remove();	
				$('#playerCountPending').text(parseInt($('#playerCountPending').text())-1);
				$('#playerCountApproved').text(parseInt($('#playerCountApproved').text())+1);	

				$('.teamDetailList').scrollTop(0);		
			} else {
				uiNS.displayNotification('danger', 'There was an error updating the player.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error updating the player.');			
		});

	},

    
	rejectTeam: function (teamid, reload = false, teamrow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/rejectteam/teamid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				uiNS.displayNotification('success', 'Team has been rejected.');	
				$(teamrow).remove();	
				$('#teamContent').html('');	
				$('#approvalHDRCount').text($('#approvalHDRCount').text()-1);
				$('#teamcountunapproved').text($('#teamcountunapproved').text()-1);			
				$('.teamDetailList').scrollTop(0);
			} else {
				uiNS.displayNotification('danger', 'There was an error processing the team.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error processing the team.');			
		});

	},
    

	rejectPlayer: function (teamid, reload = false, playerRow) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/rejectplayer/playerid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				uiNS.displayNotification('success', 'Player has been rejected.');	
				$(playerRow).remove();	
				$('#playerCountPending').text(parseInt($('#playerCountPending').text())-1);
				$('#playerCountRejected').text(parseInt($('#playerCountRejected').text())+1);	

				$('.teamDetailList').scrollTop(0);		
			} else {
				uiNS.displayNotification('danger', 'There was an error updating the player.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error updating the player.');			
		});

	},


	rescindTeam: function (teamid, reload = false, teamrow, type) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/rescindteam/teamid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {

				if (type == 1){
					uiNS.displayNotification('success', 'Team approval has been rescinded.');	
				} else {
					uiNS.displayNotification('success', 'Team rejection has been rescinded.');	
				}

				$(teamrow).remove();	
				$('#teamContent').html('');	
				$('#approvalHDRCount').text($('#approvalHDRCount').text()-1);
				$('#teamcountunapproved').text(parseInt($('#teamcountunapproved').text())+1)

				if (type == 1) {
				$('#teamcountapproved').text(parseInt($('#teamcountapproved').text())-1);	
				} 
				
				if ( parseInt($('#teamcountapproved').text()) > 20){
					$('#gtMaxAlert').removeClass('d-none');
				} else {
					$('#gtMaxAlert').addClass('d-none');					
				}


				$('.teamDetailList').scrollTop(0);
			} else {
				uiNS.displayNotification('danger', 'There was an error processing the team.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error processing the team.');			
		});

	},
    

	rescindPlayer: function (teamid, reload = false, playerRow, type) {
		var url = siteAjax.getBaseURL() + '/ajax/savedata/item/rescindPlayer/playerid/' + teamid;
		$.ajax({
			type: "get",
			url: url
		}).done(function (result) {
			if (result == 1) {
				$(playerRow).remove();	

				$('#playerCountPending').text(parseInt($('#playerCountPending').text())+1);

				if (type == 1){
					uiNS.displayNotification('success', 'Player approval has been rescinded.');	
					$('#playerCountApproved').text(parseInt($('#playerCountApproved').text())-1);	
				} else {
					uiNS.displayNotification('success', 'Player rejection has been rescinded.');	
					$('#playerCountRejected').text(parseInt($('#playerCountRejected').text())-1);						
				}

				$('.teamDetailList').scrollTop(0);		
			} else {
				uiNS.displayNotification('danger', 'There was an error updating the player.');					
			}
		}).fail(function () { 
			uiNS.displayNotification('danger', 'There was an error updating the player.');			
		});

	},


    validateTournamentDates: function( ){
		// verify registration dates
		if ($('#regenabled').prop("checked")) {

			var evDate = $('#eventdate').val().split('T')[0];
			var startDate = $('#regstart').val();
			var endDate = $('#regend').val();
			var cutDate = $('#cutoff').val();

			var regstartdiff = util.dateDiff(evDate, startDate, 'days')
			var regOpenCloseDiff = util.dateDiff(startDate, endDate, 'days');
			var regCloseEventDiff = util.dateDiff(evDate, endDate, 'days');
			var regCloseCutDiff = util.dateDiff(endDate, cutDate, 'days');
			var regCutEventDiff = util.dateDiff(evDate, cutDate, 'days');

			$("#regstart")[0].setCustomValidity("");
			$("#regend")[0].setCustomValidity("");
			$("#cutoff")[0].setCustomValidity("");

			// is reg open before tourney date
			if (regstartdiff >= 0) {
				$("#regstart")[0].setCustomValidity("fail");
			}
 
			// close after open but before tourney date
			if (regOpenCloseDiff <= 0 || regCloseEventDiff >= 0) {
				$("#regend")[0].setCustomValidity("fail");
			} 

			// cutoff after close but before tourney date
			if ($('#latereg').prop("checked")) {
				if (regCloseCutDiff <= 0 || regCutEventDiff >= 0) {
					$("#cutoff")[0].setCustomValidity("fail");
				}
			}

		}

	},

};
