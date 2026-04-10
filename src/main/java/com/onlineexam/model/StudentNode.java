package com.onlineexam.model;

// model/StudentNode.java
public class StudentNode {
    public String id;
    public String username;
    public String role;
    public StudentNode next;
    public StudentNode prev;

    public StudentNode(String id, String username, String role) {
        this.id = id;
        this.username = username;
        this.role = role;
    }
}

