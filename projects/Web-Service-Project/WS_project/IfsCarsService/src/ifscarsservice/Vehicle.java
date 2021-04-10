package ifscarsservice;

/**
 * Implementation of a vehicle used by the IfsCarsService Web Service.
 * Contains a constructor to build a Vehicle object from database and getters methods.
 *
 */
public class Vehicle implements java.io.Serializable {
		
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String make;
	private String model;
	private int year;
	private int seatingCapacity;
	private String fuelType;
	private String transmission;
	private float price;
	private float averageNote;
	private String lastMessage;
	private String imgUrl;
	private boolean availableForSale;
	
	public Vehicle(){
		
	}
	
	/**
	 * Constructor of Vehicle
	 * @param id
	 * @param make
	 * @param model
	 * @param year
	 * @param seatingCapacity
	 * @param fuelType
	 * @param transmission
	 * @param price
	 * @param averageNote
	 * @param lastMessage
	 * @param imgUrl
	 * @param availableForSale
	 */
	public Vehicle(int id, String make, String model, int year, int seatingCapacity, String fuelType, String transmission, float price, float averageNote, String lastMessage, String imgUrl, boolean availableForSale) {
		this.id = id;
		this.make = make;
		this.model = model;
		this.year = year;
		this.seatingCapacity = seatingCapacity;
		this.fuelType = fuelType;
		this.transmission = transmission;
		this.price = price;
		this.averageNote = averageNote;
		this.lastMessage = lastMessage;
		this.imgUrl = imgUrl;
		this.availableForSale = availableForSale;
	}
	
	/**
	 * 
	 * @return id
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * 
	 * @return manufacturer
	 */
	public String getMake() {
		return this.make;
	}
	
	/**
	 * 
	 * @return model
	 */
	public String getModel() {
		return this.model;
	}
	
	/**
	 * 
	 * @return year
	 */
	public int getYear() {
		return this.year;
	}
	
	/**
	 * 
	 * @return seating capacity
	 */
	public int getSeatingCapacity() {
		return this.seatingCapacity;
	}
	
	/**
	 * 
	 * @return fuel type
	 */
	public String getFuelType() {
		return this.fuelType;
	}
	
	/**
	 * 
	 * @return transmission
	 */
	public String getTransmission() {
		return this.transmission;
	}	
	
	/**
	 * 
	 * @return price
	 */
	public float getPrice() {
		return this.price;
	}
	
	/**
	 * 
	 * @return average note
	 */
	public float getAverageNote() {
		return this.averageNote;
	}
	
	/**
	 * 
	 * @return last message
	 */
	public String getLastMessage() {
		return this.lastMessage;
	}
	
	/**
	 * 
	 * @return img url
	 */
	public String getImgUrl() {
		return this.imgUrl;
	}
	
	/**
	 * 
	 * @return is available for sale
	 */
	public boolean getAvailableForSale() {
		return this.availableForSale;
	}

}
