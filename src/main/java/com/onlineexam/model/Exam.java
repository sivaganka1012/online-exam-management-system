package com.onlineexam.model;

import java.util.ArrayList;
import java.util.List;

public class Exam extends Activity {
    private List<Question> questions;

    public Exam(String examId, String title) {
        super(examId, title);
        this.questions = new ArrayList<>();
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void addQuestion(Question question) {
        this.questions.add(question);
    }

    // ✅ These help existing code stay the same
    public String getExamId() {
        return id;
    }

    public void setExamId(String examId) {
        this.id = examId;
    }

    @Override
    public String getTitle() {
        return super.getTitle();
    }
}
