<!DOCTYPE html>
<jsp:include page="search-places.jsp"></jsp:include>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Waypoints in directions</title>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
    <!-- <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script> -->
    <script>
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var waypts = [];
var pointsArray = [];
var jsonArray;
function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var chicago = new google.maps.LatLng(12.835833, 80.2025);
  var mapOptions = {
    zoom: 6,
    center: chicago
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  directionsDisplay.setMap(map);
}

function calcRoute() {

  var start = document.getElementById('start').value;
  var end = document.getElementById('end').value;
  var waypts1 = [];
//   var checkboxArray = document.getElementById('waypoints');
jsonArray ='{"data": [';
  for (var i = 0; i < pointsArray.length; i=i+50) {
    //if (checkboxArray.options[i].selected == true) {
 //   	alert(new google.maps.LatLng(pointsArray[i].lat(),pointsArray[i].lng()));
//jsonArray.push({  })

jsonArray= jsonArray+ '{"lat":'+ pointsArray[i].lat()+',"lng":'+pointsArray[i].lng()+'}';

alert(i);

if(i+50<pointsArray.length)
	jsonArray =jsonArray+',';	
	
      waypts1.push({
          location:new google.maps.LatLng(pointsArray[i].lat(),pointsArray[i].lng()),
          stopover:true});
     
    //}
  }
  document.getElementById("waypoints_save").value = jsonArray+']}';
 
 

  var request = {
      origin: start,
      destination: end,
      waypoints: waypts1,
      optimizeWaypoints: false,
      travelMode: google.maps.TravelMode.DRIVING
    
  };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
      var route = response.routes[0];

 
      
      var summaryPanel = document.getElementById('directions_panel');
      summaryPanel.innerHTML = '';
      // For each route, display summary information.
      for (var i = 0; i < route.legs.length; i++) {
        var routeSegment = i + 1;
        summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment + '</b><br>';
        summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
        summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
        summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
      }
    }
  });
}




 function getWaypoints(){
  var start = document.getElementById('start').value;
  var end = document.getElementById('end').value;

 
  var request = {
      origin: start,
      destination: end,
    //  waypoints: waypts,
      optimizeWaypoints: false,
      travelMode: google.maps.TravelMode.DRIVING
    
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
      var route = response.routes[0];
      pointsArray = response.routes[0].overview_path;
    
      
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <div id="map-canvas" style="float:left;width:60%;height:100%;"></div>
    <div id="control_panel" style="float:right;width:40%;text-align:left;padding-top:20px">
    <div style="margin:20px;border-width:2px;">
    <b>Start:</b><br>
     <input style="width:40%" id="start" class="controls" type="text" name="start"
        placeholder="Enter a location">
  <!--   <select id="start">
      <option value="Siruseri, Tamilnadu">Siruseri, Tamilnadu</option>
      <option value="Boston, MA">Boston, MA</option>
      <option value="New York, NY">New York, NY</option>
      <option value="Miami, FL">Miami, FL</option>
    </select> -->
    <br>
   <!--  <b>Waypoints:</b> <br>
    <i>(Ctrl-Click for multiple selection)</i> <br>
    <select multiple id="waypoints">
      <option value="Adyar, Tamilnadu">Adyar, Tamilnadu</input>
      <option value="toronto, ont">Toronto, ONT</input>
      <option value="chicago, il">Chicago</input>
      <option value="winnipeg, mb">Winnipeg</input>
      <option value="fargo, nd">Fargo</input>
      <option value="calgary, ab">Calgary</input>
      <option value="spokane, wa">Spokane</input>
    </select>
    <br> -->
    <b>End:</b><br>
     <input id="end" style="width:40%" class="controls" type="text" name="end"
        placeholder="Enter a location">
   <!--  <select id="end">
      <option value="Tondiarpet, Tamilnadu">Tondiarpet, Tamilnadu</option>
      <option value="Seattle, WA">Seattle, WA</option>
      <option value="San Francisco, CA">San Francisco, CA</option>
      <option value="Los Angeles, CA">Los Angeles, CA</option>
    </select> -->
    <br>
      <input type="submit" onclick="getWaypoints();" value="Get Way Points">
        <input type="submit" onclick="calcRoute();">
          <form action="/ecp-gmap/EcpGMapInegrationServlet" method="post">
    <input type="hidden" id="waypoints_save" name="waypoints_save"/>
    <input type="submit" value="save"/>
    </form>
    </div>
    <div id="directions_panel" style="margin:20px;background-color:#FFEE77;"></div>
    </div>
  
  </body>
</html>