package com.onlineexam.controller;




import com.onlineexam.model.Result;
import com.onlineexam.service.ResultService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
@Controller
public class ResultController {


    private ResultService resultService = new ResultService();

    // Handle result viewing and ranking


    @GetMapping("/top-ranks")
    public String showTopRanks(HttpServletRequest request) {
        List<Result> topResults = resultService.getTop3Results();
        request.setAttribute("topResults", topResults);
        return "top-ranks"; // maps to /WEB-INF/top-ranks.jsp
    }




}

