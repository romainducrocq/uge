package Library;

import java.rmi.*;
import java.rmi.registry.*;
import java.util.List;
import java.net.*;

public class BibClient{
    public static void main(String[] args){
        try{
            IBib bib = (IBib)Naming.lookup("rmi.//localhost/BibService");
            bib.add(1234, "Benoit", "Philo");
            bib.add(1235, "Mamadou", "Maths");
            bib.add(1236, "Ahmed", "Science");
            bib.add(1237, "David", "Chimie");
            List<Book> bb = bib.lookA("Benoit");
            System.out.println("Benoit a écrit " + bb.get(0).getTitre());
            bb.get(0).setAuteur("Baptiste");
            bb = bib.lookA("Benoit");
            System.out.println("Benoit a écrit " + bb.get(0).getTitre());
        }catch (Exception e){
            System.out.println("Trouble " + e);
        }
    }
}