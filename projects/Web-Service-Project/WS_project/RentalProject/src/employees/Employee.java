package employees;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

import shared.IEmployee;

/**
 * The implementation of an employee. He/she is described by his/her first name, last name, identifier, password and email.
 *
 */
public class Employee extends UnicastRemoteObject implements IEmployee {
		
	private static final long serialVersionUID = 1L;
	
	/**
	 * The first name of the employee
	 */
	String firstName;
	
	/**
	 * The last name of the employee
	 */
	String lastName;
	
	
	/**
	 * The identifier (unique) of the employee
	 */
	String identifier;
	
	/**
	 * The password of the employee
	 */
	String password;
	
	/**
	 * The mail of the employee
	 */
	String email;
	
	/**
	 * Empty constructor
	 * @throws RemoteException
	 */
	public Employee() throws RemoteException {
		super();
	}

	/**
	 * Creates an employee given his/her identifier (default password, default mail).
	 * @param id the unique identifier of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	
	public Employee(String id) throws RemoteException {
		this.identifier = id;
		this.password = "0000";
		this.email = "ngrumbach@gmail.com";
	}
		
	
	/**
	 * Creates an employee given his/her first name, last name, identifier, password and email.
	 * @param firstName
	 * @param lastName
	 * @param userid
	 * @param pwd
	 * @param email
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public Employee(String firstName, String lastName, String userid, String pwd, String email) throws RemoteException {
		this.firstName = firstName;
		this.lastName = lastName;
		this.identifier = userid;
		this.password = pwd;
		this.email = email;
	}
	
	/**
	 * Getter method for the first name attribute
	 * @return a String corresponding to the first name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override	
	public String getFirstName() throws RemoteException {
		return this.firstName;
	}
	
	/**
	 * Setter method for the first name attribute
	 * @param firstName a String corresponding to the first name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override	
	public void setFirstName(String firstName) throws RemoteException {
		this.firstName = firstName;
	}
	
	/**
	 * Getter method for the last name attribute
	 * @return a String corresponding to the last name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override	
	public String getLastName() throws RemoteException {
		return this.lastName;
	}
	
	/**
	 * Setter method for the last name attribute
	 * @param lastName a String corresponding to the last name of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override	
	public void setLastName(String lastName) throws RemoteException {
		this.lastName = lastName;
	}


	/**
	 * Getter method for the identifier attribute.
	 * @return a String corresponding to the identifier of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getIdentifier() throws RemoteException {
		return this.identifier;
	}

	/**
	 * Setter method for the identifier attribute
	 * @param id a String corresponding to the identifier of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setIdentifier(String id) throws RemoteException {
		this.identifier = id;
	}
	
	/**
	 * Getter method for the email attribute.
	 * @return a String corresponding to the email of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getEmail() throws RemoteException {
		return this.email;
	}

	/**
	 * Setter method for the email attribute
	 * @param m a String corresponding to the email of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setEmail(String m) throws RemoteException {
		this.email = m;
	}

	@Override
	/**
	 * Setter method for the password attribute
	 * @param pwd a String corresponding to the password of the employee
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setPassword(String pwd) throws RemoteException {
		this.password = pwd;
	}

	@Override
	/**
	 * Returns true if the given password is equal to the employee password.
	 * @param pwd the password to test
	 * @return a boolean indicating if the password parameter corresponds to the password of this employee.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public boolean isPasswordRight(String pwd) throws RemoteException {
		return pwd.equals(this.password);
	}

}