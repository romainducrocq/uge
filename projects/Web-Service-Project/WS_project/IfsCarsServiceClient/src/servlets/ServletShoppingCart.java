package servlets;

import java.io.IOException;
import java.util.Arrays;
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

@WebServlet("/shop")
public class ServletShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IfsCarService ifc = null; 
	
    public ServletShoppingCart() {
        super();
    	try {
			this.ifc = new IfsCarServiceServiceLocator().getIfsCarService();
			((IfsCarServiceSoapBindingStub) this.ifc).setMaintainSession(true);
		} catch (ServiceException e) {
			e.printStackTrace();
		}	
    }

    //https://tomcat.apache.org/tomcat-5.5-doc/servletapi/javax/servlet/http/HttpServletRequest.html
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;		
		dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(request, response);
		
	}		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;
		
		List<String> vehicles = Arrays.asList(request.getParameter("vehicles").split(","));

		this.ifc.clearCart();
		for(int i = 0; i < vehicles.size(); i++) {
			this.ifc.addToCart(Integer.parseInt(vehicles.get(i)));
		}
		
		//request.setAttribute("currencies", Arrays.asList(new String[]{"AED","AFN","ALL","AOA","ARS","AUD","AZN","BBD","BDT","BGN","BHD","BND","BOB","BRL","BSD","BWP","BYN","BZD","CAD","CDF","CHF","CLP","CNY","COP","CRC","CVE","CZK","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","GBP","GHS","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","INR","IQD","ISK","JMD","JOD","JPY","KES","KHR","KMF","KRW","KWD","KZT","LBP","LKR","LYD","MAD","MDL","MKD","MMK","MOP","MRU","MUR","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","SAR","SEK","SGD","SRD","THB","TMT","TND","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VND","XAF","XCD","XDR","XOF","XPF","YER","ZAR","ZMW"}));
		
		request.setAttribute("currencies",Arrays.asList(this.ifc.getAllCurrencies()));

		request.setAttribute("selectedCurrency", "EUR");
		request.setAttribute("exchangeRate", (double)1);
		request.setAttribute("shoppingCart", this.ifc.getVehicleObjCart());
				
		dispatcher = request.getRequestDispatcher("/WEB-INF/payment.jsp");
		dispatcher.forward(request, response);

	}
}