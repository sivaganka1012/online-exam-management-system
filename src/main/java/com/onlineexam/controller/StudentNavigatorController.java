package com.onlineexam.controller;


import com.onlineexam.model.LinkedStudentList;
import com.onlineexam.model.StudentNode;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;







// controller/StudentNavigatorController.java
@Controller
@RequestMapping("/students")
public class StudentNavigatorController {
    private LinkedStudentList studentList;

    public StudentNavigatorController() {
        studentList = new LinkedStudentList();
        studentList.buildFromFile("data/users.txt");
    }

    @GetMapping("/view")
    public String viewStudents(HttpServletRequest request,
                               @RequestParam(required = false) String id,
                               @RequestParam(required = false) String direction) {
        StudentNode current = studentList.head;

        if (id != null && direction != null) {
            while (current != null) {
                if (current.id.equals(id)) {
                    current = "next".equals(direction) ? current.next : current.prev;
                    break;
                }
                current = current.next;
            }
        }

        if (current == null) current = studentList.head;

        request.setAttribute("student", current);
        return "student-card";
    }
}

