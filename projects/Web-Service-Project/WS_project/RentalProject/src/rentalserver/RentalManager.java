package rentalserver;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import employees.DBManager;
import shared.IEmployee;
import shared.IVehicle;
import shared.IVehicleParkRentalManagement;

/**
 * Implementation of the vehicle park rental management module.
 *
 */
public class RentalManager extends UnicastRemoteObject implements IVehicleParkRentalManagement {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * Emails will be sent by ifscars2020@gmail.com
	 */
	private String notificationSenderEmail = "ifscars2020@gmail.com";
	
	/**
	 * Emails will be sent by ifscars2020@gmail.com. The password is needed to set the "from" parameter.
	 */
	private String notificationSenderPwd = "ifscars?2";
	
	/**
	 * The mail session.
	 */
	private Session mailSession;
	
	/**
	 * The gmail host.
	 */
	private String host = "smtp.gmail.com";
	
	/**
	 * Hash map indexed by the vehicle id and containing the IVehicle object this id as unique identifier.
	 */
	HashMap<Integer,IVehicle> park;
		
	/**
	 * Hash map indexed by the vehicle id and containing for each vehicle, the list of employees renting
	 * or waiting for the rental.
	 * 
	 * If the array list is empty, then the car is not rented.
	 * The first element of the array list is the current renter.
	 * The next elements are the employees waiting for renting this car. 
	 */
	HashMap<Integer, ArrayList<IEmployee>> rentalWaitingList;
	
	/**
	 * The manager of the vehicles database connection.
	 */
	VehiclesDBManager mysqlManager;
	
	/**
	 * Initializes a new vehicle park rental module and load some vehicles.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public RentalManager() throws RemoteException {
		
		mysqlManager = new VehiclesDBManager();

		// Loads vehicles from database
		this.park = mysqlManager.loadVehicles();
		
		/* REMOVE THE COMMENT IF YOU DON'T WANT TO USE DATABASE */
/*		Vehicle v = new Vehicle(1,"Renault", "Clio", 2020, 5, "Diesel", "Manual", 24000);
		park.put(Integer.valueOf(v.getId()),v);
		v = new Vehicle(2, "Renault", "Clio", 2019, 5, "Gas", "Manual", 20000);
		park.put(Integer.valueOf(v.getId()),v);
		v = new Vehicle(3,"Peugeot", "208", 2020, 5, "Gas", "Automatic", 23000);
		park.put(Integer.valueOf(v.getId()),v);
		v = new Vehicle(4, "Peugeot", "308", 2019, 5, "Gas", "Manual", 21000);
		park.put(Integer.valueOf(v.getId()),v);
		v = new Vehicle(5, "Renault", "Twingo", 2019, 4, "Gas", "Manual", 16000);
		park.put(Integer.valueOf(v.getId()),v);
*/
		
		initializeWaitingList();
		
