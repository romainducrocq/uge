package servlets;

import java.io.IOException;
import java.util.Arrays;
//import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.rpc.ServiceException;

import ifscarsservice.IfsCarService;
import ifscarsservice.IfsCarServiceServiceLocator;
import ifscarsservice.IfsCarServiceSoapBindingStub;

@WebServlet("/payment")
public class ServletPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IfsCarService ifc = null; 
	
	//private HashMap<String, Double> currencyRates;
	
    public ServletPayment() {
    	super();
    	try {
			this.ifc = new IfsCarServiceServiceLocator().getIfsCarService();
			((IfsCarServiceSoapBindingStub) this.ifc).setMaintainSession(true);
		} catch (ServiceException e) {
			e.printStackTrace();
		}

    	/*List<String> currencies = Arrays.asList(new String[]{"AED","AFN","ALL","AOA","ARS","AUD","AZN","BBD","BDT","BGN","BHD","BND","BOB","BRL","BSD","BWP","BYN","BZD","CAD","CDF","CHF","CLP","CNY","COP","CRC","CVE","CZK","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","GBP","GHS","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","INR","IQD","ISK","JMD","JOD","JPY","KES","KHR","KMF","KRW","KWD","KZT","LBP","LKR","LYD","MAD","MDL","MKD","MMK","MOP","MRU","MUR","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","SAR","SEK","SGD","SRD","THB","TMT","TND","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VND","XAF","XCD","XDR","XOF","XPF","YER","ZAR","ZMW"}); 
    	List<Double> rates = Arrays.asList(new Double[]{4.3368303106108,89.87,124.2,780.856,91.5953,1.63,2.0065168480076,2.3649,100.196,1.9558,0.44107,1.5951429809193,8.0944,6.4508,1.1698,13.230692179886,3.0318650235054,2.3396,1.5528,2312.4636,1.0805,894.90437982658,7.8071,4308.0025263507,709.82,110.265,26.461,7.4468,68.437,151.68255,18.5844,17.992,44.193,1.0,2.4958,0.89683,6.757,9.1046,244.72,9.1608,28.593,7.572,73.447,355.71,16741.86,3.979,88.186,1383.7,161.9,172.1714,0.82939,123.88,127.32,4754.1,491.96775,1311.84,0.3611170900633,508.05400864539,1772.2,215.63,1.5991,10.739813736903,20.218698524593,61.759,1550.7,9.4356,48.26,47.402506408431,24.2239,4.8707,86.93,19.06,450.91,40.754,10.8123,138.7,1.7304,0.4528908296943,1.1698,4.3093126385809,4.1346060508008,56.954,187.64,4.496,8218.4,4.3066,4.8698,117.71,91.6113,4.4283608459189,10.2537,1.5934,16.528,35.646,4.1275943737345,3.2401,9.1303,7.9967615148807,33.69014084507,2714.5035,33.2118,4373.3,1.1815,50.316,12236.332940294,27114.0,655.957,3.1585,0.832151,655.957,119.3317422,291.79,18.4068,23.893});
    	
    	this.currencyRates = new HashMap<String, Double>();
    	for(int i = 0; i < currencies.size(); i++) {
    		this.currencyRates.put(currencies.get(i), rates.get(i));
    	}*/
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher;		
		dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;
		
		String action = request.getParameter("action");
		List<String> vehicles = Arrays.asList(request.getParameter("vehicles").split(","));
		String currency = request.getParameter("currency");
		
		this.ifc.clearCart();
		for(int i = 0; i < vehicles.size(); i++) {
			this.ifc.addToCart(Integer.parseInt(vehicles.get(i)));
		}
		
		request.setAttribute("shoppingCart", this.ifc.getVehicleObjCart());
		
		request.setAttribute("selectedCurrency", currency);
		
		request.setAttribute("exchangeRate", this.ifc.getExchangeRate(currency));
		
		switch(action){ 
            case "currency": 
        		List<String> activeCurrencies = Arrays.asList(request.getParameter("activeCurrencies").split(","));
        		
        		request.setAttribute("currencies", activeCurrencies);
        		
            	dispatcher = request.getRequestDispatcher("/WEB-INF/payment.jsp");
        		dispatcher.forward(request, response);
        		break;
            case "payment": 
            	String name = request.getParameter("name");
            	String cardnumber = request.getParameter("cardnumber");
            	String cvv = request.getParameter("cvv");
            	String expiracydate = request.getParameter("expiracydate");
            	double totalPrice = Double.parseDouble(request.getParameter("price"));

            	/*System.out.println(name);
        		System.out.println(cardnumber);
        		System.out.println(cvv);
        		System.out.println(expiracydate);
        		System.out.println(totalPrice);*/
        		
            	//request.setAttribute("paiementSuccess", false);
            	request.setAttribute("paiementSuccess", this.ifc.isValidPayment(cardnumber, cvv, expiracydate, name, currency, totalPrice));
            	
            	dispatcher = request.getRequestDispatcher("/WEB-INF/done.jsp");
        		dispatcher.forward(request, response);
        		
            	break;
            default: 
        		break;
        }		
	}

}