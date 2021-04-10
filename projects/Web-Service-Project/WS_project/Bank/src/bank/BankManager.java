package bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.currencysystem.webservices.currencyserver.CurncsrvReturnRate;
import com.currencysystem.webservices.currencyserver.CurrencyServerLocator;

/**
 * This class is used to handle all the bank tasks.
 * It connects to the banc accounts database to check that a payment is valid.
 * It also communicates with the WS CurrencyServer to get in real-time the currency rates.
 */
public class BankManager {
	
	/**
	 * Returns the list of all currencies by contacting the CurrencyServer WS.
	 * @return List off all currencies
	 * @throws RemoteException if it can not communicate with the CurrencyServer WS.
	 * @throws ServiceException if it can not communicate with the CurrencyServer WS.
	 */
	public String getAllCurrencies() throws RemoteException, ServiceException {
		return new CurrencyServerLocator().getCurrencyServerSoap().activeCurrencies("");
	}
	
	/**
	 * Returns the exchange rate of the given currency to EUR by contacting the CurrencyServer WS.
	 * @param currency the currency for wich the rate has to be returned
	 * @return exchange rate from currency to EUR
	 * @throws RemoteException if it can not communicate with the CurrencyServer WS.
	 * @throws ServiceException if it can not communicate with the CurrencyServer WS.
	 */
	public double getExchangeRate(String currency) throws RemoteException, ServiceException {
		return (double)(new CurrencyServerLocator().getCurrencyServerSoap().convert("", "EUR", currency, (double)1, false, "", CurncsrvReturnRate.curncsrvReturnRateNumber, "", ""));
	}
	
	//see for mysql driver path over wsdl !
	//https://stackoverflow.com/questions/1585811/classnotfoundexception-com-mysql-jdbc-driver
	/**
	 * Checks if a payment is valid by connecting to a MySQL database.
	 * @param cardNumber the card number
	 * @param cvv card verification code
	 * @param expiracyDate the expiration date
	 * @param name the name of the owner of the card
	 * @param currency the currency in which the price is given
	 * @param totalPrice the price
	 * @return true if payment info are correct and balance is greater or equal than totalPrice, else return false
	 */
	public boolean isValidPayment(String cardNumber, String cvv, String expiracyDate, String name, String currency, double totalPrice) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankDB", "root", "1Rootpwd!");
			String query = "select balance " + 
					"from bank" + " " + 
					"where card_number='" + cardNumber + "' " +
					"and cvv='" + cvv + "' " +
					"and expiracy_date='" + expiracyDate + "' " +
					"and name='" + name + "' " +
					"and currency='" + currency + "';";
			
		    PreparedStatement st;
			try {
				st = conn.prepareStatement(query);
			
			    ResultSet rs = st.executeQuery();
			    while (rs.next()) {
			    	
			    	if(((double)rs.getFloat("balance")) >= totalPrice) {
				    	return true;
			    	}			    	
			    	return false;
			    }
			    
			    return false;
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		} catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
			return false;
		}
	}
}
