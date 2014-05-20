package com.ecp.gmap.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.brickred.socialauth.Contact;
import org.brickred.socialauth.Profile;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ecp.manageroutes.Route;
import com.ecp.manageroutes.RouteManager;

/**
 * Servlet implementation class EcpGMapInegrationServlet
 */

@Controller
public class EcpGMapInegrationServlet  {
	private static final long serialVersionUID = 1L;
       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public EcpGMapInegrationServlet() {
//        super();
//        // TODO Auto-generated constructor stub
//    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	  @RequestMapping(value = "/GetRide")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("the way  points values parameter "+ request.getParameter("waypointssave"));
		RouteManager routeManager = new RouteManager();
		Route route = new Route(); 
		System.out.println("query is "+request.getParameter("query"));
		route.setFrom((String)request.getParameter("from"));
		System.out.println("the from is"+request.getParameter("from"));
		route.setTo((String)request.getParameter("to"));
		System.out.println("the to is"+request.getParameter("to"));
		  Profile profile = (Profile) request.getSession().getAttribute("profile");
		route.setCustomerEmail(profile.getEmail());
		//System.out.println(routeManager.getRoute(route));
		List<Contact> contactList = (ArrayList<Contact>)request.getSession().getAttribute("contacts");
		if(contactList==null)
		{
			contactList = new ArrayList<Contact>();
		}
		List<String> friends =  new ArrayList<String>();
		//int i=0;
		for(Contact contact:contactList)
		{
			friends.add(contact.getEmail());
			
		}
		
		String jsonResponse = routeManager.getRouteWithConnection(route,friends);
		System.out.println("json response"+jsonResponse);
		 response.getWriter().write(jsonResponse);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	    @RequestMapping(value = "/EcpGMapInegrationServlet")
	protected ModelAndView saveRoute(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub 
		//waypoints_save
	    	String routeTo;
	    	System.out.println("inside save route");
	    	 ModelAndView mv = new ModelAndView();
		String waypointsFromRequest = (String) request.getParameter("waypoints_save");
	//	System.out.println("the way  points values are "+ waypointsFromRequest);
		  Route route  = new Route();
		  route.setFrom(request.getParameter("from"));
		  route.setTo(request.getParameter("to"));
		  route.setFromLatLng(request.getParameter("fromLatLng"));
		  route.setToLatLng(request.getParameter("toLatLng"));
		  route.setWaypoints(waypointsFromRequest);
		  
		  Profile profile = (Profile) request.getSession().getAttribute("profile");
		  if(profile !=null)
		  {
		//  System.out.println("the profile name is :"+profile.getEmail());
		  route.setCustomerEmail(profile.getEmail());
		  }
		  else
		  {
			  route.setCustomerEmail("umaprasath.lru@gmail.com");
		  }
		  RouteManager routeManager = new RouteManager();
		  
		  
		  
		  if("save".equals(request.getParameter("method")))
		  {
			  routeManager.save(route);
			//  routeTo="/jsp/Routes.jsp";
			  routeTo="/jsp/Routes.jsp";
		  }
		  else
		  {
			  routeManager.getRoute(route);
			  routeTo="navigation.jsp";
			  
		  }
		 // System.out.println("contaisn "+ jsonArry.contains(((JSONObject)jsonArry.get(1))));
		  request.getRequestDispatcher("/jsp/Routes.jsp").forward(request, response);
//		  
//		    mv.addObject("profile", provider.getUserProfile());
//            mv.addObject("contacts", contactsList);
	//	List<Contact> contactList = (List) model.asMap().get("contacts");
				//request.getAttribute("contacts"); 
				//mv.getModel().get("contacts");
		
//		  System.out.println("the model value is ::"+((Profile)model.asMap().get("profile")).getEmail());
		  System.out.println(request.getSession().getAttribute("contacts"));
		  
//		for(Contact contact:contactList)
//		{
//			System.out.println("the contacts are"+contact.getEmail());
//		}
//			
            mv.setViewName(routeTo);

            return mv;
		 
			
		
	}

	    
	    
	    @RequestMapping(value = "/RideAlong")
	protected ModelAndView saveRideAlong(Model model, final HttpServletRequest request) throws ServletException, IOException 
	{
	 
	    	System.out.println(request.getAttribute("row_data"));
	    	System.out.println(request.getParameter("row_data"));
	    	String requestParam = request.getParameter("row_data");
	    	System.out.println("the value os reques tparam as string is ::"+request.getParameter("row_data").getClass());
	    	JSONObject json;
	    	String driverEmail=null;
			try {
				json = new JSONObject(requestParam);
				driverEmail =json.getJSONObject("row_data").getString("customer_email");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	
	    	
	    			//(String) request.getAttribute("customer_email");
			//System.out.println("the driverEmail are "+ driverEmail);
			
			  Profile profile = (Profile) request.getSession().getAttribute("profile");
			  System.out.println("the profile name is :"+profile.getEmail());
			 
			  RouteManager routeManager = new RouteManager();
				  routeManager.updatePoolRide(driverEmail,profile.getEmail());
				  String routeTo="/jsp/Routes.jsp";
			  
			  ModelAndView mv = new ModelAndView();
			  mv.setViewName(routeTo);

	            return mv;
	
	}   
	    
	    
	    @RequestMapping(value = "/getUserRide")
		protected void getUserRide(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
		    	System.out.println("get USer ride");
		    	
		    			//(String) request.getAttribute("customer_email");
				//System.out.println("the driverEmail are "+ driverEmail);
				  Profile profile = (Profile) request.getSession().getAttribute("profile");
				  System.out.println("the profile name is :"+profile.getEmail());
				  RouteManager routeManager = new RouteManager();
				  Route route = new Route();
				  route.setCustomerEmail(profile.getEmail());
					 
					  String routeTo="/jsp/home.jsp";
				 String jsonResponse =  routeManager.getUserRoutes(route);;
						System.out.println("json response"+jsonResponse);
						 response.getWriter().write(jsonResponse);
					  
//				  ModelAndView mv = new ModelAndView();
//				  mv.setViewName(routeTo);
//
//		            return mv;
		
		}   
	    
	    
}
