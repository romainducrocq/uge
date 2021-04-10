package Lib;

public class Book implements java.io.Serializable {
    private String auteur;
    private String titre;
    private Long ISBN;

    public Book(){
    }
    
    public Book(Long ISBN, String auteur, String titre){
        this.titre = titre;
        this.auteur = auteur;
        this.ISBN = ISBN;
    }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public Long getISBN() { return ISBN; }
    public void setISBN(Long ISBN) { this.ISBN = ISBN; }

    public String toString() { return "ISBN: " + ISBN + ", Auteur: " + auteur + ", Titre: " + titre; }
}
