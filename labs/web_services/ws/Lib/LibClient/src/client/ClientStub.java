package client;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import Lib.Library;
import Lib.LibraryServiceLocator;
import Lib.LibrarySoapBindingStub;

public class ClientStub {

		public static void main(String[] args) throws ServiceException, RemoteException{
			
			Library lib = new LibraryServiceLocator().getLibrary();
			
			((LibrarySoapBindingStub) lib).setMaintainSession(true);
			
			lib.add(123L, "Romain", "WS");
			System.out.println(lib.lookA("Romain")[0].getTitre());
			
		}
}