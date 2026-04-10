package com.onlineexam.service;

import com.onlineexam.model.Exam;
import com.onlineexam.model.Question;

import com.onlineexam.model.Result;


import java.io.*;
import java.util.*;

public class ExamService {

    private static final String DATA_DIR = "data";
    private static final String EXAMS_FILE = DATA_DIR + "/exams.txt";
    private static final String QUESTIONS_FILE = DATA_DIR + "/questions.txt";

    public ExamService() {
        // Create data folder if it doesn't exist
        File folder = new File(DATA_DIR);
        if (!folder.exists()) {
            folder.mkdirs();
        }
    }

    // ✅ Save exam to file
    public void saveExam(Exam exam) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(EXAMS_FILE, true))) {
            writer.write(exam.getExamId() + "," + exam.getTitle());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ✅ Save question to file
    public void saveQuestion(String examId, Question question) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(QUESTIONS_FILE, true))) {
            writer.write(examId + "," +
                    question.getQuestionText() + "," +
                    question.getOptions()[0] + "," +
                    question.getOptions()[1] + "," +
                    question.getOptions()[2] + "," +
                    question.getOptions()[3] + "," +
                    question.getCorrectIndex());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ✅ Load all exams from file (no questions)
    public List<Exam> getAllExams() {
        List<Exam> exams = new ArrayList<>();
        File file = new File(EXAMS_FILE);
        if (!file.exists()) return exams;

        try (BufferedReader br = new BufferedReader(new FileReader(EXAMS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 2);
                if (parts.length == 2) {
                    String examId = parts[0].trim();
                    String title = parts[1].trim();
                    exams.add(new Exam(examId, title));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return exams;
    }

    // ✅ Load all exams with their questions (for view page)
    public Map<String, Exam> loadExamsWithQuestions() {
        Map<String, Exam> examMap = new LinkedHashMap<>();

        // Load exams
        try (BufferedReader br = new BufferedReader(new FileReader(EXAMS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 2);
                if (parts.length == 2) {
                    examMap.put(parts[0], new Exam(parts[0], parts[1]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Load questions and attach to exams
        try (BufferedReader br = new BufferedReader(new FileReader(QUESTIONS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 7);
                if (parts.length == 7 && examMap.containsKey(parts[0])) {
                    String examId = parts[0].trim();
                    String questionText = parts[1].trim();
                    String[] options = {
                            parts[2].trim(),
                            parts[3].trim(),
                            parts[4].trim(),
                            parts[5].trim()
                    };
                    int correctIndex = Integer.parseInt(parts[6].trim());

                    Question q = new Question(questionText, options, correctIndex);
                    examMap.get(examId).addQuestion(q);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return examMap;
    }





    public List<Question> getQuestionsByExamId(String examId) {
        List<Question> questionList = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(QUESTIONS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 7 && parts[0].equals(examId)) {
                    String questionText = parts[1];
                    String[] options = {parts[2], parts[3], parts[4], parts[5]};
                    int correct = Integer.parseInt(parts[6]);
                    Question q = new Question(questionText, options, correct);
                    questionList.add(q);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return questionList;
    }






    // delete function - delete exams

    public boolean deleteExam(String examId) {
        File examFile = new File("data/exams.txt");
        File questionFile = new File("data/questions.txt");
        List<String> newExams = new ArrayList<>();
        List<String> newQuestions = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(examFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.startsWith(examId + ",")) {
                    newExams.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(questionFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.startsWith(examId + ",")) {
                    newQuestions.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        try (PrintWriter pw = new PrintWriter("data/exams.txt")) {
            for (String l : newExams) pw.println(l);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (PrintWriter pw = new PrintWriter("data/questions.txt")) {
            for (String l : newQuestions) pw.println(l);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return true;
    }







    }
