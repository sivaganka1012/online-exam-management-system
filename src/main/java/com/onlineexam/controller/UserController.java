package com.onlineexam.controller;

import com.onlineexam.model.User;
import com.onlineexam.service.ResultService;
import com.onlineexam.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/users")
public class UserController {

    private UserService UserService = new UserService();
    private ResultService ResultService = new ResultService();

    // Username validation: 3-20 characters, alphanumeric
    private boolean isValidUsername(String username) {
        return username != null && username.matches("^[a-zA-Z0-9]{3,20}$");
    }

    // Password validation: 8+ characters, 1 uppercase, 1 lowercase, 1 digit, 1 special char
    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 8 &&
                Pattern.compile("[A-Z]").matcher(password).find() &&
                Pattern.compile("[a-z]").matcher(password).find() &&
                Pattern.compile("[0-9]").matcher(password).find() &&
                Pattern.compile("[^a-zA-Z0-9]").matcher(password).find();
    }

    // Check if the logged-in user is an admin
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    // Handle registration
    @PostMapping("/register")
    public String register(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate username and password
        if (!isValidUsername(username)) {
            return "redirect:/register?error=invalid-username";
        }
        if (!isValidPassword(password)) {
            return "redirect:/register?error=invalid-password";
        }
        if (UserService.isUsernameExists(username)) {
            return "redirect:/register?error=username-exists";
        }
        if (!"student".equalsIgnoreCase(role)) { // Restrict registration to students
            return "redirect:/register?error=invalid-role";
        }

        String id = UserService.generateUserId();
        User user = new User(id, username, password, role);
        UserService.saveUser(user);

        return "redirect:/";
    }

    // Handle login
    @PostMapping("/login")
    public String login(HttpServletRequest request, HttpSession session) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("Attempting login for username: " + username);

        if (!isValidUsername(username) || !isValidPassword(password)) {
            return "redirect:/login?error=invalid-input";
        }

        User user = UserService.findUser(username, password);
        if (user != null) {
            System.out.println("Login successful for: " + user.getUsername());
            session.setAttribute("user", user);
            return "redirect:/dashboard";
        } else {
            System.out.println("Login failed for: " + username);
            return "redirect:/login?error=true";
        }
    }

    @PostMapping("/add-teacher")
    public String addTeacher(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String role,
            HttpSession session
    ) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=unauthorized";
        }
        if (!isValidUsername(username) || !isValidPassword(password)) {
            return "redirect:/dashboard?error=invalid-input";
        }
        if (UserService.isUsernameExists(username)) {
            return "redirect:/dashboard?error=username-exists";
        }
        if (!"teacher".equalsIgnoreCase(role)) {
            return "redirect:/dashboard?error=invalid-role";
        }

        String id = UserService.generateUserId();
        User user = new User(id, username, password, role);
        UserService.saveUser(user);
        return "redirect:/dashboard";
    }

    @GetMapping("/view-users")
    public String viewAllUsers(HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=unauthorized";
        }
        List<User> userList = UserService.getAllUsers();
        request.setAttribute("users", userList);
        return "view-users";
    }

    @GetMapping("/edit-user")
    public String showEditUserForm(@RequestParam String username, HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=unauthorized";
        }
        System.out.println("Edit user triggered for: " + username);
        User user = UserService.findUserByUsername(username);
        if (user != null) {
            request.setAttribute("user", user);
            return "edit-user";
        }
        return "redirect:/users/view-users?error=user-not-found";
    }

    @PostMapping("/update")
    public String updateUser(HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/users/view-users?error=unauthorized";
        }
        String id = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (!isValidUsername(username) || !isValidPassword(password)) {
            return "redirect:/users/view-users?error=invalid-input";
        }
        if (UserService.isUsernameExists(username) && !UserService.findUserByUsername(username).getUserId().equals(id)) {
            return "redirect:/users/view-users?error=username-exists";
        }
        if (!"student".equalsIgnoreCase(role) && !"teacher".equalsIgnoreCase(role) && !"admin".equalsIgnoreCase(role)) {
            return "redirect:/users/view-users?error=invalid-role";
        }

        User updatedUser = new User(id, username, password, role);
        boolean success = UserService.updateUser(updatedUser);
        if (!success) {
            return "redirect:/users/view-users?error=update-failed";
        }
        return "redirect:/users/view-users";
    }

    @PostMapping("/delete")
    public String deleteUser(HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/users/view-users?error=unauthorized";
        }
        String id = request.getParameter("userId");
        boolean success = UserService.deleteUserById(id);

        if (!success) {
            return "redirect:/users/view-users?error=delete-failed";
        }

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null && sessionUser.getUserId().equals(id)) {
            session.invalidate();
            return "redirect:/login";
        }
        return "redirect:/users/view-users";
    }

    @PostMapping("/add-student")
    public String addStudent(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session
    ) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=unauthorized";
        }
        String role = "student";
        if (!isValidUsername(username) || !isValidPassword(password)) {
            return "redirect:/dashboard?error=invalid-input";
        }
        if (UserService.isUsernameExists(username)) {
            return "redirect:/dashboard?error=username-exists";
        }

        String id = UserService.generateUserId();
        User user = new User(id, username, password, role);
        UserService.saveUser(user);
        return "redirect:/dashboard";
    }

    @PostMapping("/add-admin")
    public String addAdmin(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String role,
            HttpSession session
    ) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=unauthorized";
        }
        if (!isValidUsername(username) || !isValidPassword(password)) {
            return "redirect:/dashboard?error=invalid-input";
        }
        if (UserService.isUsernameExists(username)) {
            return "redirect:/dashboard?error=username-exists";
        }
        if (!"admin".equalsIgnoreCase(role)) {
            return "redirect:/dashboard?error=invalid-role";
        }

        String id = UserService.generateUserId();
        User user = new User(id, username, password, role);
        UserService.saveUser(user);
        return "redirect:/dashboard";
    }

    @GetMapping("/view-results")
    public String showViewResultsPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            System.out.println("No user session found, redirecting to login");
            return "redirect:/";
        }
        try {
            System.out.println("Fetching results for username: " + user.getUsername());
            List<com.onlineexam.model.Result> results = ResultService.getResultsByUsername(user.getUsername());
            System.out.println("Found " + results.size() + " results");
            model.addAttribute("results", results);
        } catch (Exception e) {
            System.out.println("Error loading results: " + e.getMessage());
            model.addAttribute("error", "Error loading results: " + e.getMessage());
            model.addAttribute("results", new ArrayList<>());
        }
        return "view-results";
    }
}