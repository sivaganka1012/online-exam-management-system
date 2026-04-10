package com.onlineexam.model;

public class ResultBase {
    protected String studentId;
    protected String examId;

    public ResultBase(String studentId, String examId) {
        this.studentId = studentId;
        this.examId = examId;
    }

    public String getStudentId() { return studentId; }
    public String getExamId() { return examId; }
}
