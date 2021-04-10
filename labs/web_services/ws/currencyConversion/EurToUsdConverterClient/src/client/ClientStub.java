package client;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import eurToUsd.EurToUsdConverter;
import eurToUsd.EurToUsdConverterServiceLocator;
//import eurToUsd.EurToUsdConverterSoapBindingStub;

public class ClientStub {

		public static void main(String[] args) throws ServiceException, RemoteException{
			
			EurToUsdConverter eur = new EurToUsdConverterServiceLocator().geteurToUsdConverter();
			
			//((EurToUsdConverterSoapBindingStub) eur).setMaintainSession(true);
			
			System.out.println("1000 eur = " + eur.convert(1000) + " usd");
			
		}
}