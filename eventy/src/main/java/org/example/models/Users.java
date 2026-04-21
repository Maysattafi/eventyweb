package org.example.models;

import java.util.Objects;

public class Users {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;

    // Default constructor
    public Users() {}

    // Constructor for registration
    public Users(String name, String email, String password) {
        this.name = name != null ? name.trim() : null;
        this.email = email != null ? email.trim() : null;
        this.password = password; // will be hashed later
        this.role = "etudiant";   // default role
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name != null ? name.trim() : null; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email != null ? email.trim() : null; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Users users = (Users) o;
        return id == users.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}