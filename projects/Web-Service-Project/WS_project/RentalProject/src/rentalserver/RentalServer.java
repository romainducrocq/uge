package rentalserver;

import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

/**
 * The rental server :
 * It creates and exports a Registry instance on the local host that accepts requests on the port 1099.
 * It creates a VehicleParkRentalManagement object and associate it with the name "rentalMgt".
 *
 */
public class RentalServer {

	public static void main(String[] args) {
		try {
			
			RentalManager rentalMgt = new RentalManager();

			LocateRegistry.createRegistry(1099);
			Naming.rebind("//localhost:1099/rentalmanagement", rentalMgt);
			
			System.out.println("Server launched and rental management system registered");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}