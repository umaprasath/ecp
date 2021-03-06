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
    <script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/routeboxer/src/RouteBoxer.js"></script>
    <script>
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var waypts = [];
var pointsArray = [];
var jsonArray;
var routeWpt ;
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
var routeBoxer = new RouteBoxer();
var distance = 5; // km

function calcRoute() {
	
	  
	  
  var start = document.getElementById('start').value;
  var end = document.getElementById('end').value;
  document.getElementById("from").value=start;
  document.getElementById("to").value=end;
  var waypts1 = [];
jsonArray ='{"data": [';
   for (var i = 0; i < pointsArray.length; i=i+50) {
	//jsonArray= jsonArray+ '{"lat":'+ pointsArray[i].lat()+',"lng":'+pointsArray[i].lng()+'}';
	jsonArray= jsonArray+ '{'+ pointsArray[i]+'}';
	if(i+50<pointsArray.length)
		jsonArray =jsonArray+',';	
	waypts1.push({
          location:new google.maps.LatLng(pointsArray[i].lat(),pointsArray[i].lng()),
          stopover:true});
  }  
  
/*   var path = pointsArray;
  var boxes = routeBoxer.box(path, distance);
 
  for (var i = 0; i < boxes.length; i++) {
    var bounds = boxes[i];
    if(i<8)
    	{
    	alert("inside "+bounds.getNorthEast().lng());
    waypts1.push({
        location:new google.maps.LatLng(bounds.getNorthEast().lat(),bounds.getNorthEast().lng()),
        stopover:true});
    	}
    // Perform search over this bounds 
  }  */

 // document.getElementById("waypoints_save").value = jsonArray+']}';
  document.getElementById("waypoints_save").value = pointsArray;

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
       routeWpt = response.routes[0];
      pointsArray = response.routes[0].overview_path;
    
      document.getElementById('fromLatLng').value=pointsArray[0];
      document.getElementById('toLatLng').value =pointsArray[pointsArray.length-1];
      
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

function setMethod(callerValue)
{
	document.getElementById("method").value=callerValue;
	document.forms[0].submit();
	}
    </script>
  </head>
  <body>
    
    <div id="control_panel" style="float:left;width:30%;text-align:left;padding-top:20px">
    <div style="margin:20px;border-width:2px;">
    <b>Start:</b><br>
     <input style="width:100%" id="start" class="controls" type="text" name="start"
        placeholder="Enter a location"/>
        <br>
    <br>
    <b>End:</b><br>
     <input id="end" style="width:100%" class="controls" type="text" name="end"
        placeholder="Enter a location">
    <br><br>
      <input type="submit" onclick="getWaypoints();" value="Get Way Points">
        <input type="submit" onclick="calcRoute();">
          <form action="/ecp-gmap/EcpGMapInegrationServlet" method="post">
    <input type="hidden" id="waypoints_save" name="waypoints_save"/>
    <input type="hidden" id="from" name="from"/>
    <input type="hidden" id="to" name="to"/>
    <input type="hidden" id="fromLatLng" name="fromLatLng"/>
    <input type="hidden" id="toLatLng" name="toLatLng"/>
    
    <input type="hidden" id="method" name="method"/>
    <input type="button" value="save" onclick="setMethod('save')"/>
    </form>
    </div>
    <div id="directions_panel" style="margin:20px;background-color:#FFEE77;"></div>
    </div>
    <div id="map-canvas" style="float:right;width:70%;height:100%;"></div>
  
  </body>
</html>