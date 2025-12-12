package com.example.ASM2_JAV101_TH04864.Entity;

public class Account {
    private int id;
    private String username;
    private String password;
    private boolean active;
    private String Email;
    public Account() {}

    public Account(int id, String username, String password, boolean active, String email) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.active = active;
        Email = email;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
