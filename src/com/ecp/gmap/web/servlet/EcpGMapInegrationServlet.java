package com.ecp.gmap.web.servlet;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.ecp.manageroutes.Route;
import com.ecp.manageroutes.RouteManager;

/**
 * Servlet implementation class EcpGMapInegrationServlet
 */

@WebServlet("/EcpGMapInegrationServlet") 
public class EcpGMapInegrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EcpGMapInegrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Inject it throuh spring
		RouteManager routeManager = new RouteManager();
		Route route = new Route();
		route.setFrom((String)request.getParameter("from"));
		route.setTo((String)request.getParameter("to"));
		 response.getWriter().write(routeManager.getRoute(route));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String waypointsFromRequest = (String) request.getParameter("waypoints_save");
		System.out.println("the way  points values are "+ waypointsFromRequest);
		  Route route  = new Route();
		  route.setFrom(request.getParameter("from"));
		  route.setTo(request.getParameter("to"));
		  route.setFromLatLng(request.getParameter("fromLatLng"));
		  route.setToLatLng(request.getParameter("toLatLng"));
		  route.setWaypoints(waypointsFromRequest);
		  RouteManager routeManager = new RouteManager();
		  if("save".equals(request.getParameter("method")))
		  {
			  routeManager.save(route);
		  }
		  else
		  {
			  routeManager.getRoute(route);
			  
		  }
		  request.getRequestDispatcher("/jsp/Routes.jsp").forward(request, response);

	}

}
