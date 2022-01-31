util = {

    setCookie: function (cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";path=/;expires=" + expires;
    },

    getCookie: function (cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
            if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
        }
        return "";
    },

    checkCookie: function () {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    },

    executeFunctionByName: function (functionName, context /*, args */) {

        var args = [].slice.call(arguments).splice(2);
        var namespaces = functionName.split(".");
        var func = namespaces.pop();
        for (var i = 0; i < namespaces.length; i++) {
            context = context[namespaces[i]];
        }
        return context[func].apply(context, args);
    },

    isJson: function (str) {
        try {
            JSON.parse(JSON.stringify(str));
        } catch (e) {
            return false;
       }
        return true;
    },

    urltoArray: function () {
        /* convert url to array stripping blank elements*/
        return window.location.pathname.split('/').filter(Boolean);
    },

    resetDatatable: function () {
        try {
            ticketTable.clear().draw();
            $('#tableCountVal').html('');
        } catch (e) {
            return;
        }
    },

    reloadType: function () {


        thisUrl = util.urltoArray().pop();
        if (thisUrl.indexOf('company') !== -1 || thisUrl.indexOf('mine') !== -1) {
            return 'single';
        } else {
            return 'full';
        }


    }




}



