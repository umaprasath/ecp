package com.ecp.manageroutes;

import java.util.List;

import org.json.JSONObject;

public class RouteManager {

	public String getRoute(Route route)
	{ 
		System.out.println("the name is ::"+route.getFrom()); 
		 RouteDao dao = new RouteDao();
		 List<JSONObject>  jsonResponse = dao.read(route);
		return jsonResponse.toString();
	}
	
	public String getUserRoutes(Route route)
	{ 
		System.out.println("the name is ::"+route.getFrom()); 
		 RouteDao dao = new RouteDao();
		 List<JSONObject>  jsonResponse = dao.readUserRides(route);
		System.out.println("the string is :"+jsonResponse);
		return jsonResponse.toString();
	}
	
	public boolean save(Route route)
	{ 
		System.out.println("the name is ::"+route.getFrom());
		 RouteDao dao = new RouteDao();
		 boolean  jsonResponse = dao.create(route);
		System.out.println("the string is :"+jsonResponse);
		return jsonResponse;
	}
	
	
	public String getRouteWithConnection(Route route,List<String> friends)
	{ 
		System.out.println("the name is ::"+route.getFrom()); 
		 RouteDao dao = new RouteDao();
		 List<JSONObject>  jsonResponse = dao.readRideWithConnection(route,friends);
		return jsonResponse.toString();
	}
	
	public boolean updatePoolRide(String driverEmail,String riderEmail)
	{ 
		 RouteDao dao = new RouteDao();
		 boolean  jsonResponse = dao.updatePoolRide(driverEmail,riderEmail);
		System.out.println("the string is :"+jsonResponse);
		return jsonResponse;
	}
}
