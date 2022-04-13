
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
                                window.scrollTo({ top: 0, behavior: 'smooth' });
                                uiNS.displayNotification('danger', 'Please correct the errors and submit again.');
                                event.preventDefault();
                                event.stopPropagation();
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



    forgotLogin: function () {
        
        formData = JSON.stringify($('#modalForm').serializeArray());
        package = { modal: true, url: '/ajax/savedata/item/forgotlogin', payload: formData, handler: 'mainNS.forgotLoginResult' };
        siteAjax.saveFormData(package);
        

    },


    forgotLoginResult: function (res) {

        uiNS.setModalHide();
        // display alert after a 2 seconds so that modal closes first.
        setTimeout(function () {
            uiNS.displayNotification('success', 'If the email address entered belongs to an active account, an email will be sent to that address with further instructions.', '', 10000);
        }, 2000);

    },

    processTournamentCreate: function () {        
        alert('here');
    },


};
