package com.onlineexam.model;

public class Activity {
    protected String id;
    protected String title;

    public Activity(String id, String title) {
        this.id = id;
        this.title = title;
    }

    public String getId() { return id; }
    public String getTitle() { return title; }
}
