
  <head>
    <title>Place Autocomplete</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      .controls {
        margin-top: 16px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        padding: 0 11px 0 13px;
        width: 400px;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        text-overflow: ellipsis;
      }

      #pac-input:focus {
        border-color: #4d90fe;
        margin-left: -1px;
        padding-left: 14px;  /* Regular padding-left + 1. */
        width: 401px;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
}

    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>

    <script>
    var geocoder;
function initialize() {
	geocoder = new google.maps.Geocoder();
  var input = /** @type {HTMLInputElement} */(
      document.getElementById('start'));
  var autocomplete = new google.maps.places.Autocomplete(input);
 // autocomplete.bindTo('bounds', map);
   google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }
     var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }
    //infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    //infowindow.open(map, marker);
  });

   
   
   var endInput = /** @type {HTMLInputElement} */(
		      document.getElementById('end'));
		  var autocompleteEnd = new google.maps.places.Autocomplete(endInput);
		 // autocomplete.bindTo('bounds', map);
		   google.maps.event.addListener(autocompleteEnd, 'place_changed', function() {
		    var place = autocompleteEnd.getPlace();
		    if (!place.geometry) {
		      return;
		    }
		     var address = '';
		    if (place.address_components) {
		      address = [
		        (place.address_components[0] && place.address_components[0].short_name || ''),
		        (place.address_components[1] && place.address_components[1].short_name || ''),
		        (place.address_components[2] && place.address_components[2].short_name || '')
		      ].join(' ');
		    }
		    //infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
		    //infowindow.open(map, marker);
		  });

}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
<!--   <body>
    <input id="pac-input" class="controls" type="text"
        placeholder="Enter a location">
  </body> -->
