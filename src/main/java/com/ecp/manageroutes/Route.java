package com.ecp.manageroutes;

public class Route {
	
	private String from;
	private String to;
	private String waypoints;
	private String fromLatLng;
	private String toLatLng;
	private String customerEmail;
	
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getFromLatLng() {
		return fromLatLng;
	}
	public void setFromLatLng(String fromLatLng) {
		this.fromLatLng = fromLatLng;
	}
	public String getToLatLng() {
		return toLatLng;
	}
	public void setToLatLng(String toLatLng) {
		this.toLatLng = toLatLng;
	}
	private Float fromLat;
	private Float fromLng;
	private Float toLat;
	private Float toLng;
	
	
	
	public Float getFromLat() {
		fromLat = Float.valueOf(this.fromLatLng.split(",")[0].replace("(", ""));
		return fromLat;
	}
	public Float getFromLng() {
		fromLng = Float.valueOf(this.fromLatLng.split(",")[1].replace(")", ""));
		return fromLng;
	}
	public Float getToLat() {
		toLat = Float.valueOf(this.toLatLng.split(",")[0].replace("(", ""));
		return toLat;
	}
	public Float getToLng() {
		toLng = Float.valueOf(this.toLatLng.split(",")[1].replace(")", ""));
		return toLng;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getWaypoints() {
		return waypoints;
	}
	public void setWaypoints(String waypoints) {
		this.waypoints = waypoints;
	}

}
