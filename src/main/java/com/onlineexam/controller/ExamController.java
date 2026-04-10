package com.onlineexam.controller;

import com.onlineexam.model.Exam;
import com.onlineexam.model.Question;
import com.onlineexam.service.ExamService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;








import java.io.File;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;









@Controller
@RequestMapping("/exams")
public class ExamController {

    private final ExamService examService = new ExamService();
    private final Map<String, Exam> examMap = new HashMap<>();

    // Load saved exams from file on startup
    public ExamController() {
        List<Exam> existingExams = examService.getAllExams();
        for (Exam exam : existingExams) {
            examMap.put(exam.getExamId(), exam);
        }
    }

    // ✅ Create exam and redirect to success page
    @GetMapping("/create")
    public void createExam(
            @RequestParam String id,
            @RequestParam String title,
            HttpServletResponse response
    ) throws IOException {
        Exam exam = new Exam(id, title);
        examService.saveExam(exam);
        examMap.put(id, exam);
        response.sendRedirect("/create-success");
    }

//    // ✅ Add question to an exam
//    @PostMapping("/add-question")
//    @ResponseBody
//    public String addQuestionToExam(
//            @RequestParam String examId,
//            @RequestParam String question,
//            @RequestParam String opt1,
//            @RequestParam String opt2,
//            @RequestParam String opt3,
//            @RequestParam String opt4,
//            @RequestParam int correct
//    ) {
//        String[] options = {opt1, opt2, opt3, opt4};
//        Question q = new Question(question, options, correct);
//
//        if (examMap.containsKey(examId)) {
//            Exam exam = examMap.get(examId);
//            exam.addQuestion(q);
//            examService.saveQuestion(examId, q);
//            return "Question added to exam: " + examId;
//        } else {
//            return "Exam not found. Please create the exam first.";
//        }
//    }






    @PostMapping("/add-question")
    @ResponseBody
    public String addQuestionToExam(
            @RequestParam String examId,
            @RequestParam String question,
            @RequestParam String opt1,
            @RequestParam String opt2,
            @RequestParam String opt3,
            @RequestParam String opt4,
            @RequestParam int correct // 1 to 4 from form
    ) {
        if (correct < 1 || correct > 4) {
            return "❌ Correct option must be between 1 and 4";
        }

        String[] options = {opt1, opt2, opt3, opt4};

        // ✅ Convert to 0-based index
        Question q = new Question(question, options, correct - 1);

        if (examMap.containsKey(examId)) {
            Exam exam = examMap.get(examId);
            exam.addQuestion(q);
            examService.saveQuestion(examId, q);
            return "✅ Question added to exam: " + examId;
        } else {
            return "❌ Exam not found. Please create the exam first.";
        }
    }












    // ✅ View all exams with their questions
    @GetMapping("/view-all")
    public String viewAllExamsAndQuestions(Model model) {
        Map<String, Exam> allExams = examService.loadExamsWithQuestions();
        model.addAttribute("examMap", allExams);
        return "view-exams-questions"; // maps to /WEB-INF/view-exams-questions.jsp
    }




    // delete function -  delete exams

    @PostMapping("delete-exam")
    public String deleteExam(@RequestParam String examId) {
        boolean deleted = examService.deleteExam(examId);
        return "redirect:/exams/view-all"; // refresh the page
    }





//  Delete  questions  one by one



    @PostMapping("delete-question")
    public String deleteQuestion(
            @RequestParam String examId,
            @RequestParam String questionText
    ) {
        File inputFile = new File("data/questions.txt");
        File tempFile = new File("data/questions_temp.txt");

        try (
                BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 3);
                if (parts.length > 2) {
                    String id = parts[0];
                    String qText = parts[1];
                    if (!(id.equals(examId) && qText.equalsIgnoreCase(questionText))) {
                        writer.write(line);
                        writer.newLine();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        inputFile.delete();
        tempFile.renameTo(inputFile);

        return "redirect:/exams/view-all"; // or your mapped view
    }





}


