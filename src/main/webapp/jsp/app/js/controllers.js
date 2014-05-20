'use strict';

/* Controllers */

var ecpApp = angular.module('ecpApp', ['ngAutocomplete','ngGrid','ngRoute']);

ecpApp.controller('ecpCtrl', function($scope, $http) {

/*  $http.get('/ecp-gmap/EcpGMapInegrationServlet?from={"lat":13.07909,"lng":80.24074},{"lat":13.086310000000001,"lng":80.22337}').success(function(data) {
	  $scope.phones = data;
  });*/

  $scope.orderProp = 'age';
 
  $scope.editableInPopup = '<button id="editBtn" type="button" class="btn btn-4 btn-4a" ng-click="saveRide(row)" >Ride Along</button> ';
	 
  $scope.saveRide = function(row) {
	  //Enter code to update ride
/*	  $http.post('/ecp-app/RideAlong.do', row.entity.customer_email).success(function(response){
		  
		  if(response.status=='OK'){
			  $.each($scope.routes,function(index,result){
				 //array.update(row.status) 
				 
				  row.editBtn.disabled=true;
			  });
		  }
	  });*/
	  $http({
		  method:"post",
		  url:'/RideAlong.do', 
		  data: "row_data="+JSON.stringify({row_data:row.entity}),
	//	  dataType:"string",
		  headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).success(function(response){
		  
		  
		  if(response.status=='OK'){
			  $.each($scope.routes,function(index,result){
				 //array.update(row.status) 
				 
				  row.editBtn.disabled=true;
			  });
	  }
		  });	  

  };
	  
  $scope.routes=[];
  $scope.gridOptions = {
		    data: 'routes',
		    rowHeight: 50,
		    columnDefs: [
		    {field:'from_geo_location', displayName:'From'},
		    {field:'to_geo_location', displayName:'To'},
		    {field:'customer_email', displayName:'Friend Name'},
		    {displayName:'Tag',cellTemplate:$scope.editableInPopup}
	    /*	    {field:'orderAgreement', displayName:'Order Agreement'},
		    {field:'licenseType', displayName:'License Type'},
		    {field:'status', displayName:'Status'}*/
		    ],
		    enableCellSelection: true,
		};
  
  
  $scope.homePageGrid= {
		    data: 'routes',
		    rowHeight: 30,
		    width:50,
		    columnDefs: [
		    {field:'from_geo_location', displayName:'From'},
		    {field:'to_geo_location', displayName:'To'},
		    {field:'customer_email', displayName:'Friend Name'},
		    /*   {displayName:'Tag',cellTemplate:$scope.editableInPopup}
	    	    {field:'orderAgreement', displayName:'Order Agreement'},
		    {field:'licenseType', displayName:'License Type'},
		    {field:'status', displayName:'Status'}*/
		    ],
		    enableCellSelection: true,
		};
  
  $scope.loadUserRide = function (){
  $http.get('/getUserRide.do').success(function(data) {
  	  $scope.routes = data;
  	
    }); 
  };
  // loadUserRide();
 
  
  $scope.click = function() {
	  $scope.list = [];
	  
	  var fromJsonQuery;
	  var toJsonQuery;
    if (this.start) {
      this.list.push(this.start);
      
	    var  startAddress= document.getElementById("Autocomplete1").value;
	    
	   // geocoder.geocode( { 'address': address}, function(results, status) {
	    geocoder.geocode({ 'address': startAddress}, function(results, status) {
	      if (status == google.maps.GeocoderStatus.OK) {
	    	  
	    	  document.getElementById("start").value=results[0].geometry.location;
	    /*	  alert("in code adres"+results[0].geometry.location.lat()); */
	    	  //var jsonQuery= '{"lat":'+ results[0].geometry.location.lat().toFixed(2)+',"lng":'+results[0].geometry.location.lng().toFixed(2)+'}';
	    	  var searchLat = Math.floor(results[0].geometry.location.lat()*100)/100;
	    	  var searchLng = Math.floor(results[0].geometry.location.lng()*100)/100
	    	   fromJsonQuery= '('+ searchLat+', '+searchLng+')'; 

/*	    	  $http.get('/ecp-gmap/EcpGMapInegrationServlet?from='+jsonQuery).success(function(data) {
	        	  $scope.phones = data;
	          }); 
*/	    //    map.setCenter(results[0].geometry.location);
	    /*     var marker = new google.maps.Marker({
	            map: map,
	            position: results[0].geometry.location
	        }); */
	      } else {
	        alert("Geocode was not successful for the following reason: " + status);
	      }
	    });
	    
	    var endAddress = document.getElementById("Autocomplete2").value;
	    geocoder.geocode({ 'address': endAddress}, function(results, status) {
	      if (status == google.maps.GeocoderStatus.OK) {
	    	  document.getElementById("end").value=results[0].geometry.location;
	    /*	  alert("in code adres"+results[0].geometry.location.lat()); */
	    	  //var jsonQuery= '{"lat":'+ results[0].geometry.location.lat().toFixed(2)+',"lng":'+results[0].geometry.location.lng().toFixed(2)+'}';
	    	  var searchLat = Math.floor(results[0].geometry.location.lat()*100)/100;
	    	  var searchLng = Math.floor(results[0].geometry.location.lng()*100)/100
	    	  toJsonQuery= '('+ searchLat+', '+searchLng+')'; 
	    	  document.getElementById("from").value=fromJsonQuery;
	    	  document.getElementById("to").value=toJsonQuery;
	    
	    	//  alert("in code adres"+results[0].geometry.location);
	    	 // var jsonQuery = results[0].geometry.location;
	    	 /* $http.get('/ecp-gmap/EcpGMapInegrationServlet?from='+jsonQuery).success(function(data) {
	        	  $scope.phones = data;
	          }); */
	    	
	    	//	  $http.get('/ecp-app/EcpGMapInegrationServlet.do?from='+fromJsonQuery+'&to='+toJsonQuery).success(function(data) {
	  	  $http.get('/GetRide.do?from='+fromJsonQuery+'&to='+toJsonQuery).success(function(data) {
	    	  	  $scope.routes = data;
	    	  	
	    	    }); 
	    //    map.setCenter(results[0].geometry.location);
	    /*     var marker = new google.maps.Marker({
	            map: map,
	            position: results[0].geometry.location
	        }); */
	      } else {
	        alert("Geocode was not successful for the following reason: " + status);
	      }
	    });
	    
	 

	    
    
    //  this.start = '';
    }

  };
  
});
