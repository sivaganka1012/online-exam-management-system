package com.onlineexam.service;

import com.onlineexam.model.ManualResult;

import java.io.*;
import java.util.*;

public class ManualResultService {
    private static final String RESULT_FILE = "data/manual-results.txt";

    public void saveManualResult(ManualResult result) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RESULT_FILE, true))) {
            bw.write(result.getStudentId() + "," + result.getExamId() + "," +
                    result.getMcqMarks() + "," + result.getWrittenMarks() + "," +
                    result.getTotalMarks() + "," + result.getGrade());
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<ManualResult> getAllManualResults() {
        List<ManualResult> results = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(RESULT_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] p = line.split(",");
                if (p.length == 6) {
                    String studentId = p[0];
                    String examId = p[1];
                    int mcq = Integer.parseInt(p[2]);
                    int written = Integer.parseInt(p[3]);
                    results.add(new ManualResult(studentId, examId, mcq, written));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return results;
    }

    public int getMcqMarks(String studentId, String examId) {
        try (BufferedReader br = new BufferedReader(new FileReader("data/results.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] p = line.split(",");
                if (p.length == 4 && p[0].equals(studentId) && p[1].equals(examId)) {
                    return Integer.parseInt(p[3]); // score
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
