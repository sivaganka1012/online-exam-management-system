package com.onlineexam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    // ✅ User pages
    @GetMapping("/")
    public String showLoginPage() {
        return "login"; // maps to /WEB-INF/login.jsp
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // maps to /WEB-INF/register.jsp
    }

    @GetMapping("/dashboard")
    public String showDashboardPage() {
        return "dashboard"; // maps to /WEB-INF/dashboard.jsp
    }

    @GetMapping("/logout")
    public String logoutPage() {
        return "logout"; // optional — usually logic is inside logout.jsp
    }

    // ✅ Exam pages
    @GetMapping("/create-exam")
    public String showCreateExamForm() {
        return "create-exam"; // maps to /WEB-INF/create-exam.jsp
    }

    @GetMapping("/add-question")
    public String showAddQuestionForm() {
        return "add-question"; // maps to /WEB-INF/add-question.jsp
    }

    @GetMapping("/create-success")
    public String showCreateSuccessPage() {
        return "create-success"; // maps to /WEB-INF/create-success.jsp
    }

    @GetMapping("/view-exams")
    public String showViewExamsPage() {
        return "view-exams-questions"; // maps to /WEB-INF/view-exams-questions.jsp
    }

    @GetMapping("/profile")
    public String showProfilePage() {
        return "profile"; // optional — maps to /WEB-INF/profile.jsp
    }





    @GetMapping("/take-exam")
    public String showTakeExamPage() {
        return "take-exam"; // maps to /WEB-INF/take-exam.jsp
    }




    @GetMapping("/thank-you")
    public String thankYou() {
        return "thank-you";  // maps to /WEB-INF/thank-you.jsp
    }

    @GetMapping("/result")
    public String showResultPage() {
        return "result";  // maps to /WEB-INF/result.jsp
    }




    @GetMapping("/rank-list")
    public String showRankList() {
        return "rankList"; // maps to /WEB-INF/rankList.jsp
    }



    @GetMapping("/add-teacher")
    public String showAddTeacherForm() {
        return "add-teacher"; // maps to /WEB-INF/add-teacher.jsp
    }


    @GetMapping("/add-student")
    public String showAddStudentForm() {
        return "add-student";
    }


    @GetMapping("/add-admin")
    public String showAddAdminPage() {
        return "add-admin"; // maps to /WEB-INF/add-admin.jsp
    }

    @GetMapping("/users/view-resultst")
    public String showViewResultsPage() {
        return "view-results"; // optional — maps to /WEB-INF/profile.jsp}
    }
    @Controller
    public class CustomErrorController implements org.springframework.boot.web.servlet.error.ErrorController {

        @RequestMapping("/error")
        public String handleError() {
            return "error"; // maps to /WEB-INF/error.jsp
        }
    }
}

