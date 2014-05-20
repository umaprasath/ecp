<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="navigation.jsp"></jsp:include>
<jsp:include page="search-places.jsp"></jsp:include>
<html ng-app="ecpApp">
<head>
  

<link rel="stylesheet" href="app/css/app.css">
<!-- <link rel="stylesheet" href="app/css/bootstrap.css"> -->  
  
 <!--  <script src="app/lib/angular/angular.js"></script> -->
  <script src="app/js/controllers.js"></script>
 <!-- <script src="app/js/script.js"></script> --> 
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
<body  ng-controller="ecpCtrl" >
<form style="text-align: left">
    <div style="margin:20px;border-width:2px;">
    <b>Start:</b><br>
        <br> 
        <input type="text" id="Autocomplete1"  ng-autocomplete="start" details="details2" options="options2" />
        <input type="hidden" id="start" />
    
    <div>result: {{start}}</div>
    <br>
    <b>End:</b><br>
    
     <input type="text" id="Autocomplete2"  ng-autocomplete="end" details="details3" options="options3" />
        <input type="hidden" id="end" />
    
   <!--   <input id="end" style="width:40%" class="controls" type="text" name="end"
        placeholder="Enter a location"> -->
    <br><br>
      <p class="perspective">
					<button type="submit" class="btn btn-8 btn-8g" style="float:left" ng-click="click()">Search</button>
				
					<!--  <button class="btn btn-8 btn-8g" >Save</button>-->
				</p>
     
     <!--  <input type="submit" onclick="getWaypoints();" value="Get Way Points">
        
        <input type="submit" onclick="calcRoute();">  -->
        <input type="hidden" id="from"/>
        <input type="hidden" id="to"/>
  <!--       <input type="button" id="submit" value="Search"  ng-click="click()"/> -->
        

     </form>
      <div class="span10">
        <!--Body content-->
  Filter : <input ng-model="query">
 <!--        <ul class="routes">
          <li ng-repeat="route in routes | filter:query ">
       
            {{route.from_geo_location}}
            <p>{{route.to_geo_location}}</p>
          </li>
        </ul> -->
        </div>
             <div class="gridStyle" ng-grid="gridOptions"></div>
           </div>   
          <form action="/EcpGMapInegrationServlet.do" method="post">
    <input type="hidden" id="waypoints_save" name="waypoints_save"/>
    <input type="hidden" id="from" name="from"/>
    <input type="hidden" id="to" name="to"/>
    <input type="hidden" id="method" name="method"/>
<!--     <input type="button" value="save" onclick="setMethod('save')"/> -->
    </form>

    	<script>
			var buttons7Click = Array.prototype.slice.call( document.querySelectorAll( '#btn-click button' ) ),
				buttons9Click = Array.prototype.slice.call( document.querySelectorAll( 'button.btn-8g' ) ),
				
				buttonsSaveClick = Array.prototype.slice.call( document.querySelectorAll( 'button.btn-9g' ) ),
				
				totalButtons7Click = buttons7Click.length,
				totalButtons9Click = buttons9Click.length;
			
			totalButtonsClick = buttonsSaveClick.length;

			buttons7Click.forEach( function( el, i ) { el.addEventListener( 'click', activate, false ); } );
			buttons9Click.forEach( function( el, i ) { el.addEventListener( 'click', activate, false ); } );

			function activate() {
				var self = this, activatedClass = 'btn-activated';

			 if( classie.has( this, 'btn-8g' ) ) {
					// if it is the first of the two btn-8g then activatedClass = 'btn-success3d';
					// if it is the second then activatedClass = 'btn-error3d'
					// alert(buttons9Click.indexOf( this ) +"::"+totalButtons9Click);
					activatedClass = buttons9Click.indexOf( this ) === totalButtons9Click-1 ? 'btn-success3d' : 'btn-error3d';
				}
			 else
				 {
				 
				 alert(buttonsSaveClick.indexOf( this )+"::"+buttonsSaveClick);
				 activatedClass = buttonsSaveClick.indexOf( this ) === buttonsSaveClick-1 ? 'btn-success3d' : 'btn-error3d';
				 }

				if( !classie.has( this, activatedClass ) ) {
					classie.add( this, activatedClass );
			//		 setTimeout( function() { classie.remove( self, activatedClass ) }, 1000 );
				}
				else
					{
					classie.remove( self, activatedClass ) ;
					}
			}

			document.querySelector( '.btn-7i' ).addEventListener( 'click', function() {
				classie.add( document.querySelector( '#trash-effect' ), 'trash-effect-active' );
			}, false );
		</script>
</body>


</html>