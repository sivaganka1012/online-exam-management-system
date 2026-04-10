package com.onlineexam.utils;

import com.onlineexam.model.Question;
import com.onlineexam.service.ExamService;

import java.io.*;
import java.util.*;

public class ResultProcessor {

    public static int computeScore(String username, String examId) {
        List<Question> questions = new ExamService().getQuestionsByExamId(examId);
        int score = 0;

        try (BufferedReader br = new BufferedReader(new FileReader("data/responses.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(username) && parts[1].equals(examId)) {
                    int qIndex = Integer.parseInt(parts[2]);
                    int userAnswer = Integer.parseInt(parts[3]);
                    if (questions.get(qIndex).getCorrectIndex() == userAnswer) {
                        score++;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return score;
    }





    public static void saveResult(String username, String examId, int score, int total) {
        File file = new File("data/results.txt");
        List<String> updatedLines = new ArrayList<>();

        // Load existing results and remove duplicates
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.startsWith(username + "," + examId + ",")) {
                    updatedLines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

// Add new result
        updatedLines.add(username + "," + examId + "," + score + "," + total);

// Write updated list back to file
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
            for (String line : updatedLines) {
                bw.write(line);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    }

