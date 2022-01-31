
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
							util.executeFunctionByName(handler, window);
						}
						setTimeout(function () {
							// wait 3 seconds and turn the milticheck off
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


	},

	main :{
		default: function(){
			
		}

	},

	
	alerts: {
		default: function () {
			
		}
	},


	tournament: {
		create: function () {

		},

		detail: function () {			

			$('.tournamentEditeBtn').on('click', function (e) {
				siteAjax.loadModalContent('tournamentedit/tournamentid/' + $(this).data('tournamentid'), 'Tournament Edit : ' + $(this).closest('div .row').children('div .text-start').text(), 'large');
			});
		},
		mytournaments: function () {
			
			$('.tournamentEditeBtn').on('click', function (e) {
				siteAjax.loadModalContent('tournamentedit/tournamentid/' + $(this).data('tournamentid'), 'Tournament Edit : ' + $(this).closest('tr').children('td.tourneyName').text(), 'large');
			});

		},

		manageplayers: function () {
			$('.playerdetailBtn').on('click', function (e) {
				siteAjax.loadModalContent('playerdetail/playerid/' + $(this).data('playerid'), 'Player Details : ' + $(this).data('playername'));
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




