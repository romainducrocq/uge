package shared;


import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

/**
 * This interface defines the structure of a vehicle.
 * A vehicle is defined by :
 * - a unique identifier
 * - its make
 * - its model
 * - its year
 * - its seating capacity
 * - its fuel type
 * - its transmission
 * - its price in Euros
 * - some notes given by the renters
 * - some comments given by the renters
 *
 */
public interface IVehicle extends Remote {
	
	/**
	 * Getter for the unique identifier of the vehicle
	 * @return the unique identifier of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public int getId() throws RemoteException;
	
	/**
	 * Setter of the unique identifier of the vehicle
	 * @param uniqueid the unique identifier of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setId(int uniqueid) throws RemoteException;
	
	/**
	 * Getter for the "make" attribute of the vehicle, nothing more than the brand of the car.
	 * @return a string corresponding to the make of the vehicle (for example, Renault, Peugeot...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getMake() throws RemoteException;

	/**
	 * Setter of the "make" attribute of the vehicle, the brand of the car.
	 * @param m a string corresponding to the "make" of the vehicle (for example, Renault, Peugeot...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setMake(String m) throws RemoteException;

	/**
	 * Getter for the "model" attribute of the vehicle.
	 * @return a string corresponding to the model of the vehicle (for example, Clio, 208...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getModel() throws RemoteException;

	/**
	 * Setter of the "model" attribute of the vehicle.
	 * @param m a string corresponding to the model of the vehicle (for example, Clio, 208...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setModel(String m) throws RemoteException;

	/**
	 * Getter for the year attribute (year of vehicle production).
	 * @return an integer representing the year of the production of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public int getYear() throws RemoteException;

	/**
	 * Setter of the year attribute (year of vehicle production).
	 * @param y an integer representing the year of the production of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setYear(int y) throws RemoteException;

	/**
	 * Getter for the seating capacity attribute (number of seats in the vehicle).
	 * @return the seating capacity attribute (number of seats in the vehicle).
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public int getSeatingCapacity() throws RemoteException;
	
	/**
	 * Setter of the seating capacity attribute (number of seats in the vehicle).
	 * @param c the seating capacity attribute (number of seats in the vehicle).
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setSeatingCapacity(int c) throws RemoteException;
	
	/**
	 * Getter for the fuel type of the vehicle (diesel, gasoline, electric, ...).
	 * @return the fuel type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getFuelType() throws RemoteException;
	
	/**
	 * Setter of the fuel type of the vehicle (diesel, gasoline, electric, ...).
	 * @param s the fuel type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setFuelType(String s) throws RemoteException;
	
	/**
	 * Getter for the transmission type of the vehicle (manual or automatic).
	 * @return the transmission type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getTransmission() throws RemoteException;
	
	/**
	 * Setter of the transmission type of the vehicle (manual or automatic).
	 * @param s the transmission type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setTransmission(String s) throws RemoteException;
	
	/**
	 * Getter for the price of the vehicle in Euros.
	 * @return the price of the vehicle in Euros
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public float getPriceInEuros() throws RemoteException;

	/**
	 * Setter of the price of the vehicle
	 * @param price the price in Euros
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setPriceInEuros(float price) throws RemoteException;
	
	/**
	 * Returns true if the vehicle is available for rent.
	 * @return true if the vehicle is available for rent, false otherwise.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public boolean isAvailableForRent() throws RemoteException;

	/**
	 * Returns true if the vehicle is available for sale.
	 * @return true if the vehicle is available for sale, false otherwise.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public boolean isAvailableForSale() throws RemoteException;

	/**
	 * Set the status of the vehicle to "rented".
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void rentCar() throws RemoteException;

	/**
	 * Called when a car is returned from rental. The renter can specify a note and a comment on the condition of return.
	 * @param note the note specified by the renter (from 0 to 10).
	 * @param condition a message to specify the condition of the vehicle when returning it.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void returnCar(int note, String condition) throws RemoteException;
	
	/**
	 * Returns the last condition message left by the previous renter.
	 * @return the last condition message left by the previous renter.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getLastCondition() throws RemoteException;
	
	/**
	 * Returns the average of all the notes left by previous renters.
	 * @return the average of all the notes left by previous renters.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public float getAverageNote() throws RemoteException;
	
	/**
	 * Returns the list of notes.
	 * @return the list of notes left by previous renters.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public List<Integer> getAllNotes() throws RemoteException;
	
	/**
	 * Returns a String to display a vehicle using its attributes.
	 * @return a String to display a vehicle.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getDisplayString() throws RemoteException;
	
	/**
	 * Getter for the image url of the vehicle.
	 * @return the url of the image.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public String getImgUrl() throws RemoteException;

	/**
	 * Setter for the image url of the vehicle.
	 * @param imgUrl the url of the image.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public void setImgUrl(String imgUrl) throws RemoteException;
	
}
