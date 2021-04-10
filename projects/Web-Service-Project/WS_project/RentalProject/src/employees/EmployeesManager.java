package employees;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;

import shared.IEmployee;
import shared.IEmployeeDB;

/**
 * Implementation of the employee database.
 *
 */
public class EmployeesManager extends UnicastRemoteObject implements IEmployeeDB {

	/**
	 * Serial version UUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * Hashmap containing the employees indexed by their identifier.
	 */
	HashMap<String, IEmployee> employeeDB;
	
	/**
	 * The manager of the connection to the database of employees.
	 */
	DBManager mysqlManager;
	
	/**
	 * Default constructor.
	 * Creates some employees and adds them to the hashmap.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public EmployeesManager() throws RemoteException {
		
		mysqlManager = new DBManager();

		// Loads employees from database
		this.employeeDB = mysqlManager.loadEmployees();
		
		/* REMOVE COMMENT IF YOU DON'T WANT TO USE DATABASE.*/
/*		Employee nat = new Employee("Natacha","GRUMBACH","ngrumbach","password","ngrumbach@gmail.com");
		Employee romain = new Employee("Romain","DUCROCQ","rducrocq","password","ngrumbach@gmail.com");
		Employee alex = new Employee("Alexandre","THEROND","atherond","password","ngrumbach@gmail.com");
		
		employeeDB.put(nat.getIdentifier(), nat);
		employeeDB.put(romain.getIdentifier(), romain);
		employeeDB.put(alex.getIdentifier(), alex);
*/			
	}
	
	/**
	 * Checks if an employee with this identifier and a password is part of the company.
	 * @param userName the identifier to check
	 * @param pwd the password to check
	 * @return true if there exists an employee with this identifier and this password in the employee database.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public boolean isEmployee(String userName, String pwd) throws RemoteException {
		
		IEmployee empl = employeeDB.get(userName);
		
		if  (empl != null) {
			return empl.isPasswordRight(pwd);
		}
		else return false;
	}


	/**
	 * Returns the IEmployee implementation object corresponding to this identifier.
	 * @param name the identifier of the employee looked for.
	 * @return an IEmployee implementation object with this identifier
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public IEmployee getEmployee(String name) throws RemoteException {
		return employeeDB.get(name);
	}
	


}