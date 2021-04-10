package rentalserver;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import shared.IVehicle;

/**
 * The vehicle implementation class.
 *
 */
public class Vehicle extends UnicastRemoteObject implements IVehicle { 
	
	/**
	 * The serial version UID.
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * The unique identifier of the vehicle.
	 */
	int uniqueId;
	
	/**
	 * The make of the vehicle (for example, Renault, Peugeot...)
	 */
	String make;
	
	/**
	 * The model of the vehicle (for example, Clio, 208...)
	 */
	String model;
	
	/**
	 * The year of production of the vehicle
	 */
	int year;
	
	/**
	 * The number of seats in the vehicle
	 */
	int seatingCapacity;
	
	/**
	 * The fuel type of the vehicle (diesel, gasoline, electric...)
	 */
	String fuelType;
	
	/**
	 * The transmission type of the vehicle (manual or automatic)
	 */
	String transmission;
	
	/**
	 * The price of the vehicle
	 */
	float priceInEuros;
	
	/**
	 * A boolean indicating availability of vehicle for rent
	 */
	boolean availableForRent;
	
	/**
	 * A boolean indicating availability of vehicle for sale
	 */
	boolean availableForSale;
	
	/**
	 * A list of integers between 0 and 10 indicating the satisfaction level of renters.
	 */
	List<Integer> notes;
	
	/**
	 * A list of Strings corresponding to the comments left by renters after returning a vehicle.
	 */
	List<String> conditions;
	
	/**
	 * An URL of the car image.
	 */
	String imgUrl;
	

