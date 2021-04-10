package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Iterator;
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
 * Servlet implementation class ServletRental.
 * Called to rent a vehicle.
 */
@WebServlet("/rental")
public class ServletRental extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	IVehicleParkRentalManagement rentalManager;
	IEmployeeDB employeeDB;
	
    /**
     * Get the rental manager object and the employee database object (remote objects).
     * @see HttpServlet#HttpServlet()
     */
    public ServletRental() {
    	try {
    		rentalManager = (IVehicleParkRentalManagement) Naming.lookup("//localhost:1099/rentalmanagement");
    		employeeDB = (IEmployeeDB) Naming.lookup("//localhost:2000/employeeDB");
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
	 * Called when the user wants to rent a vehicle. Calls the rental manager.
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// CALL RENT METHOD OF RentalManager
		
		String userid = request.getParameter("employeeid");
		String vehicleid = request.getParameter("vehicleid");
		
		
		int resultOfRental = rentalManager.rentVehicle(employeeDB.getEmployee(userid), Integer.valueOf(vehicleid));
		
		RequestDispatcher dispatcher;
		if (resultOfRental == 0) { // error
			dispatcher = request.getRequestDispatcher("/WEB-INF/rentalerror.html");
			dispatcher.forward(request, response);
		}
		else if (resultOfRental == 1) { // rental ok
			dispatcher = request.getRequestDispatcher("/WEB-INF/rentalvalidated.html");
			dispatcher.forward(request, response);
		}
		else { // rental waiting
			dispatcher = request.getRequestDispatcher("/WEB-INF/rentalwaiting.html");
			dispatcher.forward(request, response);
		}
		
	}

}
