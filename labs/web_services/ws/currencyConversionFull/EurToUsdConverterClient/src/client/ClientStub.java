package client;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import eurToUsd.EurToUsdConverter;
import eurToUsd.EurToUsdConverterServiceLocator;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;

import org.apache.axis.types.UnsignedLong;

import com.currencysystem.webservices.currencyserver.*;
import com.dataaccess.www.webservicesserver.*;


public class ClientStub {

		public static void main(String[] args) throws ServiceException, RemoteException{
			
			double amountEur = 1000;
			
			EurToUsdConverter eurToUsd = new EurToUsdConverterServiceLocator().geteurToUsdConverter();	
			System.out.println("Webservice as client to multiple webservices:");
			System.out.println(amountEur + " eur = " + eurToUsd.convert(amountEur) + " usd\n");
			
			System.out.println("Real time with remote webservices:");
			CurrencyServerSoap currencySystem = new CurrencyServerLocator().getCurrencyServerSoap();			
			double amountUsd = (double)currencySystem.convert("", "EUR", "USD", amountEur, false, "", CurncsrvReturnRate.curncsrvReturnRateNumber, "", "");
			System.out.println(amountEur + " eur = " + amountUsd + " usd");

			
			NumberConversionSoapType numberToLetter = new NumberConversionLocator().getNumberConversionSoap(); 
			String amountEurString = numberToLetter.numberToWords(new UnsignedLong(Math.round(amountEur))); 
			String amountUsdString = numberToLetter.numberToWords(new UnsignedLong(Math.round(amountUsd))); 
			System.out.println(amountEurString + " eur = " + amountUsdString + " usd");
			
		}
}


//Real type currencies
//http://fx.currencysystem.com/webservices/CurrencyServer5.asmx?wsdl
//http://barbier.perso.univ-pau.fr/Software_Components_and_Services/SOA/
//CurrencyServerSoap currencySystem = new CurrencyServerLocator().getCurrencyServerSoap();
//public java.lang.Object convert(java.lang.String licenseKey, java.lang.String fromCurrency, java.lang.String toCurrency, double amount, boolean rounding, java.lang.String format, com.currencysystem.webservices.currencyserver.CurncsrvReturnRate returnRate, java.lang.String time, java.lang.String type)


//Numbers into English letters
//http://www.dataaccess.com/webservicesserver/numberconversion.wso?wsdl
//NumberConversionSoapType numberToLetter = new NumberConversionLocator().getNumberConversionSoap(); 
//String amountString = numberToLetter.numberToWords(new UnsignedLong(Math.round(amount))); 
//public java.lang.String numberToWords(org.apache.axis.types.UnsignedLong ubiNum)
 
