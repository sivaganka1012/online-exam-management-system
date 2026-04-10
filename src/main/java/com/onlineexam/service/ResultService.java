package com.onlineexam.service;


import com.onlineexam.model.Question;
import com.onlineexam.model.Result;

import java.io.*;
import java.util.*;

public class ResultService {


    private static final String RESPONSE_FILE = "data/responses.txt";
    private static final String RESULTS_FILE = "data/results.txt";
    private ExamService examService = new ExamService();

    // Build Linked List of Result objects from responses.txt
    public List<Result> evaluateResults() {
        Map<String, Map<Integer, Integer>> userAnswers = new HashMap<>();
        Map<String, List<Question>> examQuestions = new HashMap<>();

        try (BufferedReader br = new BufferedReader(new FileReader(RESPONSE_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    String username = parts[0];
                    String examId = parts[1];
                    int qIndex = Integer.parseInt(parts[2]);
                    int answer = Integer.parseInt(parts[3]);

                    String key = username + "-" + examId;

                    // ✅ Keep only one answer per question index per user (latest answer overwrites)
                    userAnswers.putIfAbsent(key, new HashMap<>());
                    userAnswers.get(key).put(qIndex, answer);

                    if (!examQuestions.containsKey(examId)) {
                        examQuestions.put(examId, examService.getQuestionsByExamId(examId));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        List<Result> results = new LinkedList<>();
        for (String key : userAnswers.keySet()) {
            String[] parts = key.split("-");
            String username = parts[0];
            String examId = parts[1];
            List<Question> questions = examQuestions.get(examId);
            Map<Integer, Integer> answerMap = userAnswers.get(key);

            int correct = 0;
            for (Map.Entry<Integer, Integer> entry : answerMap.entrySet()) {
                int qIndex = entry.getKey();
                int ans = entry.getValue();
                if (qIndex < questions.size() && questions.get(qIndex).getCorrectIndex() == ans) {
                    correct++;
                }
            }

            Result r = new Result(username, examId, questions.size(), correct);
            results.add(r);
        }
        System.out.println("✅ Evaluation complete. Results count = " + results.size());

        return results;
    }

    // Save to results.txt
    public void saveResultsToFile(List<Result> results) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RESULTS_FILE))) {
            for (Result r : results) {
                bw.write(r.getUsername() + "," + r.getExamId() + "," + r.getTotalQuestions() + "," + r.getCorrectAnswers());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Load results from file
    public List<Result> loadResultsFromFile() {
        List<Result> results = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(RESULTS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    String username = parts[0];
                    String examId = parts[1];
                    int total = Integer.parseInt(parts[2]);
                    int correct = Integer.parseInt(parts[3]);
                    results.add(new Result(username, examId, total, correct));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
       // results.sort((r1, r2) -> Integer.compare(r2.getScorePercentage(), r1.getScorePercentage()));

        sortResults(results); // ✅ Selection sort instead of built-in


        return results;
    }
    public List<Result> getResultsByUsername(String username) {
        List<Result> userResults = new ArrayList<>();
        System.out.println("Searching results for username: " + username);
        try {
            for (Result result : loadResultsFromFile()) {
                System.out.println("Checking result for username: " + result.getUsername());
                if (result.getUsername().trim().equals(username.trim())) {
                    userResults.add(result);
                }
            }
            System.out.println("Found " + userResults.size() + " matching results");
        } catch (Exception e) {
            System.out.println("Error in getResultsByUsername: " + e.getMessage());
            e.printStackTrace();
        }
        return userResults;
    }

    // Selection sort by score %
    public void sortResults(List<Result> results) {
        for (int i = 0; i < results.size() - 1; i++) {
            int maxIdx = i;
            for (int j = i + 1; j < results.size(); j++) {
                if (results.get(j).getScorePercentage() > results.get(maxIdx).getScorePercentage()) {
                    maxIdx = j;
                }
            }
            Result temp = results.get(i);
            results.set(i, results.get(maxIdx));
            results.set(maxIdx, temp);
        }
    }







    // link list use - top 3 rank


    public List<Result> getTop3Results() {
        List<Result> results = evaluateResults(); // This already returns LinkedList
        sortResults(results); // Selection sort
        return results.subList(0, Math.min(3, results.size()));
    }















}

