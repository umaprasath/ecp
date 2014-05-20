<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8"/>
		<title>Learn AngularJS - Navigation Menu</title>

		<!-- <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet" />-->

		<!-- The main CSS file -->
		<link href="navigation-style.css" rel="stylesheet" />

	<link href="default.css" rel="stylesheet" />
		<link href="component.css" rel="stylesheet" />
		<script src="classie.js"></script>
	<script src="modernizr.custom.js"></script>

		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>

	<!-- The ng-app directive tells angular that the code below should be evaluated -->

	<body ng-app>

		<!-- The navigation menu will get the value of the "active" variable as a class.
			 The $event.preventDefault() stops the page from jumping when a link is clicked. -->

		<nav class="{{active}}" >

			<!-- When a link in the menu is clicked, we set the active variable -->

			<a href="/jsp/home.jsp" class="home" ng-click="active='home'">Home</a>
			<a href="/jsp/Routes.jsp" class="searchride" ng-click="active='searchride'">Create Ride</a>
			<a href="/jsp/searchride.jsp" class="services" ng-click="active='services'">Car Pool</a>
			<a href="#" class="contact" ng-click="active='contact'">Contact</a>
		</nav>

		<!-- ng-show will show an element if the value in the quotes is truthful,
			 while ng-hide does the opposite. Because the active variable is not set
			 initially, this will cause the first paragraph to be visible. -->

	<!--  	<p ng-hide="active">Please click a menu item</p>
		<p ng-show="active">You chose <b>{{active}}</b></p>-->

		<!-- Include AngularJS from Google's CDN -->
	<!--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"></script>-->
	 <script src="app/lib/angular/angular.min.js"></script> 
	  <script src="app/lib/angular/angular-route.js"></script> 
	
	</body>
</html>
