package com.onlineexam.controller;





import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;




import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import java.io.BufferedWriter;
import java.io.FileWriter;



import com.onlineexam.model.Question;
import com.onlineexam.service.ExamService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;


import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

@Controller
public class ExamParticipationController {

    private ExamService examService = new ExamService();

    @GetMapping("/take-question")
    public String showQuestionPage(
            @RequestParam String examId,
            @RequestParam(defaultValue = "0") int qIndex,
            HttpServletRequest request
    ) {
        List<Question> questions = examService.getQuestionsByExamId(examId);

        if (questions == null || questions.size() == 0 || qIndex >= questions.size()) {
            return "redirect:/thank-you";
        }

        Question question = questions.get(qIndex);
        request.setAttribute("examId", examId);
        request.setAttribute("qIndex", qIndex);
        request.setAttribute("question", question);
        request.setAttribute("total", questions.size());

        return "take-question"; // JSP inside /WEB-INF/
    }





















    @PostMapping("/submit-answer")
    public void submitAnswer(
            @RequestParam String username,
            @RequestParam String examId,
            @RequestParam int qIndex,
            @RequestParam int answer,
            HttpServletResponse response
    ) throws IOException {
        System.out.println("✅ SubmitAnswer triggered");


        File file = new File("data/responses.txt");
        List<String> updatedLines = new ArrayList<>();

// ✅ Step 1: Keep all lines except duplicate for same user+exam+question
        if (file.exists()) {
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 4) {
                        String existingUsername = parts[0];
                        String existingExamId = parts[1];
                        int existingQIndex = Integer.parseInt(parts[2]);

                        // ✅ Keep only if it's not the same user+exam+question
                        if (!(existingUsername.equals(username) &&
                                existingExamId.equals(examId) &&
                                existingQIndex == qIndex)) {
                            updatedLines.add(line);
                        }
                    }
                }
            }
        }

// ✅ Step 2: Add current new answer
        updatedLines.add(username + "," + examId + "," + qIndex + "," + answer);

// ✅ Step 3: Rewrite responses.txt file
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
            for (String line : updatedLines) {
                bw.write(line);
                bw.newLine();
            }
        }

// ✅ Step 4: Check if this was the last question
        List<Question> questions = examService.getQuestionsByExamId(examId);

        if (qIndex + 1 >= questions.size()) {
            int score = 0;

            // ✅ Step 5: Recalculate score from updated responses
            for (String line : updatedLines) {
                String[] parts = line.split(",");
                if (parts.length == 4 &&
                        parts[0].equals(username) &&
                        parts[1].equals(examId)) {

                    int answeredQIndex = Integer.parseInt(parts[2]);
                    int submittedAnswer = Integer.parseInt(parts[3]);

                    if (answeredQIndex < questions.size() &&
                            questions.get(answeredQIndex).getCorrectIndex() == submittedAnswer) {
                        score++;
                    }
                }
            }

            // ✅ Step 6: Save result
            try (BufferedWriter writer = new BufferedWriter(new FileWriter("data/results.txt", true))) {
                writer.write(username + "," + examId + "," + questions.size() + "," + score);
                writer.newLine();
            }

            // ✅ Step 7: Redirect to thank-you
            response.sendRedirect("/thank-you?username=" + username +
                    "&examId=" + examId + "&score=" + score + "&total=" + questions.size());
        } else {
            // ✅ Move to next question
            response.sendRedirect("/take-question?examId=" + examId + "&qIndex=" + (qIndex + 1));
        }
    }













    }