	/**
	 * Creates a default car (Renault, Clio of 2020, 5 seats, diesel, manual transmission, 18000 EUR).
	 * @param id the unique identifier of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public Vehicle(int id) throws RemoteException {
		this.uniqueId = id;
		this.make = "Renault";
		this.model = "Clio";
		this.year = 2020;
		this.seatingCapacity = 5;
		this.fuelType = "Diesel";
		this.transmission = "Manual";
		this.priceInEuros = 18000;
		
		this.availableForRent = true;
		this.availableForSale = false;
		
		notes = new ArrayList<Integer>();
		conditions = new ArrayList<String>();
		
		this.imgUrl = "https://images.unsplash.com/photo-1571127236794-81c0bbfe1ce3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80";
		
	}
	
	/**
	 * Creates a car with all the specified parameters.
	 * @param id the unique identifier of the vehicle
	 * @param make the make of the vehicle
	 * @param model the model of the vehicle
	 * @param year the year of production of the vehicle
	 * @param seatingCapacity the number of seats in the vehicle
	 * @param fuelType the fuel type of the vehicle
	 * @param transmission the transmission type of the vehicle
	 * @param priceInEuros the price in Euros for this vehicle
	 * @param imgUrl the url of the image
	 * @param allNotes the list of previous notes
	 * @param lastMessage the last message
	 * @param availableForSale is available for sale
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public Vehicle(int id, String make, String model, int year, int seatingCapacity, String fuelType, String transmission, float priceInEuros, String imgUrl, String allNotes, String lastMessage, boolean availableForSale) throws RemoteException {
		this.uniqueId = id;
		this.make = make;
		this.model = model;
		this.year = year;
		this.seatingCapacity = seatingCapacity;
		this.fuelType = fuelType;
		this.transmission = transmission;
		this.priceInEuros = priceInEuros;
		
		this.imgUrl = ((imgUrl.length() > 0) ? imgUrl : "https://images.unsplash.com/photo-1571127236794-81c0bbfe1ce3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80");
		
		this.availableForRent = !availableForSale;
		this.availableForSale = availableForSale;
		
		this.notes = new ArrayList<Integer>();
    	if(allNotes.length() > 0) {
	    	for(int i = 0; i < allNotes.length(); i++) {
	    		this.notes.add(Character.getNumericValue(allNotes.charAt(i)));
	    	}	
    	}
		
		this.conditions = new ArrayList<String>();
    	if(lastMessage.length() > 0) {
    		this.conditions.add(lastMessage);
    	}
	}
	
	/**
	 * Getter for the unique identifier of the vehicle
	 * @return the unique identifier of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public int getId() throws RemoteException {
		return this.uniqueId;
	}

	/**
	 * Setter of the unique identifier of the vehicle
	 * @param uniqueid the unique identifier of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setId(int uniqueid) throws RemoteException {
		this.uniqueId = uniqueid;
	}

	/**
	 * Getter for the "make" attribute of the vehicle, nothing more than the brand of the car.
	 * @return a string corresponding to the make of the vehicle (for example, Renault, Peugeot...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getMake() throws RemoteException {
		return this.make;
	}

	/**
	 * Setter of the "make" attribute of the vehicle, the brand of the car.
	 * @param m a string corresponding to the "make" of the vehicle (for example, Renault, Peugeot...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setMake(String m) throws RemoteException {
		this.make = m;
	}

	/**
	 * Getter for the "model" attribute of the vehicle.
	 * @return a string corresponding to the model of the vehicle (for example, Clio, 208...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getModel() throws RemoteException {
		return this.model;
	}

	/**
	 * Setter of the "model" attribute of the vehicle.
	 * @param m a string corresponding to the model of the vehicle (for example, Clio, 208...)
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setModel(String m) throws RemoteException {
		this.model = m;
	}

	/**
	 * Getter for the year attribute (year of vehicle production).
	 * @return an integer representing the year of the production of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public int getYear() throws RemoteException {
		return this.year;
	}

	/**
	 * Setter of the year attribute (year of vehicle production).
	 * @param y an integer representing the year of the production of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setYear(int y) throws RemoteException {
		this.year = y;
	}

	/**
	 * Getter for the seating capacity attribute (number of seats in the vehicle).
	 * @return the seating capacity attribute (number of seats in the vehicle).
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public int getSeatingCapacity() throws RemoteException {
		return this.seatingCapacity;
	}

	/**
	 * Setter of the seating capacity attribute (number of seats in the vehicle).
	 * @param c the seating capacity attribute (number of seats in the vehicle).
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setSeatingCapacity(int c) throws RemoteException {
		this.seatingCapacity = c;
	}

	/**
	 * Getter for the fuel type of the vehicle (diesel, gasoline, electric, ...).
	 * @return the fuel type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getFuelType() throws RemoteException {
		return this.fuelType;
	}

	/**
	 * Setter of the fuel type of the vehicle (diesel, gasoline, electric, ...).
	 * @param s the fuel type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setFuelType(String s) throws RemoteException {
		this.fuelType = s;
	}

	/**
	 * Getter for the transmission type of the vehicle (manual or automatic).
	 * @return the transmission type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getTransmission() throws RemoteException {
		return this.transmission;
	}

	/**
	 * Setter of the transmission type of the vehicle (manual or automatic).
	 * @param s the transmission type of the vehicle
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setTransmission(String s) throws RemoteException {
		this.transmission = s;
	}

	/**
	 * Getter for the price of the vehicle in Euros.
	 * @return the price of the vehicle in Euros
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public float getPriceInEuros() throws RemoteException {
		return this.priceInEuros;
	}

	/**
	 * Setter of the price of the vehicle
	 * @param price the price in Euros
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setPriceInEuros(float price) throws RemoteException {
		this.priceInEuros = price;
	}
	
	/**
	 * Returns true if the vehicle is available for rent (it is available).
	 * @return true if the vehicle is available for rent, false otherwise.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public boolean isAvailableForRent() throws RemoteException {
		return this.availableForRent;
	}

	/**
	 * Returns true if the vehicle is available for sale (it has been rented at least once).
	 * @return true if the vehicle is available for sale, false otherwise.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public boolean isAvailableForSale() throws RemoteException {
		return this.availableForSale;
	}

	/**
	 * Set the status of the vehicle to "rented".
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void rentCar() throws RemoteException {
		this.availableForRent = false;
		this.availableForSale = true;
	}
	
	/**
	 * Called when a car is returned from rental. The renter can specify a note and a comment on the condition of return.
	 * @param note the note specified by the renter (from 0 to 10).
	 * @param condition a message to specify the condition of the vehicle when returning it.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void returnCar(int note, String condition) throws RemoteException {
		this.availableForRent = true;
		
		notes.add(Integer.valueOf(note));
		conditions.add(condition);
	}

	/**
	 * Returns the last condition message left by the previous renter.
	 * @return the last condition message left by the previous renter.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getLastCondition() throws RemoteException {
		if (conditions.size() > 0)
			return conditions.get(this.conditions.size() - 1);
		return "";
	}

	/**
	 * Returns the average of all the notes left by previous renters.
	 * @return the average of all the notes left by previous renters.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public float getAverageNote() throws RemoteException {
		
		if (notes.size() == 0)
			return 0;
		
		int sum = 0;
		
		Iterator<Integer> it = notes.iterator();
		while (it.hasNext()) {
			sum += (int) it.next();
		}
				
		return (float)sum/notes.size();
	}
	
	/**
	 * Returns a String to display a vehicle using its attributes.
	 * @return a String to display a vehicle.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getDisplayString() throws RemoteException {
		String displayString = "Vehicle ";
		displayString = displayString+" Make : "+getMake()+" Model : "+getModel();
		displayString = displayString+" Year : "+getYear()+" Seating places : "+getSeatingCapacity();
		displayString = displayString+" Fuel type :"+getFuelType()+" Transmission : "+getTransmission();
		displayString = displayString+" Price : "+getPriceInEuros();
		displayString = displayString+" Average note : "+getAverageNote();
		displayString = displayString+" Last comment : "+getLastCondition();
		
		return displayString;
	}
	
	/**
	 * Getter for the image url of the vehicle.
	 * @return the url of the image.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public String getImgUrl() throws RemoteException {
		return this.imgUrl;
	}

	/**
	 * Setter for the image url of the vehicle.
	 * @param imgUrl the url of the image.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	@Override
	public void setImgUrl(String imgUrl) throws RemoteException {
		this.imgUrl = imgUrl;
	}
	
	/**
	 * Returns the list of notes.
	 * @return the list of notes left by previous renters.
	 * @throws RemoteException may occur as this object will be used in remote method call.
	 */
	public List<Integer> getAllNotes() throws RemoteException {
		return this.notes;
	}

}