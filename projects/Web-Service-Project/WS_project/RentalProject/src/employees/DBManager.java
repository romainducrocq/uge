package employees;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import shared.IEmployee;

/**
 * This class is in charge of creating the connection with the MySQL employees database.
 * Is also in charge of communicating with this DB.
 *
 */
public class DBManager {
	
	/**
	 * The connection to the employees database.
	 */
	Connection conn;
	
	/**
	 * The constructor initializes the connection to the employees database.
	 */
	public DBManager() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeDB", "root", "1Rootpwd!");
			
		
		} catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Loads the employees from the database and returns a Hasmap indexed by the employee username and the Employee created object.
	 * @return a Hasmap indexed by the employee username and the Employee created object.
	 * @throws RemoteException may occur if the employee can not be created.
	 */
	public HashMap<String, IEmployee> loadEmployees() throws RemoteException {
		HashMap<String, IEmployee> employeeDB = new HashMap<String, IEmployee>();
		
		String query = "select * from employee";
	    PreparedStatement st;
		try {
			st = conn.prepareStatement(query);
		
		    ResultSet rs = st.executeQuery();
		    while (rs.next()) {
		    	String firstname = rs.getString("first_name");
		    	String lastname = rs.getString("last_name");
		    	String usrname = rs.getString("username");
		    	String pwd = rs.getString("password");		    	    
		    	String email = rs.getString("email");	
		    	
		    	IEmployee emp = new Employee(firstname, lastname, usrname, pwd, email);
		    	
		    	employeeDB.put(usrname, emp);
		    }
		    
		    return employeeDB;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}

}
