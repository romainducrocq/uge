package client;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import accountmanager.AccountManager;
import accountmanager.AccountManagerServiceLocator;
import accountmanager.AccountManagerSoapBindingStub;

public class ClientStub {

	public static void main(String[] args) throws ServiceException, RemoteException{
		AccountManager service = new AccountManagerServiceLocator().getAccountManager();
		
		((AccountManagerSoapBindingStub) service).setMaintainSession(true);
		
		System.out.println("Balance: " + service.valueBalance());
		System.out.println("Withdraw 10: " + service.withdrawal(10));
		System.out.println("Balance: " + service.valueBalance());
		System.out.println("Deposit 10");
		service.depotDe(10);
		System.out.println("Balance: " + service.valueBalance());
		System.out.println("Withdraw 5: " + service.withdrawal(5));
		System.out.println("Balance: " + service.valueBalance());		
	}
}