package org.example.models;

public class Event {
    private Long id;
    private String titre;
    private String description;
    private String date;
    private String n_sale;   // salle / location

    public Event() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getn_sale() { return n_sale; }
    public void setn_sale(String n_sale) { this.n_sale = n_sale; }
}
