package org.example.models;

public class Event {
    private Long idEvent;
    private String titre;
    private String description;
    private String dateEvent;
    private String nSale;
    private String image;      // ← Important: image path
    private String category;

    // Constructors
    public Event() {}

    public Event(String titre, String description, String dateEvent, String nSale, String image) {
        this.titre = titre;
        this.description = description;
        this.dateEvent = dateEvent;
        this.nSale = nSale;
        this.image = image;
    }

    // Getters and Setters
    public Long getIdEvent() { return idEvent; }
    public void setIdEvent(Long idEvent) { this.idEvent = idEvent; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDateEvent() { return dateEvent; }
    public void setDateEvent(String dateEvent) { this.dateEvent = dateEvent; }

    public String getnSale() { return nSale; }
    public void setnSale(String nSale) { this.nSale = nSale; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}