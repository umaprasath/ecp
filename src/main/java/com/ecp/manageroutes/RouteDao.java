package com.ecp.manageroutes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;



public class RouteDao {
	
	public List<JSONObject>  read(Route route) 
	{
		Connection con =  XeBoundCloudDBUtil.getConnection();
		Statement stmt;
		List<JSONObject> jsonArray = new ArrayList<JSONObject>();
		try {
			stmt = con.createStatement();
			String[] subStrFrom = route.getFrom().split(",");
			String querySearchFrom = subStrFrom[0]+"%,"+subStrFrom[1].replace(")", "%)");

			String[] subStrTo = route.getTo().split(",");
			String querySearchTo = subStrTo[0]+"%,"+subStrTo[1].replace(")", "%)");
			String query = "Select * FROM ecp_route where from_lat >"+  Float.valueOf(subStrFrom[0].replace("(", "")) +" AND via_route like '%"+querySearchFrom+"%' AND via_route like '%"+ querySearchTo+"%'";
			ResultSet rs = stmt.executeQuery(query); 
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
			
				JSONObject jsonObject = new JSONObject();
				for(int count=1; count<=columnCount;count++)
				{
				jsonObject.put(rsmd.getColumnLabel(count), rs.getString(count));
				}
				jsonArray.add(jsonObject);
		} // end while
		con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonArray;
		
	}
	
	
	public static boolean create(Route route)
	{
		boolean isSuccess=false;

		Connection con =  XeBoundCloudDBUtil.getConnection();
		PreparedStatement stmt;
	//	List<JSONObject> jsonArray = new ArrayList<JSONObject>();
		try {
		String query = "INSERT INTO ecp_route (from_geo_location,to_geo_location,via_route,from_lat,from_lng,to_lat,to_lng,customer_email" +
				") VALUES (?,?,?,?,?,?,?,?);";
		System.out.println("the connection is :"+con);
		stmt = con.prepareStatement(query);
		
		stmt.setString(1, route.getFrom());
		stmt.setString(2, route.getTo());
		stmt.setString(3, route.getWaypoints());
		stmt.setFloat(4, route.getFromLat());
		stmt.setFloat(5, route.getFromLng());
		stmt.setFloat(6, route.getToLat());
		stmt.setFloat(7, route.getToLng());
		stmt.setString(8, route.getCustomerEmail());
	//		JSONObject jsonObject  = new JSONObject(customer);
		isSuccess =stmt.execute();
		con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return isSuccess;
	}
	
	
	public List<JSONObject>  readRideWithConnection(Route route,List<String> friends)
	{
		Connection con =  XeBoundCloudDBUtil.getConnection();
		Statement stmt;
		List<JSONObject> jsonArray = new ArrayList<JSONObject>();
		List<JSONObject> anonymousJsonArray = new ArrayList<JSONObject>();
		try {
			stmt = con.createStatement();
				String[] subStrFrom = route.getFrom().split(",");
				String querySearchFrom = subStrFrom[0]+"%,"+subStrFrom[1].replace(")", "%)");

				String[] subStrTo = route.getTo().split(",");
				String querySearchTo = subStrTo[0]+"%,"+subStrTo[1].replace(")", "%)");


			//	String query = "Select * FROM ecp_route where from_lat >"+  Float.valueOf(subStrFrom[0].replace("(", "")) +" AND via_route like '%"+querySearchFrom+"%' AND via_route like '%"+ querySearchTo+"%'";
				//String query = "Select * FROM ecp_route er join ecp_customer ecid on er.route_id=ecid.route_id where er.from_lat >"+  Float.valueOf(subStrFrom[0].replace("(", "")) +" AND er.via_route like '%"+querySearchFrom+"%' AND er.via_route like '%"+ querySearchTo+"%'";

				String query = "Select * FROM ecp_route er  where er.from_lat >"+  Float.valueOf(subStrFrom[0].replace("(", "")) +" AND er.via_route like '%"+querySearchFrom+"%' AND er.via_route like '%"+ querySearchTo+"%'";
			ResultSet rs = stmt.executeQuery(query); 
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount(); 
		while (rs.next()) {
			JSONObject jsonObject = new JSONObject();
			boolean isFriendRequest =false;
			for(int count=1; count<=columnCount;count++)
			{
			//	if(friends.contains(rs.getString("ecp_user_customer_login_email")))
				if(friends.contains(rs.getString("customer_email")))
				{
					
			jsonObject.put(rsmd.getColumnLabel(count), rs.getString(count));
			isFriendRequest =true;
			 	}
				else
				{
					jsonObject.put(rsmd.getColumnLabel(count), rs.getString(count));
					//isFriendRequest =false;
				}
			}
			
			if(isFriendRequest)
			{
			 jsonArray.add(jsonObject);
			}
			else
			{
			 anonymousJsonArray.add(jsonObject);
			}
		} // end while
		jsonArray.addAll(anonymousJsonArray);
		con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonArray;
		
	}
	
	public static boolean updatePoolRide(String driverEmail,String riderEmail)
	{
		boolean isSuccess=false;

		Connection con =  XeBoundCloudDBUtil.getConnection();
		PreparedStatement stmt;
	//	List<JSONObject> jsonArray = new ArrayList<JSONObject>();
		try {
		String query = "INSERT INTO ecp_pool_ride (driver_email,rider_email) VALUES (?,?);";
		stmt = con.prepareStatement(query);
		stmt.setString(1, driverEmail);
		stmt.setString(2, riderEmail);
		isSuccess =stmt.execute();
		con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return isSuccess;
	}
	
	
	public List<JSONObject>  readUserRides(Route route)
	{
		Connection con =  XeBoundCloudDBUtil.getConnection();
		Statement stmt;
		List<JSONObject> jsonArray = new ArrayList<JSONObject>();
		try {
			stmt = con.createStatement();

		String query = "SELECT * FROM " +
				"ecp_route er join ecp_pool_ride epr on er.customer_email = epr.rider_email	" +
				"join ecp_pool_ride epr_1 on er.customer_email = epr_1.driver_email" +
				" where epr.rider_email= '"+route.getCustomerEmail() +"' or epr_1.driver_email='"+ route.getCustomerEmail()+"'";
		ResultSet rs = stmt.executeQuery(query); 
		 ResultSetMetaData rsmd = rs.getMetaData();
		 int columnCount = rsmd.getColumnCount();
		while (rs.next()) {
			System.out.println("the rs column value is :"+rsmd.getColumnLabel(1));
			JSONObject jsonObject = new JSONObject();
			for(int count=1; count<=columnCount;count++)
			{
			jsonObject.put(rsmd.getColumnLabel(count), rs.getString(count));
			}
			 jsonArray.add(jsonObject);
		} // end while
		con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonArray;
		
	}
	
}
