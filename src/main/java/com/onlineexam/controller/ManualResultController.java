package com.onlineexam.controller;

import com.onlineexam.model.ManualResult;
import com.onlineexam.service.ManualResultService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.*;



import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;




@Controller
@RequestMapping("/manual")
public class ManualResultController {

    private ManualResultService service = new ManualResultService();

    @GetMapping("/enter")
    public String showFormPage(HttpServletRequest request) {
        List<String> students = new ArrayList<>();
        List<String> exams = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader("data/users.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] p = line.split(",");
                if (p.length == 4 && "student".equalsIgnoreCase(p[3])) {
                    students.add(p[0]); // student ID
                }
            }
        } catch (IOException e) { e.printStackTrace(); }

        try (BufferedReader br = new BufferedReader(new FileReader("data/exams.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] p = line.split(",");
                if (p.length >= 2) {
                    exams.add(p[0]); // exam ID
                }
            }
        } catch (IOException e) { e.printStackTrace(); }

        request.setAttribute("students", students);
        request.setAttribute("exams", exams);
        return "manual-result-form";
    }

    @PostMapping("/submit")
    public String submitResult(HttpServletRequest request) {
        String studentId = request.getParameter("studentId");
        String examId = request.getParameter("examId");
        int written = Integer.parseInt(request.getParameter("written"));

        int mcq = service.getMcqMarks(studentId, examId);
        ManualResult result = new ManualResult(studentId, examId, mcq, written);
        service.saveManualResult(result);

        return "redirect:/manual/success";
    }

    @GetMapping("/success")
    public String successPage() {
        return "manual-result-success"; // maps to WEB-INF/manual-result-success.jsp
    }


    @GetMapping("/view")
    public String viewResults(HttpServletRequest request) {
        List<ManualResult> list = service.getAllManualResults();
        request.setAttribute("results", list);
        return "manual-result-view";
    }






}
