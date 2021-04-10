package client;

import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
import hello.Hello;
import hello.HelloServiceLocator;

public class ClientStub {

	public static void main(String[] args) throws ServiceException, RemoteException{
		Hello service = new HelloServiceLocator().getHello();
		System.out.println(service.sayHello("Romain"));
	}

}
