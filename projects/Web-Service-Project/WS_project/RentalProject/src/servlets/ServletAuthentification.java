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
 * Servlet implementation class ServletAuthentification.
 * Called to check that the given username and password correspond to a real employee.
 */
@WebServlet("/authenticate")
public class ServletAuthentification extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	IEmployeeDB employeeDB;
	IVehicleParkRentalManagement rentalManager;
	
    /**
     * Get the rental manager object and the employee database object (remote objects).
     * @see HttpServlet#HttpServlet()
     */
    public ServletAuthentification() {
        super();
        
        try {
        	rentalManager = (IVehicleParkRentalManagement) Naming.lookup("//localhost:1099/rentalmanagement");
			employeeDB = (IEmployeeDB) Naming.lookup("//localhost:2000/employeeDB");
		} catch (MalformedURLException | RemoteException | NotBoundException e) {
			e.printStackTrace();
		}
    }

	/**
	 * Displays employeeauthentification.jsp.
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;		
		dispatcher = request.getRequestDispatcher("/WEB-INF/employeeauthentification.jsp");
		dispatcher.forward(request, response);
		
	}

	/**
	 * Called by employeeauthentification.jsp when the user validates its username and password.
	 * If the employee is well authenticated, then displays rentorreturn.jsp.
	 * Otherwise, displays an error page authentificationerror.html.
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("password");
		
		RequestDispatcher dispatcher;
		if (employeeDB.isEmployee(id,pwd)) {

			request.setAttribute("employeeid", id);
			
			dispatcher = request.getRequestDispatcher("/WEB-INF/rentorreturn.jsp");
			dispatcher.forward(request, response);
		}
		else {
			dispatcher = request.getRequestDispatcher("/WEB-INF/authentificationerror.html");
			dispatcher.forward(request, response);
		}
		
	}

}
