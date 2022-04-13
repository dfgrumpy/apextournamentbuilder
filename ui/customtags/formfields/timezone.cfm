<cfif ! IsDefined("thisTag.executionMode")>
	<cfthrow message="Custom tag can't be called directly!">
	<cfabort>
</cfif>

<cfif thisTag.executionMode is "end">
    <cfexit>
</cfif>

<cfparam name="attributes.value" default="" >

<cfscript>
    timezones =[ {"timezone" : "Hawaii"},
        {"timezone" : "Alaska"},
        {"timezone" : "Pacific Time (US / Canada)"},
        {"timezone" : "Arizona"},
        {"timezone" : "Mountain Time (US / Canada)"},
        {"timezone" : "Central Time (US / Canada)"},
        {"timezone" : "Eastern Time (US / Canada)"},
        {"timezone" : "-------------"},
        {"timezone" : "Midway Island"},
        {"timezone" : "Samoa"},
        {"timezone" : "Tijuana"},
        {"timezone" : "Chihuahua"},
        {"timezone" : "Mazatlan"},
        {"timezone" : "Central America"},
        {"timezone" : "Guadalajara"},
        {"timezone" : "Mexico City"},
        {"timezone" : "Monterrey"},
        {"timezone" : "Saskatchewan"},
        {"timezone" : "Bogota"},
        {"timezone" : "Lima"},
        {"timezone" : "Quito"},
        {"timezone" : "Caracas"},
        {"timezone" : "Atlantic Time (Canada)"},
        {"timezone" : "La Paz"},
        {"timezone" : "Santiago"},
        {"timezone" : "Newfoundland"},
        {"timezone" : "Brasilia"},
        {"timezone" : "Buenos Aires"},
        {"timezone" : "Georgetown"},
        {"timezone" : "Greenland"},
        {"timezone" : "Mid-Atlantic"},
        {"timezone" : "Azores"},
        {"timezone" : "Cape Verde Is."},
        {"timezone" : "Casablanca"},
        {"timezone" : "Dublin"},
        {"timezone" : "Edinburgh"},
        {"timezone" : "Lisbon"},
        {"timezone" : "London"},
        {"timezone" : "Monrovia"},
        {"timezone" : "Amsterdam"},
        {"timezone" : "Belgrade"},
        {"timezone" : "Berlin"},
        {"timezone" : "Bern"},
        {"timezone" : "Bratislava"},
        {"timezone" : "Brussels"},
        {"timezone" : "Budapest"},
        {"timezone" : "Copenhagen"},
        {"timezone" : "Ljubljana"},
        {"timezone" : "Madrid"},
        {"timezone" : "Paris"},
        {"timezone" : "Prague"},
        {"timezone" : "Rome"},
        {"timezone" : "Sarajevo"},
        {"timezone" : "Skopje"},
        {"timezone" : "Stockholm"},
        {"timezone" : "Vienna"},
        {"timezone" : "Warsaw"},
        {"timezone" : "West Central Africa"},
        {"timezone" : "Zagreb"},
        {"timezone" : "Athens"},
        {"timezone" : "Bucharest"},
        {"timezone" : "Cairo"},
        {"timezone" : "Harare"},
        {"timezone" : "Helsinki"},
        {"timezone" : "Istanbul"},
        {"timezone" : "Jerusalem"},
        {"timezone" : "Kyiv"},
        {"timezone" : "Minsk"},
        {"timezone" : "Pretoria"},
        {"timezone" : "Riga"},
        {"timezone" : "Sofia"},
        {"timezone" : "Tallinn"},
        {"timezone" : "Vilnius"},
        {"timezone" : "Baghdad"},
        {"timezone" : "Kuwait"},
        {"timezone" : "Moscow"},
        {"timezone" : "Nairobi"},
        {"timezone" : "Riyadh"},
        {"timezone" : "St. Petersburg"},
        {"timezone" : "Volgograd"},
        {"timezone" : "Tehran"},
        {"timezone" : "Abu Dhabi"},
        {"timezone" : "Baku"},
        {"timezone" : "Muscat"},
        {"timezone" : "Tbilisi"},
        {"timezone" : "Yerevan"},
        {"timezone" : "Kabul"},
        {"timezone" : "Ekaterinburg"},
        {"timezone" : "Islamabad"},
        {"timezone" : "Karachi"},
        {"timezone" : "Tashkent"},
        {"timezone" : "Chennai"},
        {"timezone" : "Kolkata"},
        {"timezone" : "Mumbai"},
        {"timezone" : "New Delhi"},
        {"timezone" : "Kathmandu"},
        {"timezone" : "Almaty"},
        {"timezone" : "Astana"},
        {"timezone" : "Dhaka"},
        {"timezone" : "Novosibirsk"},
        {"timezone" : "Sri Jayawardenepura"},
        {"timezone" : "Rangoon"},
        {"timezone" : "Bangkok"},
        {"timezone" : "Hanoi"},
        {"timezone" : "Jakarta"},
        {"timezone" : "Krasnoyarsk"},
        {"timezone" : "Beijing"},
        {"timezone" : "Chongqing"},
        {"timezone" : "Hong Kong"},
        {"timezone" : "Irkutsk"},
        {"timezone" : "Kuala Lumpur"},
        {"timezone" : "Perth"},
        {"timezone" : "Singapore"},
        {"timezone" : "Taipei"},
        {"timezone" : "Ulaan Bataar"},
        {"timezone" : "Urumqi"},
        {"timezone" : "Osaka"},
        {"timezone" : "Sapporo"},
        {"timezone" : "Seoul"},
        {"timezone" : "Tokyo"},
        {"timezone" : "Yakutsk"},
        {"timezone" : "Adelaide"},
        {"timezone" : "Darwin"},
        {"timezone" : "Brisbane"},
        {"timezone" : "Canberra"},
        {"timezone" : "Guam"},
        {"timezone" : "Hobart"},
        {"timezone" : "Melbourne"},
        {"timezone" : "Port Moresby"},
        {"timezone" : "Sydney"},
        {"timezone" : "Vladivostok"},
        {"timezone" : "Magadan"},
        {"timezone" : "New Caledonia"},
        {"timezone" : "Solomon Is."},
        {"timezone" : "Auckland"},
        {"timezone" : "Fiji"},
        {"timezone" : "Kamchatka"},
        {"timezone" : "Marshall Is."},
        {"timezone" : "Wellington"},
        {"timezone" : "Nuku'alofa"}];


 </cfscript>







<cfoutput>

        <label for="timezone" class="form-label">Tournament Time Zone</label>
        <select class="form-select form-select mb-3" aria-label="form-select-lg example" id="timezone" name="timezone" required>
            <option value="">Please select a time   zone</option>
		 	<cfloop array="#timezones#" index="i" >		 		
                <cfset disabled = (i.timezone contains "---") ? 'disabled="disabled"': ''>
    	  		<option value="#i.timezone#" #disabled# <cfif len(attributes.value) and attributes.value eq i.timezone>selected="selected"</cfif>>#i.timezone#</option>
		  	</cfloop>
		</select>
</cfoutput>

