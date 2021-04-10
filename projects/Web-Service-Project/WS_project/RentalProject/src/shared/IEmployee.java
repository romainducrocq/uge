package shared;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * This interface defines the structure of an employee.
 * An employee is represented by an identifier (name) and a password.
 *
 */
public interface IEmployee extends Remote {
	
	/**
	 * Getter method for the first name attribute
	 * @return a String corresponding to the first name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getFirstName() throws RemoteException;
	
	/**
	 * Setter method for the first name attribute
	 * @param firstName a String corresponding to the first name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setFirstName(String firstName) throws RemoteException;
	
	/**
	 * Getter method for the last name attribute
	 * @return a String corresponding to the last name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getLastName() throws RemoteException;
	
	/**
	 * Setter method for the last name attribute
	 * @param lastName a String corresponding to the last name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setLastName(String lastName) throws RemoteException;

	
	/**
	 * Getter method for the identifier attribute
	 * @return a String corresponding to the identifier of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getIdentifier() throws RemoteException;
	
	/**
	 * Setter method for the identifier attribute
	 * @param id a String corresponding to the identifier of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setIdentifier(String id) throws RemoteException;
	
	/**
	 * Getter method for the email address attribute
	 * @return a String corresponding to the email address of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getEmail() throws RemoteException;
	
	/**
	 * Setter method for the email address attribute
	 * @param m a String corresponding to the email address of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setEmail(String m) throws RemoteException;
	
	/**
	 * Setter method for the password attribute
	 * @param pwd the password of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setPassword(String pwd) throws RemoteException;
	
	/**
	 * Checks if the password is the right one for this employee.
	 * @param pwd the tested password
	 * @return true if the password is correct, false otherwise.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public boolean isPasswordRight(String pwd) throws RemoteException;
	
	
}