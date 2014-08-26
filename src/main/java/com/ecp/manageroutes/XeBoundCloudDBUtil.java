package com.ecp.manageroutes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class XeBoundCloudDBUtil {
	
//	private static String dbUrl = "jdbc:mysql://instance41355.db.xeround.com:4022/ecpdb";
//	private static String dbUrl = "jdbc:mysql://localhost:3306/ecpdb";
//	private static String dbUrl = "jdbc:mysql://$OPENSHIFT_MYSQL_DB_HOST:$OPENSHIFT_MYSQL_DB_PORT/";
private static String dbUrl = "jdbc:mysql://127.13.160.2:3306/carpool";
	private static String dbClass = "com.mysql.jdbc.Driver";

	public static void main(String args[]) { 
		String dbtime;
		String customeremail;
		String dbUrl = "jdbc:mysql://localhost:3306/ecpdb";
		String dbClass = "com.mysql.jdbc.Driver";
		String query = "Select * FROM ecp_customer";

		try {

		//	Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(dbUrl, "adams",
					"adams123");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				dbtime = rs.getString(1);
				customeremail = rs.getString("customer_name");
				System.out.println(customeremail);
			} // end while

			con.close();
		} // end try

		

		catch (SQLException e) {
			e.printStackTrace();
		}

	} // end main
	
	public static final Connection getConnection()
	{
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		
			 con = DriverManager.getConnection(dbUrl, "adminjSXQQiX",
				"Pe5ivdrBfegT");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
		return con;
	}

} // end class