		initializeEmailProtocol();

	}
	
	/**
	 * Initializes the waiting lists for each vehicle (empty). rentalWaitingList is indexed by the id of the vehicle
	 * and contains an ArrayList of IEmployee objects.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	void initializeWaitingList() throws RemoteException {
	
		rentalWaitingList = new HashMap<Integer, ArrayList<IEmployee>>();
		
		Collection<IVehicle> vehicles = park.values();
		Iterator<IVehicle> it = vehicles.iterator();
		while (it.hasNext()) {
			IVehicle v = it.next();
			
			rentalWaitingList.put(Integer.valueOf(v.getId()), new ArrayList<IEmployee>());
		}
	
	}
	
	/**
	 * 
	 * @param vehicleid the vehicle unique identifier. 
	 * @return the vehicle with unique vehicleid.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public IVehicle getVehicleById(int vehicleid) throws RemoteException{
		return this.park.get(Integer.valueOf(vehicleid));
	}

	/**
	 * Returns the list of vehicles available for rental (all the cars in the park are "available" for rental.
	 * If a vehicle is already rent, the renter will be added to a waiting list for this car.
	 * @return the list of vehicles available for rental.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public List<IVehicle> getAvailableVehiclesForRental() throws RemoteException {
		// Can not return directly the values of the HashMap because it is not serializable... :(
		List<IVehicle> listVehiclesForRental = new ArrayList<IVehicle>();
		
		Collection<IVehicle> vehicles = park.values();
		Iterator<IVehicle> it = vehicles.iterator();
		while (it.hasNext()) {
			IVehicle v = it.next();
			listVehiclesForRental.add(v);   // all cars in the park are available ! Waiting list if already rented
		}
		return listVehiclesForRental;
	}
		

	/**
	 * Returns the list of vehicles available for sale.
	 * @return the list of vehicles available for sale.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public List<IVehicle> getAvailableVehiclesForSale() throws RemoteException {
		List<IVehicle> listVehiclesForSale = new ArrayList<IVehicle>();
		Collection<IVehicle> vehicles = park.values();
		Iterator<IVehicle> it = vehicles.iterator();
		while (it.hasNext()) {
			IVehicle v = it.next();
			if (v.isAvailableForSale()) {
				listVehiclesForSale.add(v);
			}
		}
		return listVehiclesForSale;
	}

	/**
	 * Tries to rent the vehicle for the specified employee. Notifies the employee to inform him/her of the rental result.
	 * Returns 	0 if the vehicle can not be rent (for example, it has been sold during the rental process),
	 * 			1 if the vehicle can be rent,
	 * 			2 if the vehicle is already rent and the employee will be put on a waiting list
	 * @param vehicleId the vehicle unique identifier
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public int rentVehicle(IEmployee employee, int vehicleId) throws RemoteException {
		IVehicle v = park.get(Integer.valueOf(vehicleId));
		String msg = "";
		// If no vehicle found with this id, return 
		if (v == null) {
			try {
				msg = "Hi "+employee.getIdentifier()+"!\n\n We are SORRY but this vehicle can not be rented !";
				notifyEmployee(employee, v, "IMPORTANT : Rental message", msg);
			} catch (MessagingException e) {
				
				System.out.println("ERROR IN EMPLOYEE NOTIFICATION ***");
				System.out.println("Unable to send an email with following message :");
				System.out.println(msg);
				
				e.printStackTrace();
			}
			return 0;
		}
		else {
			
			List<IEmployee> rentersList = rentalWaitingList.get(Integer.valueOf(vehicleId));
			
			// Adds the employee to the rental list.
			rentersList.add(employee);
			
			// If there is only one employee in the rental list, then the car is rented by this employee.
			if (rentersList.size() == 1) {
				v.rentCar();
				try {
					msg = "Hi "+employee.getIdentifier()+"!\n\n You have rented this vehicle of id "+vehicleId+" ! Enjoy its use !!!";
					notifyEmployee(employee, v, "IMPORTANT : Rental message", msg);
				} catch (MessagingException e) {
					
					System.out.println("ERROR IN EMPLOYEE NOTIFICATION ***");
					System.out.println("Unable to send an email with following message :");
					System.out.println(msg);
					
					e.printStackTrace();
				}
				return 1;
			}
			// Else the car is already rented, the employee has to wait
			else {
				try {
					msg = "Hi "+employee.getIdentifier()+"!\n\n Unfortunately, the car num "+vehicleId+" is already rented.\n You have been added to the waiting list and will be notified as soon as the vehicle is available.";
					notifyEmployee(employee, v, "IMPORTANT : Rental message", msg);
				} catch (MessagingException e) {
					
					System.out.println("ERROR IN EMPLOYEE NOTIFICATION ***");
					System.out.println("Unable to send an email with following message :");
					System.out.println(msg);
					
					e.printStackTrace();
				}					
				return 2;
			}
		}
	}

	/**
	 * Initialize the email process.
	 */
	public void initializeEmailProtocol() {

		String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
		boolean sessionDebug = true;


		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol.", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.", "true");
		props.put("mail.smtp.port", "465");//port number 465 for Secure (SSL) and we can alsonuse port no 587 for Secure (TLS)
		props.put("mail.smtp.socketFactory.fallback", "false");
		props.put("mail.smtp.socketFactory.class", SSL_FACTORY);


		mailSession = Session.getDefaultInstance(props, null);	
		
	}
	
	/**
	 * Notify the employee by sending him a message.
	 * @param empl the employee to notify
	 * @param veh the vehicle the employee is trying to rent
	 * @param subject the subject of the notification
	 * @param message the message of the notification
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 * @throws MessagingException 
	 * @throws AddressException 
	 */
	public void notifyEmployee(IEmployee empl, IVehicle veh, String subject, String message) throws RemoteException, AddressException, MessagingException {
		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress(this.notificationSenderEmail));
		InternetAddress[] address = {new InternetAddress(empl.getEmail())};
		msg.setRecipients(Message.RecipientType.TO, address);
		msg.setSubject(subject);
		msg.setContent(message, "text/html");
		
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, this.notificationSenderEmail, this.notificationSenderPwd);
		
		System.out.println(message+"\n");

		try {
		    transport.sendMessage(msg, msg.getAllRecipients());
		   }

		catch (Exception err) {
			 System.out.println("ERROR in sending email process !!!!!!!    :(");
        }
        transport.close();
	}
	
	/**
	 * Called to return a car : add the note and condition of return to the vehicle and free it for next rental.
	 * If the waiting list of this car is not empty, rents the car to the first waiter and notifies him/her. 
	 * @param vehicleid the vehicle unique identifier
	 * @param note the note given by the employee returning the vehicle.
	 * @param conditionOfReturn a comment given by the employee to specify the condition of return of the vehicle.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void returnCar(int vehicleid, int note, String conditionOfReturn) throws RemoteException {
		List<IEmployee> rentersList = rentalWaitingList.get(Integer.valueOf(vehicleid));
		
		// Removes the current employee renter from the rental list ; it corresponds to the first element of the list	
		rentersList.remove(0);
		
		IVehicle veh = park.get(Integer.valueOf(vehicleid));
		
		veh.returnCar(note, conditionOfReturn);
		
		mysqlManager.updateVehicleAfterReturnRental(veh.getId(), veh.getAllNotes(), veh.getLastCondition(), true);
		
		if (! rentersList.isEmpty()) {
			// Notify the first employee waiting for the car
			IEmployee empl = rentersList.get(0);
			
			veh.rentCar();
			
			String msg = "";
			try {
				msg = "Hello "+empl.getIdentifier()+". Car number "+vehicleid+" has been returned. You are now rented it. Enjoy !!!!";
				notifyEmployee(empl, veh, "IMPORTANT : Rental message", msg);
			} catch (MessagingException e) {
				
				System.out.println("ERROR IN EMPLOYEE NOTIFICATION ***");
				System.out.println("Unable to send an email with following message :");
				System.out.println(msg);
				
				e.printStackTrace();
			}
		}
	}

	/**
	 * Removes vehicle from the vehicles park because it is sold.
	 * @param vehId the vehicle identifier.
	 * @return 	true if the vehicle was successfully removed (thus sold)
	 * 			false if there is a problem (vehicle not already rented or not anymore in the park...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public boolean sellVehicle(int vehId) throws RemoteException {
		if (rentalWaitingList.remove(vehId) != null && park.remove(vehId) != null)
			return true;
		else return false;
	}
	
}