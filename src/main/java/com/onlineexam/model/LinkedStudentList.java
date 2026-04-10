package com.onlineexam.model;


// utils/LinkedStudentList.java
import java.io.*;
import com.onlineexam.model.StudentNode;

public class LinkedStudentList {
    public StudentNode head;

    public void buildFromFile(String path) {
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            StudentNode prev = null;

            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && "student".equalsIgnoreCase(parts[3])) {
                    StudentNode node = new StudentNode(parts[0], parts[1], parts[3]);
                    if (head == null) head = node;
                    node.prev = prev;
                    if (prev != null) prev.next = node;
                    prev = node;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
