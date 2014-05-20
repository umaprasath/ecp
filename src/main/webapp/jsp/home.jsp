<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="navigation.jsp"></jsp:include>
<jsp:include page="search-places.jsp"></jsp:include>
<html ng-app="ecpApp">
<head>
  

<link rel="stylesheet" href="app/css/app.css">
  <script src="app/js/controllers.js"></script>
      <script src="app/js/ngAutocomplete.js"></script>
         <script src="app/js/ng-grid-2.0.7.debug.js"></script>
         <link rel="stylesheet" type="text/css" href="app/css/ng-grid.css" />
      <style type="text/css">
      .gridStyle {
    border: 1px solid rgb(212,212,212);
    width: 100%; 
    height: 300px;
}
</style>
        <script type="text/javascript">
  function codeAddress() {
	    var address = document.getElementById("Autocomplete").value;
	    geocoder.geocode( { 'address': address}, function(results, status) {
	    
	      if (status == google.maps.GeocoderStatus.OK) {
	    	  document.getElementById("start").value=results[0].geometry.location;
	    		 
	    	 // jsonArray= jsonArray+ '{"lat":'+ pointsArray[i].lat()+',"lng":'+pointsArray[i].lng()+'}';
	    //    map.setCenter(results[0].geometry.location);
	    /*     var marker = new google.maps.Marker({
	            map: map,
	            position: results[0].geometry.location
	        }); */
	      } else {
	        alert("Geocode was not successful for the following reason: " + status);
	      }
	    });
	  }
  </script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
    
    
</head>
<body  ng-controller="ecpCtrl" data-ng-init="loadUserRide()" >
<div style="background: grey;color:white;padding: 10px;width:50%" align="center">My Active Ride</div>
<!--  data-ng-init="loadUserRide()" -->
             <div class="gridStyle" ng-grid="homePageGrid" style="width:50%"></div>
           </div>   
      	
</body>


</html>