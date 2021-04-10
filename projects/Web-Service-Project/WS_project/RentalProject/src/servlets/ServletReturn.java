package servlets;

import java.io.IOException;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shared.IEmployeeDB;
import shared.IVehicleParkRentalManagement;

/**
 * Servlet implementation class ServletReturn.
 * Called to return a vehicle.
 */
@WebServlet("/return")
public class ServletReturn extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	IVehicleParkRentalManagement rentalManager;
	
    /**
     * Gets the rental manager object (remote object).
     * @see HttpServlet#HttpServlet()
     */
    public ServletReturn() {
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
	 * Returns a vehicle given its identifier, a note and a condition.
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// CALL RENT METHOD OF RentalManager
		
		String vehicleid = request.getParameter("vehicleid");
		String note = request.getParameter("note");
		String condition = request.getParameter("condition");
	
		
		rentalManager.returnCar(Integer.valueOf(vehicleid), Integer.valueOf(note), condition);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/seeyou.html");
		dispatcher.forward(request, response);
	}

}
