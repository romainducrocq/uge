package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shared.IEmployeeDB;
import shared.IVehicle;
import shared.IVehicleParkRentalManagement;

/**
 * Servlet implementation class ServletRentOrReturn
 */
@WebServlet("/rentorreturn")
public class ServletRentOrReturn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	IVehicleParkRentalManagement rentalManager;
	
    /**
     * Gets a rental manager object (remote object).
     * @see HttpServlet#HttpServlet()
     */
    public ServletRentOrReturn() {
    	super();
        
        try {
        	rentalManager = (IVehicleParkRentalManagement) Naming.lookup("//localhost:1099/rentalmanagement");
		} catch (MalformedURLException | RemoteException | NotBoundException e) {
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher;		
		dispatcher = request.getRequestDispatcher("/WEB-INF/employeeauthentification.jsp");
		dispatcher.forward(request, response);
		
	}

	/**
	 * If the user has checked "Rent a vehicle", calls rental.jsp by passing as argument the list of available vehicles for rental
	 * (call to the rental manager).
	 * If the user has checked "Return a vehicle", calls return.jsp. 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String rentorreturn = request.getParameter("rentorreturn");
		
		RequestDispatcher dispatcher;
		if (rentorreturn.equals("rent")) {
			List<IVehicle> vehiclesList = rentalManager.getAvailableVehiclesForRental();
			
			request.setAttribute("vehiclesList", vehiclesList);
			
			dispatcher = request.getRequestDispatcher("/WEB-INF/rental.jsp");
			dispatcher.forward(request, response);
		}
		else {
			dispatcher = request.getRequestDispatcher("/WEB-INF/return.jsp");
			dispatcher.forward(request, response);
		}
	}

}
