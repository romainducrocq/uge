package Library;

import java.rmi.*;
import java.rmi.server.*;
import java.util.*;
import java.util.Map.Entry;

public class  Bib extends UnicastRemoteObject implements IBib {
    private HashMap <Long, Book> books;

    public Bib() throws  RemoteException {
        super();
        books = new HashMap<Long, Book>();
    }

	public void add(long ISBN, String auteur, String titre) throws  RemoteException{
        Book b = new Book(ISBN, auteur, titre);
        books.put(new Long(ISBN), b);
    }

	public void del(long ISBN) throws RemoteException{
        books.remove(new Long(ISBN));
    }

    public List<Book> lookT(String titre) throws RemoteException{
        List booksList = new ArrayList<Book>();
        for(Book b : books.values()){
            if(b.getTitre().equals(titre)){
                booksList.add(b);
            }
        }
        return booksList;
    }

    public List<Book> lookA(String auteur) throws RemoteException{
        List booksList = new ArrayList<Book>();
        for(Book b : books.values()){
            if(b.getAuteur().equals(auteur)){
                booksList.add(b);
            }
        }
        return booksList;
    }
}