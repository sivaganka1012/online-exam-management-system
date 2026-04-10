package com.onlineexam.model;

public class Result extends ResultBase {
    private int totalQuestions;
    private int correctAnswers;

    public Result(String studentId, String examId, int totalQuestions, int correctAnswers) {
        super(studentId, examId);  // Call parent constructor
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
    }

    public int getTotalQuestions() { return totalQuestions; }
    public int getCorrectAnswers() { return correctAnswers; }

    public int getScorePercentage() {
        if (totalQuestions == 0) return 0;
        return (int)(((double)correctAnswers / totalQuestions) * 100);
    }

    // Override parent's getExamId to maintain backward compatibility
    @Override
    public String getExamId() {
        return super.getExamId();
    }

    // Add getter for studentId to maintain backward compatibility
    public String getUsername() {
        return getStudentId();
    }
}
