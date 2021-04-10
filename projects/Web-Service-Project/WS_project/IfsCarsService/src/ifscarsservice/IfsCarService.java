package ifscarsservice;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.xml.rpc.ServiceException;

import bank.BankManagerServiceLocator;

/**
 * 
 * The class who handles the implementation of IfsCarService Web Service.
 *
 */
public class IfsCarService {
	
	/**
	 * The connection to the MySQL database to get the vehicles.
	 */
	private Connection conn = null;
	
	/**
	 * The set of ids of vehicles added to the shopping cart.
	 */
    Set<Integer> cart = new HashSet<Integer>(); 
	
    /**
     * Empty constructor
     */
	public IfsCarService() {
	}
	
	/**
	 * Initializes the connection to the mysql database.
	 * @return true if the connection is successful
	 */
	private boolean initConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehiclesDB", "root", "1Rootpwd!");
			return true;
		} catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//VEHICLES
	
	/**
	 * Returns the list of identifiers of the vehicles available for sale or of all the vehicles depending on the given parameter.
	 * @param availableForSale false: all vehicles / true: only available for sale vehicles
	 * @return the Id list of all vehicles or of available for sale vehicles
	 */
	public int[] getVehicleIds(boolean availableForSale) {
		
			if(this.conn == null) {
				if(!this.initConnection()) {
					return null;
				}
			}
		
			String query = "select id"+ (availableForSale ? ", available_for_sale" : "") + " from vehicle;";
			
		    PreparedStatement st;
			try {
				st = this.conn.prepareStatement(query);
			
			    ResultSet rs = st.executeQuery();
			    
			    List<Integer> ids = new ArrayList<Integer>();
			    while (rs.next()) {
			    	if(availableForSale) {
			    		if(rs.getInt("available_for_sale") == 1) {
			    			ids.add(rs.getInt("id"));
			    		}
			    	}else {
			    		ids.add(rs.getInt("id"));
			    	}
			    }
			    
			    int vehicleIds[] = new int[ids.size()];
			    for(int i = 0; i < ids.size(); i++) {
			    	vehicleIds[i] = ids.get(i);
			    }
			    
			    return vehicleIds;
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
	}
	
	/**
	 * Returns the specified value for a vehicle of the given identifier. Creates and executes a request to the vehicles database.
	 * @param id of the vehicle to return
	 * @param param the value to return
	 * @return the specified value for a vehicle, null if there is a problem of connection with the DB.
	 */
	private String getVehicleValue(int id, String param) {
		
		if(this.conn == null) {
			if(!this.initConnection()) {
				return null;
			}
		}
		
		String query = "select " + param + " from vehicle where id='" + id + "';";
		
	    PreparedStatement st;
		try {
			st = this.conn.prepareStatement(query);
		
		    ResultSet rs = st.executeQuery();
		    
		    while (rs.next()) {
		    	return rs.getString(param);
		    }
		    
		    return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Returns the vehicle make given its id.
	 * @param id of the vehicle
	 * @return manufacturer of vehicle 
	 */
	public String getVehicleMake(int id) {
		return this.getVehicleValue(id, "make");
	}
	
	/**
	 * Returns the model of the vehicle given its id.
	 * @param id of the vehicle
	 * @return model of vehicle 
	 */
	public String getVehicleModel(int id) {
		return this.getVehicleValue(id, "model");
	}
	
	/**
	 * Returns the year of building of the vehicle given its id.
	 * @param id of the vehicle
	 * @return year of the vehicle
	 */
	public int getVehicleYear(int id) {
		return Integer.parseInt(this.getVehicleValue(id, "year"));
	}
	
	/**
	 * Returns the seating capacity of the vehicle given its id.
	 * @param id of the vehicle
	 * @return seating capacity of the vehicle
	 */
	public int getVehicleSeatingCapacity(int id) {
		return Integer.parseInt(this.getVehicleValue(id, "seating_capacity"));
	}
	
	/**
	 * Returs the fuel type of the vehicle given its id.
	 * @param id of the vehicle
	 * @return fuel type of the vehicle
	 */
	public String getVehicleFuelType(int id) {
		return this.getVehicleValue(id, "fuel_type");
	}
	
	/**
	 * Returns the type of transmission of the vehicle given its id.
	 * @param id of the vehicle
	 * @return transmission of the vehicle
	 */
	public String getVehicleTransmission(int id) {
		return this.getVehicleValue(id, "transmission");
	}	
	
	/**Returns the price in EUR of the vehicle given its id.
	 * 
	 * @param id of the vehicle
	 * @return price of the vehicle in euros
	 */
	public float getVehiclePrice(int id) {
		return Float.parseFloat(this.getVehicleValue(id, "price_euros"));
	}
	
	/**
	 * Returns the nots that have been done by the previous renters to the vehicle given its id.
	 * @param id ofthe vehicle
	 * @return all notes of the vehicle
	 */
	public String getVehicleAllNotes(int id) {
		return this.getVehicleValue(id, "all_notes");
	}
	
	/**
	 * Returns the average of notes of the vehicle given its id.
	 * @param id of the vehicle
	 * @return average note of the vehicle
	 */
	public float getVehicleAverageNote(int id) {
		String allNotes = this.getVehicleValue(id, "all_notes");
		
		if (allNotes.length() == 0)
			return 0;
		
		int sum = 0;
    	for(int i = 0; i < allNotes.length(); i++) {
    		sum += Character.getNumericValue(allNotes.charAt(i));
    	}	
				
		return (float)sum/allNotes.length();
	}
	
	/**
	 * Returns the last message written by the last renter of the vehicle given its id.
	 * @param id of the vehicle
	 * @return last message of the vehicle 
	 */
	public String getVehicleLastMessage(int id) {
		return this.getVehicleValue(id, "last_message");
	}
	
	/**
	 * Returns the URL of the vehicle corresponding to its picture.
	 * @param id of the vehicle
	 * @return image url of the vehicle
	 */
	public String getVehicleUrl(int id) {
		String imgUrl = this.getVehicleValue(id, "img_url");
		return ((imgUrl.length() > 0) ? imgUrl : "https://images.unsplash.com/photo-1571127236794-81c0bbfe1ce3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80");
	}
	
	/**
	 * Returns true if the vehicle of the given id is available for sale.
	 * @param id of the vehicle
	 * @return is vehicle available for sale
	 */
	public boolean getVehicleAvailableForSale(int id) {
		return (Integer.parseInt(this.getVehicleValue(id, "available_for_sale")) == 1);
	}
	
	/**
	 * Returns a vehicle given its id.
	 * @param id of the vehicle
	 * @return vehicle object
	 */
	public Vehicle getVehicleObjById(int id) {
		return new Vehicle(
				id, 
				this.getVehicleMake(id), 
				this.getVehicleModel(id), 
				this.getVehicleYear(id), 
				this.getVehicleSeatingCapacity(id), 
				this.getVehicleFuelType(id), 
				this.getVehicleTransmission(id), 
				this.getVehiclePrice(id), 
				this.getVehicleAverageNote(id), 
				this.getVehicleLastMessage(id), 
				this.getVehicleUrl(id), 
				this.getVehicleAvailableForSale(id)
				);
	}
	
	/**
	 * Returns the vehicles list with the given identifiers.
	 * @param idList list of all ids 
	 * @return all vehicle objects from id list
	 */
	public Vehicle[] getVehicleObjList(int[] idList) {
		List<Integer> ids  = Arrays.stream(idList).boxed().collect(Collectors.toList());
		Vehicle vehicleList[] = new Vehicle[ids.size()];
		for(int i = 0; i < ids.size(); i++) {
			vehicleList[i] = this.getVehicleObjById(ids.get(i));
		}
		return vehicleList;
	}

	/**
	 * Returns all the vehicles.
	 * @return all vehicle objects
	 */
	public Vehicle[] getAllVehicleObj() {
		return this.getVehicleObjList(this.getVehicleIds(false));
	}
	
	/**
	 * Returns all the vehicles available for sale.
	 * @return all vehicles objects available for sale
	 */
	public Vehicle[] getVehicleObjAvailableForSale() {
		return this.getVehicleObjList(this.getVehicleIds(true));
	}
	
	/**
	 * Returns the vehicles of the shopping cart.
	 * @return all vehicles objects in shopping cart
	 */
	public Vehicle[] getVehicleObjCart() {
		return this.getVehicleObjList(this.getCart());
	}

	//BANK
	
	/**
	 * Returns the price in the given currency.
	 * @param currency the currency
	 * @return the price in the given currency.
	 * @throws ServiceException 
	 * @throws RemoteException 
	 */
	public double getExchangeRate(String currency) throws RemoteException, ServiceException {
		return new BankManagerServiceLocator().getBankManager().getExchangeRate(currency);
	}
	
	/**
	 * Returns the list of possible currencies.
	 * @return the list of possible currencies.
	 * @throws ServiceException 
	 * @throws RemoteException 
	 */
	public String[] getAllCurrencies() throws RemoteException, ServiceException {
		return new BankManagerServiceLocator().getBankManager().getAllCurrencies().split(";");
	}
	
	/**
	 * Returns true if the payment is validated (credit card valid and balance higher than totalPrice).
	 * @param cardnumber
	 * @param cvv
	 * @param expiracydate
	 * @param name
	 * @param currency
	 * @param totalPrice
	 * @return true if the paymen)t is validated.
	 * @throws ServiceException 
	 * @throws RemoteException 
	 */
	public boolean isValidPayment(String cardnumber, String cvv, String expiracydate, String name, String currency, double totalPrice) throws RemoteException, ServiceException {
		return new BankManagerServiceLocator().getBankManager().isValidPayment(cardnumber, cvv, expiracydate, name, currency, totalPrice);
	}
	
	// CART
	/**
	 * add a vehicle to shopping cart
	 * @param id of vehicle to add in the shopping cart
	 */
	public void addToCart(int id) {
		if(this.getVehicleAvailableForSale(id)) {
			this.cart.add(id); 	
		}
	}
	
	/**
	 * remove a vehicle from shopping cart
	 * @param id of the vehicle to remove from the shopping cart
	 */
	public void removeFromCart(int id) {
		this.cart.remove(id); 
	}
	
	/**
	 * clear the shopping cart
	 */
	public void clearCart() {
		this.cart.clear();
	}
	
	/**
	 * get list of vehicle ids in the shopping cart
	 * @return list of vehicle ids in the shopping cart
	 */
	public int[] getCart() {
	    int idList[] = new int[this.cart.size()];
	    
	    Iterator<Integer> it = this.cart.iterator();
	    int index = 0;
	    while (it.hasNext()) {
	    	idList[index] = it.next();
	    	index++;
	    }
	    
	    return idList;
	}
	
	//PRINT
	/**
	 * Print one vehicle to console
	 * @param id of vehicle to print
	 * @return string to print
	 */
	public String getPrintOneVehicle(int id) {
		String str = "";
		str += "Id"  + ": " + id + "\n";
		str += "Make"  + ": " + this.getVehicleMake(id) + "\n";
		str += "Model"  + ": " + this.getVehicleModel(id) + "\n";
		str += "Year"  + ": " + this.getVehicleYear(id) + "\n";
		str += "Seating capacity"  + ": " + this.getVehicleSeatingCapacity(id) + "\n";
		str += "Fuel type"  + ": " + this.getVehicleFuelType(id) + "\n";
		str += "Transmission"  + ": " + this.getVehicleTransmission(id) + "\n";
		str += "Price €"  + ": " + this.getVehiclePrice(id) + "\n";
		str += "Average note"  + ": " + this.getVehicleAverageNote(id) + "\n";
		str += "Last message"  + ": " + this.getVehicleLastMessage(id) + "\n";
		str += "Image url"  + ": " + this.getVehicleUrl(id) + "\n";
		str += "Is available for sale?"  + ": " + this.getVehicleAvailableForSale(id) + "\n";
		str += "\n";
		return str;
	}
	
	/**
	 * Print a list of vehicles to the console
	 * @param idList list of vehicle ids to print
	 * @return string to print
	 */
	public String getPrintList(int[] idList) {
		List<Integer> ids  = Arrays.stream(idList).boxed().collect(Collectors.toList());
		String str = "";
		for(int i = 0; i < ids.size(); i++) {
			str += this.getPrintOneVehicle(ids.get(i));
		}
		return str;
	}
	
	/**
	 * Print all vehicles to the console
	 * @return string to print
	 */
	public String getPrintAll() {
		return this.getPrintList(this.getVehicleIds(false));
	}
	
	/**
	 * Print all vehicles available for sale to the console
	 * @return string to print
	 */
	public String  getPrintAvailableForSale() {
		return this.getPrintList(this.getVehicleIds(true));
	}
	
	/**
	 * Print all vehicles in shopping cart to the console
	 * @return string to print
	 */
	public String getPrintCart() {
		return this.getPrintList(this.getCart());
	}
	
}
