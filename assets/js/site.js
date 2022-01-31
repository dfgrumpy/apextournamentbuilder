
/*
    Primary system wide JS file
*/

// main function
mainNS = {


    init: function () {
        try {
            (function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }

                            form.classList.add('was-validated')
                        }, false)
                    })
            })()

        } catch (e) {
            return false;
        }
        $('[data-bs-toggle="tooltip"]').tooltip({
            delay: { "show": 2000, "hide": 100 }            
        });
        


    },



    forgotLogin: function (ui) {

        var error = '', $emailField = $('#accountEmail')

        $(".has-error").removeClass("has-error");
        error += ($emailField.val().length) ? 0 : $emailField.closest('.form-group').toggleClass('has-error');


        if (error == 0) {
            formData = JSON.stringify($('#modalForm').serializeArray());
            package = { modal: true, url: '/ajax/savedata/item/forgotlogin', payload: formData, handler: 'mainNS.forgotLoginResult' };
            siteAjax.saveFormData(package);
        } else {
            uiNS.displayNotification('danger', 'Please enter your account email address.', '#baseModal');
        }


    },


    forgotLoginResult: function (res) {


        uiNS.setModalHide();
        // display alert after a 2 seconds so that modal closes first.
        setTimeout(function () {
            uiNS.displayNotification('success', 'If the email address entered is known, an email will be sent to that address with further instructions.');
        }, 2000);

    },

    processRegister: function () {
        
        $('#registerContinueBtn').toggleClass('disabled');

        if ($('#fname').val().length == 0 || $('#password').val().length == 0 || $('#email').val().length == 0) {
            $('.infoIncompleteForm').toggleClass('d-none');
            $('#registerContinueBtn').toggleClass('disabled');
        } else {
            $('#infoForm').submit();

        }

    },


    processTournamentCreate: function () {        
        alert('here');
    },


};
