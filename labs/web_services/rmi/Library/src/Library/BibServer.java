package Library;

import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;
import java.rmi.*;

public class BibServer{
    public static void main(String args[]){
        try{
            LocateRegistry.createRegistry(1099);
            IBib bib = new Bib();
            Naming.rebind("rmi://localhost/BibService", bib);
        }
        catch (Exception e){
            System.out.println("Trouble: " + e);
        }
    }
}