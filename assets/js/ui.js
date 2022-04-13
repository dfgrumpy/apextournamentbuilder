
uiNS = {

    setModalContent: function (title, body) {
        $('#myModalBody').html(body);
        uiNS.setModalTitle(title);
     //   uiNS.setModalAlert();
    },

    setModalTitle: function (title) {
        $('#myModalLabel').html(title);
    },


    setModalAlert: function (alertTxt) {

        var alert = (typeof alertTxt === 'undefined') ? '' : alertTxt;
        $('#myModalAlert').html(alert);
        if (!alert.length) { // if it is blank hide element
            $('#myModalAlert').addClass('hidden');
        } else {
            $('#myModalAlert').removeClass('hidden');
        }

    },

    setModalHide: function () {
        $('#baseModal').modal('hide');
        uiNS.setModalContent();
    },



    displayNotification: function (type, msg, element, delay) {

        // delay the hide of the alert in MS (1000 = 1 sec)
        var delayVal = (typeof delay === 'undefined') ? '5000' : delay;

        // if the modal is open we need to anchor the notification to the modal so it will appear above it
        var element = $('#baseModal').is(':visible') ? '#baseModal' : 'body';
        element = $('.bootbox-prompt').is(':visible') ? '.bootbox-prompt' : element;

        $('#toastBody').html(msg);

        // clear out any alert classes
        $("#toastHeader").removeClass(function (index, className) {
            return (className.match(/(^|\s)alert-\S+/g) || []).join(' ');
        });

        $('#toastHeader').addClass('alert-' + type);
        $('.toast').toast('show');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    },


    updateTeamBorder: function (playercount, item) {

        maxcount = $('#tournamentInfo').data('teamsize');

        $(item).removeClass (function (index, className) {
            return (className.match (/(^|\s)border-\S+/g) || []).join(' ');
        });

        if (playercount == maxcount) {
            $(item).addClass('border-success');
        } else if (playercount == 0){
            $(item).addClass('border-danger');
        } else {
            $(item).addClass('border-warning');            
        }

        completion = Math.floor(($('.border-success').length / $('#teamCompletionProgress').data('maxteams')) * 100) + '%';
        $('#teamCompletionProgress').css('width', completion);
        
    },

    showModalCloseFooter : function(type){

        if (type == 0) {// normal
            $("#primary-footer").removeClass('d-none');
            $("#close-only-footer").addClass('d-none');        
        } else { // close only
            $("#primary-footer").addClass('d-none');
            $("#close-only-footer").removeClass('d-none');
        }

    }


};





