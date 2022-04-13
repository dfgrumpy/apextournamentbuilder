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


    },

     dateDiff : function(start,end,interval) {
        
        var date1 = new Date(start);
        var date2 = new Date(end);
        date1.setHours(0,0,0,0);
        date2.setHours(0,0,0,0);

        // One day in milliseconds
        var oneDay = 1000 * 60 * 60 * 24;
    
        // Calculating the time difference between two dates
        var diffInTime = date2.getTime() - date1.getTime();
    
        // Calculating the no. of days between two dates
        var diffInDays = Math.round(diffInTime / oneDay);
    
        return diffInDays;

    },

    setEventDates : function(){
        
        date = new Date($('#eventdate').val())
        date.setDate(date.getDate() - 2);
        $('#cutoff').val(date.toISOString().split('T')[0]);
        date.setDate(date.getDate() - 2);
        $('#regend').val(date.toISOString().split('T')[0]);
        date.setDate(date.getDate() - 7);
        $('#regstart').val(date.toISOString().split('T')[0]);

    }


}



