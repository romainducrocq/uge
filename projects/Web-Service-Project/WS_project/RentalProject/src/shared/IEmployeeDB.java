package shared;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * This interface defines the methods to "ask" the employee database.
 *
 */
public interface IEmployeeDB extends Remote {

	
	/**
	 * Returns the IEmployee implementation object corresponding to this identifier.
	 * @param id the identifier of the employee looked for.
	 * @return an IEmployee implementation object with this identifier
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public IEmployee getEmployee(String id) throws RemoteException;

	/**
	 * Checks if an employee with this identifier and a password is part of the company.
	 * @param userName the identifier to check
	 * @param pwd the password to check
	 * @return true if there exists an employee with this identifier and this password in the employee database.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	boolean isEmployee(String userName, String pwd) throws RemoteException;
	
}