package shared;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

/**
 * This interface defines the methods necessary to manage the vehicles rentals.
 *
 */
public interface IVehicleParkRentalManagement extends Remote {

	/**
	 * 
	 * @param vehicleid the vehicle unique identifier. 
	 * @return the vehicle with unique vehicleid.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public IVehicle getVehicleById(int vehicleid) throws RemoteException;
	
	/**
	 * Returns the list of vehicles available for rental.
	 * @return the list of vehicles available for rental.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public List<IVehicle> getAvailableVehiclesForRental() throws RemoteException;
	
	/**
	 * Returns the list of vehicles available for sale.
	 * @return the list of vehicles available for sale.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public List<IVehicle> getAvailableVehiclesForSale() throws RemoteException;
	
	/**
	 * Returns 	0 if the vehicle can not be rent (for example, it has been sold during the rental process),
	 * 			1 if the vehicle can be rent,
	 * 			2 if the vehicle is already rent and the employee will be put on a waiting list
	 * @param employee the employee who want to rent the vehicle.
	 * @param vehicleid the vehicle unique identifier.
	 * @return 0 if the vehicle can not be rent, 1 if the vehicle can be rent or 2 if the vehicle is already rent and the employee will be put on a waiting list
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public int rentVehicle(IEmployee employee, int vehicleid) throws RemoteException;
	
	/**
	 * Called to return a car : add the note and condition of return to the vehicle and free it for next rental. 
	 * @param vehicleid the vehicle unique identifier
	 * @param note the note given by the employee returning the vehicle.
	 * @param conditionOfReturn a comment given by the employee to specify the condition of return of the vehicle.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void returnCar(int vehicleid, int note, String conditionOfReturn) throws RemoteException;
	
	/**
	 * Removes vehicle from the vehicles park because it is sold.
	 * @param vehId the vehicle identifier.
	 * @return 	true if the vehicle was successfully removed (thus sold)
	 * 			false if there is a problem (vehicle not already rented or not anymore in the park...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public boolean sellVehicle(int vehId) throws RemoteException;
	
	/**
	 * Adds a new vehicle in the park given its attributes
	 * @param make the make of the vehicle
	 * @param model the model of the vehicle
	 * @param year the year of production of the vehicle
	 * @param seatingCapacity the number of seats in the vehicle
	 * @param fuelType the fuel type of the vehicle
	 * @param transmission the transmission type of the vehicle
	 * @param priceInEuros the price in Euros to sell this vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
//	public void addVehicle(String make, String model, int year, int seatingCapacity, String fuelType, String transmission, float priceInEuros) throws RemoteException;

}