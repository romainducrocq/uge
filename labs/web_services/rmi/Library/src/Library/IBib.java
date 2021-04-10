package Library;

import java.rmi.*;
import java.util.List;

public interface IBib extends Remote {
    public void add(long ISBN, String titre, String auteur) throws RemoteException;
    public void del(long ISBN) throws RemoteException;
    public List<Book> lookT(String titre) throws RemoteException;
    public List<Book> lookA(String auteur) throws RemoteException;
}