
eventsNS = {

	init : function(page){


		uiComponentInit = function () {
			return;
			$('.datepicker').datepicker({
			    format: "mm/dd/yyyy",
			    autoclose: true,
			    todayHighlight: true
			});


			$('.selectpicker').selectpicker({
			});

		};


		uiComponentInit();
		// run event function for all pages
		eventsNS.all();


		// attempt to call event function for section/item
		//console.log(page);
		try {
			util.executeFunctionByName('eventsNS.' + page, window);
		} catch (e) {};

		// reset modal content when hidden
		$('#baseModal').on('hidden.bs.modal', function (e) {
			uiNS.setModalContent('', '');
			/// remove click hander or next modal show will attach a new click hander
			$('#myModalSave').off('click');

			/// reset multi click check
			saveClicked = false;

			// show save button incase it was hidden
			$("#myModalSave").show();

			// reset button bar
			uiNS.showModalCloseFooter(0);
		  
		});


		var saveClicked = false;
		$('#baseModal').on('shown.bs.modal', function (e) {
			// lets set a handler for the save button in the modal based on content of the form
			$('#myModalSave > span').text('Save');
			$('#myModalSave').removeClass('disabled');
			
			if ($('#modalForm').length) {

				var thisForm = $('#modalForm');
				var handler = '', $form = thisForm.data('form');
				var formvalid = false;
				// modal save handlers go here.  $form Matches data-form value in modal
				if ($form == 'playerdetail') {
					handler = 'siteAjax.savePlayerEdit';
				} else if ($form == 'playercreate') {
					handler = 'siteAjax.saveNewPlayer';
				} else if ($form == 'tournamentedit') {
					handler = 'siteAjax.saveTournamentEdit';
				} else if ($form == 'teamnew') {
					handler = 'siteAjax.saveNewTeam';
				} else if ($form == 'teamfill') {
					handler = 'tourneyNS.processTeamFill';
				} else if ($form == 'teamedit') {
					handler = 'tourneyNS.processTeamEdit';
				} else if ($form == 'forgotLogin'){
					handler = 'mainNS.forgotLogin';
					$('#myModalSave > span').text('Continue');					
				} else {
					console.log('No handler for :  ' + $form);
				}
			
				
				$form = document.getElementById('modalForm');
				$form.addEventListener('submit', function (event) {
					event.preventDefault();
					event.stopPropagation();
					if ($form.checkValidity()) {
						formvalid = true;
					}
					$form.classList.add('was-validated')
				}, false);


				if (handler.length) {
					$('#myModalSave').on('click', function () {
						$('#forceValidationBtn').click()
						if (formvalid) {
							if (!saveClicked) { // if the save button has been clicked then exit out
								saveClicked = true;
							} else {
								return;
							}
							console.log(handler);
							util.executeFunctionByName(handler, window);
						}
						setTimeout(function () {
							// wait 3 seconds and turn the multiclick off
							saveClicked = false;
						}, 3000)
					});
				};
			}

			// kill the save button
			if ($('#killModalSave').length) {
				$('#myModalSave').addClass('disabled');
			} else {
				// init datepicker in modal
				uiComponentInit();
			}

		})

		popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
			var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
			return new bootstrap.Popover(popoverTriggerEl)
		})

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

		$.ajaxSetup({
			error: function (x, status, error) {
				if (x.status == 403) {
					msg = x.getResponseHeader("custom-error-message") || 'An unknown error has occurred.' ;
					uiNS.displayNotification('danger', msg);
					setTimeout(function () { window.location.href ="/"; }, 2000);					
				}
			}
		});


		$('.copyToClipboardBtn').on('click', function (e) {
			var copyText = $(this).data('clipboard');
			navigator.clipboard.writeText(copyText);
		})
	},

	main :{
		login: function(){
			
			$('#forgotLoginBtn').on('click', function(e){
				siteAjax.loadModalContent('forgotlogin', 'Forgot Password');
			});
		}

	},

	
	alerts: {
		default: function () {
		}
	},


	tournament: {
		register: function(){

			$('#rulesView').on('click', function(){
				siteAjax.loadModalContent('tournamentrules/tournamentid/' + $(this).data('tournamentid'), 'Tournament Rules', 'large');
				uiNS.showModalCloseFooter(1);
			});
		},
		create: function () {
			
			$('#eventdate').on('change', function(e) {
				util.setEventDates();
			});

			$('#regenabled').on('change', function(e) {

				if ($(this).prop("checked")) { // reg on
					if ($('#latereg').prop("checked")) {
						$('#cutoff').prop('required',false);
					} else {
						$('#cutoff').prop('required',true);
					}
					$('#regstart').prop('required',true);
					$('#regend').prop('required',true);
				} else { // reg off

					// turn off req dates
					$('#regstart').prop('required',false);
					$('#regend').prop('required',false);
					$('#cutoff').prop('required',false);
				}

			});
			$('#latereg').on('change', function(e) {
				if ($(this).prop("checked")) {
					$('#cutoff').prop('required',true);			
				} else {
					$('#cutoff').prop('required',false);								
				}

			});



		},

		detail: function () {			
			$('.tournamentEditeBtn').on('click', function (e) {
				siteAjax.loadModalContent('tournamentedit/tournamentid/' + $(this).data('tournamentid'), 'Tournament Edit : ' + $(this).closest('div .row').children('div .text-start').text(), 'large');
			});
		},


		view: function () {		
			$('.teamDetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('teammembers/teamid/' + $(this).data('teamid'), 'Team Makeup : ' + $(this).text());
				uiNS.showModalCloseFooter(1);
			});
		},	



		mytournaments: function () {
			
			$('.tournamentEditeBtn').on('click', function (e) {
				siteAjax.loadModalContent('tournamentedit/tournamentid/' + $(this).data('tournamentid'), 'Tournament Edit : ' + $(this).closest('tr').children('td.tourneyName').text(), 'large');
			});

		},
		teamsoverview: function () {

			$('.teamDetailList button').on('click', function (e) {
				$('.teamDetailList button.list-group-item-secondary').removeClass('list-group-item-secondary');
				$(this).addClass('list-group-item-secondary');

				$.get("/team/members/teamid/" + $(this).data('teamid'), function( data ) {
					$('#teamContent').html( data );
					$('.teamActionBtn').removeClass('d-none');
				});


			});

			$('.teamAddBtn').on('click', function (e) {
				siteAjax.loadModalContent('teamnew/tournamentid/' + $(this).data('tournamentid'), 'Add New Team');
			});

			$('#teamRenameBtn').on('click', function (e) {

				thisTeam = $('.list-group-item-secondary').data('teamid')
				siteAjax.loadModalContent('teamedit/teamid/' + thisTeam, 'Edit Team Name');
			});
			
			$('#teamDeleteBtn').on('click', function (e) {
				
				thisTeam = $('.list-group-item-secondary').data('teamid');
				var srcField = $('.list-group-item-secondary');
		
				bootbox.confirm({
					message: "Are you sure you wish to delete this team?<br><br>This will only delete the team.  Any players assigned will need to be reassigned to another team",
					closeButton: false,
					buttons: {
						cancel: {
							label: 'No',
							className: 'btn btn-danger'
						},
						confirm: {
							label: 'Yes',
							className: 'btn btn-success'
						}
					},
					callback: function (result) {
						if (result) {
							siteAjax.deleteTeam(thisTeam, false, $(srcField));
						}
					}
				});


			});

			// load first item on team list
			$('.teamDetailListBtn')[0].click();
		},
		manageapprovals: function () {

			$('#playerApprovalTab').on('click', function (e) {
				base = $('#sectionForm').attr('action');
				$("#sectionForm").attr('action', base + '/section/player/');
				$("#sectionForm").submit();
			});
			$('#teamApprovalTab').on('click', function (e) {
				base = $('#sectionForm').attr('action');
				$("#sectionForm").attr('action', base + '/section/team/');
				$("#sectionForm").submit();

			});
			$('.playerdetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('playerdetail/playerid/' + $(this).data('playerid'), 'Player Details : ' + $(this).data('playername'));
				uiNS.showModalCloseFooter(1);
			});

			$('.teamDetailList button').on('click', function (e) {
				$('.teamDetailList button.list-group-item-secondary').removeClass('list-group-item-secondary');
				$(this).addClass('list-group-item-secondary');

				$.get("/team/members/approval/true/teamid/" + $(this).data('teamid'), function( data ) {
					$('#teamContent').html( data );
					$('.teamActionBtn').removeClass('d-none');
				});


			});


			// load first item on team list
			try {
				$('.teamDetailListBtn')[0].click();
			} catch (e) {   }

			$('#teamRenameBtn').on('click', function (e) {
				thisTeam = $('.list-group-item-secondary').data('teamid')
				siteAjax.loadModalContent('teamedit/teamid/' + thisTeam, 'Edit Team Name');
			});
			
			$('#teamDeleteBtn').on('click', function (e) {
				
				thisTeam = $('.list-group-item-secondary').data('teamid');
				var srcField = $('.list-group-item-secondary');		
				bootbox.confirm({
					message: "Are you sure you wish to delete this team?<br><br>Since this team is not approved, the players will also be deleted.",
					closeButton: false,
					buttons: {
						cancel: {
							label: 'No',
							className: 'btn btn-danger'
						},
						confirm: {
							label: 'Yes',
							className: 'btn btn-success'
						}
					},
					callback: function (result) {
						if (result) {
							siteAjax.deleteTeam(thisTeam, false, $(srcField));
						}
					}
				});
			});
			$('#teamContent').on('click', '.approveTeamBtn', function (e) {		
				tourneyNS.approveChoiceComfirm(1, this);
			});
			$('#teamContent').on('click', '.rejectTeamBtn', function (e) {
				tourneyNS.approveChoiceComfirm(2, this);
			});
			$('#teamContent').on('click', '.rescindTeamBtn', function (e) {				
				tourneyNS.approveChoiceComfirm(3, this);
			});
			$('#teamContent').on('click', '.rescindRejectTeamBtn', function (e) {				
				tourneyNS.approveChoiceComfirm(4, this);
			});

			$('.approvePlayerBtn').on('click', function (e) {		
				tourneyNS.approveChoiceComfirm(5, this);
			});
			$('.rejectPlayerBtn').on('click', function (e) {
				tourneyNS.approveChoiceComfirm(6, this);
			});
			$('.rescindPlayerApproveBtn').on('click', function (e) {				
				tourneyNS.approveChoiceComfirm(7, this);
			});
			$('.rescindPlayerRejectBtn').on('click', function (e) {				
				tourneyNS.approveChoiceComfirm(8, this);
			});

		},

		manageplayers: function () {
			$('.playerdetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('playeredit/playerid/' + $(this).data('playerid'), 'Player Edit : ' + $(this).data('playername'));
			});
			$('.playerInfoBtn').on('click', function (e) {
				siteAjax.loadModalContent('playerdetail/playerid/' + $(this).data('playerid'), 'Player Details : ' + $(this).data('playername'));
				uiNS.showModalCloseFooter(1);
			});

			$('.playerAddBtn').on('click', function (e) {
				siteAjax.loadModalContent('playernew/tournamentid/' + $(this).data('tournamentid'), 'Add New Player');
			});

			
			$('.playerTrackerBtn').on('click', function (e) {
				siteAjax.loadPlayerTrackerData($(this).data('playerid'), true);
			});


			$('.playerDeleteBtn').on('click', function (e) {
				var srcField = $(this);
				bootbox.confirm({
					message: "Are you sure you wish to delete this player?",
					closeButton: false,
					buttons: {
						cancel: {
							label: 'No',
							className: 'btn btn-danger'
						},
						confirm: {
							label: 'Yes',
							className: 'btn btn-success'
						}
					},
					callback: function (result) {
						if (result) {
							siteAjax.deletePlayer($(srcField).data('playerid'), false, $(srcField));
						}
					}
				});
			});


			$('#sortableTable').DataTable(
				{
					"scrollY": "450px",
					"searching": false,
					"lengthChange": false,
					"pageLength": 10,
					"order": [],
					"paging": false,
					"language": {
						"emptyTable": "There is no data to display"
					}
				}
			);


		},
		teambuilder : function(){


			$('.playerdetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('playerdetail/playerid/' + $(this).data('playerid'), 'Player Details : ' + $(this).data('playername'));
				uiNS.showModalCloseFooter(1);
			});


			$('.teamDetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('teammembers/teamid/' + $(this).data('teamid'), 'Team Makeup : ' + $(this).text());
				uiNS.showModalCloseFooter(1);
			});



			$('.playerFilterDDBTN').on('click', function (e) {

				$filter = $(this).data('filter');
				$value = $(this).data('value');
				$showrank = '';
				$showPlatform = '';

				if (typeof $rankLast === 'undefined') {
					$rankLast = '';
				}
				if (typeof $platformLast === 'undefined') {
					$platformLast = '';
				}
				$(".list-group-sortable-source li").removeClass('d-none'); // show everything


				if ($filter == "rank") {
					$rankLast = $value;
					if ($value != 'all') {
						$showrank = $value;
						$('#rankLabel').html( $showrank == 0 ? 'Unknown' :  $showrank );
						$(".list-group-sortable-source li[data-rank!='" +$showrank+ "']").addClass('d-none');
					} else {
						$rankLast = ''
						$('#rankLabel').html('Rank');
					}
				} else { // hot filtering on rank but need to preserve previous
					if ( $rankLast != '' || $rankLast === 0 ){
						$showrank = $rankLast;
					}
				}

				if ($filter == "platform") {
					$platformLast = $value;
					if ($value != 'all') {
						$showPlatform = $value;
						$('#platformLabel').html( $showPlatform == 0 ? 'Unknown' :  $showPlatform );
						$(".list-group-sortable-source li[data-platform!='" +$showPlatform+ "']").toggleClass('d-none');
					} else {
						$platformLast = ''
						$('#platformLabel').html('Platform');
					}
				} else { // hot filtering on platform but need to preserve previous
					if ($platformLast != '' || $platformLast === 0 ){
						$showPlatform = $platformLast;
					}
				}

				if (($showrank != '' || $showrank === 0) && $filter!='rank') {
					$(".list-group-sortable-source li[data-rank!='" +$showrank+ "']").addClass('d-none');
				}

				if (($showPlatform != '' || $showPlatform === 0) && $filter!='platform') {
					$(".list-group-sortable-source li[data-platform!='" +$showPlatform+ "']").addClass('d-none');
				}

			});

			
			$('.editTeamBtn').on('click', function (e) {
				siteAjax.loadModalContent('teamedit/teamid/' + $(this).data('teamid'), 'Edit Team Name');
			});
			$('.teamAddBtn').on('click', function (e) {
				siteAjax.loadModalContent('teamnew/tournamentid/' + $(this).data('tournamentid'), 'Add New Team');
			});
		
			$('.teamGenerateAddBtn').on('click', function (e) {
				siteAjax.loadModalContent('teamfill/tournamentid/' + $(this).data('tournamentid'), 'Prefix for Team Names');
			});

			$('.autofillBtn').on('click', function (e) {
				tourneyNS.processAutofill( $(this).data('tournamentid') );
			});



			sortable('.list-group-sortable-source', {
				placeholderClass: 'border-danger',
				placeholder: '<div>&nbsp;</div>',
				acceptFrom: '.list-group-sortable-teams',
				forcePlaceholderSize: true,
				handle: 'i'
			});
			
			sortable('.list-group-sortable-teams', {
				placeholderClass: 'border-danger',
				placeholder: '<div>&nbsp;</div>',
				acceptFrom: '.list-group-sortable-source, .list-group-sortable-teams',
				forcePlaceholderSize: false,
				handle: 'i',
				maxItems: $('#tournamentInfo').data('teamsize')
			});

			sortable('.list-group-sortable-source')[0].addEventListener('sortupdate', function(e) {
				tourneyNS.processPlayerTeamUpdate($(e.detail.item).data('playerid'), 0, 0);
				// removed from team update source
				teamTotal = $(e.detail.origin.container).children('li').length;
				item = $(e.detail.origin.container).closest('div .card');
				uiNS.updateTeamBorder(teamTotal, item);
			});

			sortTeams = document.querySelectorAll('.list-group-sortable-teams')

			for (let i = 0; i < sortTeams.length; i++) {
				sortTeams[i].addEventListener('sortupdate', function(e) {
					tourneyNS.processPlayerTeamUpdate($(e.detail.item).data('playerid'), $(e.detail.item).closest('ul').data('teamid'), 1);
					
					// add to team.. update target
					teamTotal = $(e.detail.item).closest('ul').children('li').length;
					item = $(e.detail.item).closest('div .card');
					uiNS.updateTeamBorder(teamTotal, item);

					originTotal = $(e.detail.origin.items).length
					originItem = $(e.detail.origin.container).closest('div .card');
					uiNS.updateTeamBorder(originTotal, originItem);

				});
			}

		},
		edit : function(){


			$('#regenabled').on('change', function(e) {

				if ($(this).prop("checked")) { // reg on
					if ($('#latereg').prop("checked")) {
						$('#cutoff').prop('required',false);
					} else {
						$('#cutoff').prop('required',true);
					}
					$('#regstart').prop('required',true);
					$('#regend').prop('required',true);
				} else { // reg off

					// turn off req dates
					$('#regstart').prop('required',false);
					$('#regend').prop('required',false);
					$('#cutoff').prop('required',false);
				}

			});
			$('#latereg').on('change', function(e) {
				if ($(this).prop("checked")) {
					$('#cutoff').prop('required',true);			
				} else {
					$('#cutoff').prop('required',false);								
				}

			});

		}
	},





	all : function(){
	

		$('.tournamentDeleteBtn').on('click', function (e) {
			var srcField = $(this);

			
			bootbox.confirm({
				message: "Are you sure you wish to delete this tournament?<br><br>This will delete all players and teams associated with the tournament.",
				closeButton: false,
				buttons: {
					cancel: {
						label: 'No',
						className: 'btn btn-danger'
					},
					confirm: {
						label: 'Yes',
						className: 'btn btn-success'
					}
				},
				callback: function (result) {					
					if (result) {
						siteAjax.deleteTournament($(srcField).data('tournamentid'), false, $(srcField), $(srcField).data('relocate'));
					}
				}
			});
		});

	}

};




