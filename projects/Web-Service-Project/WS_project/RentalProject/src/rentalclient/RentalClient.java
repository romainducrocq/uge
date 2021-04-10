package rentalclient;


import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import employees.Employee;
import shared.IEmployee;
import shared.IEmployeeDB;
import shared.IVehicle;
import shared.IVehicleParkRentalManagement;

import java.net.MalformedURLException;

/**
 * Test class to test RMI objects for rental.
 *
 */
public class RentalClient {
	
	public static void main(String[] args) {
		try {
			IVehicleParkRentalManagement rentalMgt = (IVehicleParkRentalManagement) Naming.lookup("//localhost:1099/rentalmanagement");
			Collection<IVehicle> listVehicle = rentalMgt.getAvailableVehiclesForRental();
			
			displayListVehicles(listVehicle);
			
			IEmployeeDB employeeDB = (IEmployeeDB) Naming.lookup("//localhost:2000/employeeDB");
									
			System.out.println("Is ngrumbach/password a real employee ? "+employeeDB.isEmployee("ngrumbach","password"));
			System.out.println("Is ngrumbach/wrongpassword a real employee ? "+employeeDB.isEmployee("ngrumbach","wrongpassword"));
			
			IEmployee nat = employeeDB.getEmployee("ngrumbach");
			IEmployee romain = employeeDB.getEmployee("rducrocq");
			IEmployee alex = employeeDB.getEmployee("atherond");
			
			rentalMgt.rentVehicle(nat, 1);
			
			rentalMgt.rentVehicle(romain, 1);
		
			rentalMgt.rentVehicle(alex, 2);
			
			rentalMgt.returnCar(1, 4, "Excellent car ! I was flashed at 230 km/h !!!! ");

			displayListVehicles(listVehicle);


		}
		catch (MalformedURLException me) {
			me.printStackTrace();
		}
		catch (RemoteException re) {
			System.out.println("Server-cient error : "+re.getMessage());
		} catch (NotBoundException e) {
			e.printStackTrace();
		}
	}
	
	public static void displayListVehicles(Collection<IVehicle> listVehicle) throws RemoteException {
		Iterator<IVehicle> it = listVehicle.iterator();
		System.out.println("**********************    AVAILABLE CARS    **********************");
		while (it.hasNext()) {
			IVehicle v = it.next();
			System.out.println(v.getDisplayString());
		}
	}
}