package client;

import java.rmi.RemoteException;
import java.util.Arrays;
import java.util.List;

import javax.xml.rpc.ServiceException;

import ifscarsservice.IfsCarService;
import ifscarsservice.IfsCarServiceServiceLocator;
import ifscarsservice.IfsCarServiceSoapBindingStub;

public class IfsCarsServiceClientStub {

	public static void main(String[] args) throws ServiceException, RemoteException {
		IfsCarService ifc = new IfsCarServiceServiceLocator().getIfsCarService();		
		((IfsCarServiceSoapBindingStub) ifc).setMaintainSession(true);
		
		//TEST API HERE
		
		System.out.println(ifc.getPrintAll());
		
		System.out.println(ifc.getPrintCart());
		
		ifc.addToCart(1);
		ifc.addToCart(2);
		ifc.addToCart(6);
		ifc.addToCart(7);
		
		ifc.removeFromCart(2);
		ifc.removeFromCart(7);
		
		System.out.println(ifc.getPrintCart());
		
		List<String> currencies = Arrays.asList(ifc.getAllCurrencies());
		for(int i = 0; i < currencies.size(); i++) {
			System.out.print(currencies.get(i) + " ");
		}
		
		System.out.println("");
		System.out.println(ifc.getExchangeRate("USD"));
		System.out.println(ifc.getExchangeRate("GBP"));
		System.out.println(ifc.isValidPayment("0123012301230123", "0123", "January;2021", "Kurt;Cobain", "PLN", 40000));


	}

}


