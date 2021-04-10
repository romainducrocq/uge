package eurToUsd;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import eurToJpy.*;
import gbpToUsd.*;
import jpyToGbp.*;

public class eurToUsdConverter {
	
	public double convert(double eur) throws ServiceException, RemoteException{
		EurToJpyConverter eurToJpy = new EurToJpyConverterServiceLocator().geteurToJpyConverter();
		JpyToGbpConverter jpyToGbp = new JpyToGbpConverterServiceLocator().getjpyToGbpConverter();
		GbpToUsdConverter gbpToUsd = new GbpToUsdConverterServiceLocator().getgbpToUsdConverter();

		return gbpToUsd.convert(jpyToGbp.convert(eurToJpy.convert(eur)));
	}

}
