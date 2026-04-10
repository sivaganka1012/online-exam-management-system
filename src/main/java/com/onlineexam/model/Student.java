package com.onlineexam.model;

public class Student extends User {
    private int score;
    private String role;

    public Student(String userId, String username, String password, String role, int score) {
        super(userId, username, password, role); // Pass role to parent
        this.score = score;
        this.role=role;
    }

    public int getScore() {
        return score;
    }
    public String getrole(){return role; }

    public void setScore(int score) {
        this.score = score;
    }
    public void getrole(int score) {
        this.role = role;
    }
}