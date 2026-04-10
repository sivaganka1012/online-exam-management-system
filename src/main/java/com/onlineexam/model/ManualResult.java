package com.onlineexam.model;

public class ManualResult extends ResultBase {
    private int mcqMarks;
    private int writtenMarks;
    private int totalMarks;
    private String grade;

    public ManualResult(String studentId, String examId, int mcqMarks, int writtenMarks) {
        super(studentId, examId);
        this.mcqMarks = mcqMarks;
        this.writtenMarks = writtenMarks;
        this.totalMarks = mcqMarks + writtenMarks;
        this.grade = calculateGrade(this.totalMarks);
    }

    private String calculateGrade(int total) {
        if (total >= 90) return "A+";
        if (total >= 75) return "A";
        if (total >= 60) return "B";
        if (total >= 50) return "C";
        return "F";
    }

    public int getMcqMarks() { return mcqMarks; }
    public int getWrittenMarks() { return writtenMarks; }
    public int getTotalMarks() { return totalMarks; }
    public String getGrade() { return grade; }
}
