package org.example.models;

public class Event {
    private Long idEvent;
    private String titre;
    private String description;
    private String dateEvent;
    private String nSale;
    private String image;

    public Event() {}

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
}