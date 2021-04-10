package Lib;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;

public class  Library {
    private HashMap <Long, Book> books;

    public Library(){
        books = new HashMap<Long, Book>();
    }

	public void add(long ISBN, String auteur, String titre){
        Book b = new Book(ISBN, auteur, titre);
        books.put(new Long(ISBN), b);
    }

	public void del(long ISBN){
        books.remove(new Long(ISBN));
    }

    public Book[] lookT(String titre){
        List booksList = new ArrayList<Book>();
        for(Book b : books.values()){
            if(b.getTitre().equals(titre)){
                booksList.add(b);
            }
        }
        
        Book[] booksTab = new Book[booksList.size()];
        for(int i = 0; i < booksList.size(); i++) {
        	booksTab[i] = (Book) booksList.get(i);
        }
        return booksTab;
    }

    public Book[] lookA(String auteur){
        List booksList = new ArrayList<Book>();
        for(Book b : books.values()){
            if(b.getAuteur().equals(auteur)){
                booksList.add(b);
            }
        }
        
        Book[] booksTab = new Book[booksList.size()];
        for(int i = 0; i < booksList.size(); i++) {
        	booksTab[i] = (Book) booksList.get(i);
        }
        return booksTab;
    }
}