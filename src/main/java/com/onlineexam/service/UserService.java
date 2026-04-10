package com.onlineexam.service;

import com.onlineexam.model.User;
import java.io.*;
import java.util.*;

public class UserService {
    private final String USER_FILE = "data/users.txt";

    public void saveUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE, true))) {
            writer.write(user.getUserId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public User findUser(String username, String password) {
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && parts[1].equals(username) && parts[2].equals(password)) {
                    return new User(parts[0], parts[1], parts[2], parts[3]);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    String id = parts[0];
                    String username = parts[1];
                    String password = parts[2];
                    String role = parts[3];
                    userList.add(new User(id, username, password, role));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public void saveAllUsers(List<User> users) {
        try (PrintWriter writer = new PrintWriter(USER_FILE)) {
            for (User u : users) {
                writer.println(u.getUserId() + "," + u.getUsername() + "," + u.getPassword() + "," + u.getRole());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean updateUser(User updatedUser) {
        File file = new File(USER_FILE);
        List<String> lines = new ArrayList<>();
        boolean found = false;
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && parts[0].equals(updatedUser.getUserId())) {
                    String newLine = updatedUser.getUserId() + "," +
                            updatedUser.getUsername() + "," +
                            updatedUser.getPassword() + "," +
                            updatedUser.getRole();
                    lines.add(newLine);
                    found = true;
                } else {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (found) {
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, false))) {
                for (String l : lines) {
                    bw.write(l);
                    bw.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public User findUserByUsername(String username) {
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && parts[1].equals(username)) {
                    return new User(parts[0], parts[1], parts[2], parts[3]);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteUserById(String id) {
        List<User> userList = getAllUsers();
        boolean removed = userList.removeIf(u -> u.getUserId().equals(id));
        if (removed) {
            saveAllUsers(userList);
        }
        return removed;
    }

    public boolean isUsernameExists(String username) {
        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && parts[1].equals(username)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // New method to generate auto-incremented user ID
    public String generateUserId() {
        List<User> users = getAllUsers();
        int maxId = 0;
        for (User user : users) {
            try {
                int idNum = Integer.parseInt(user.getUserId().replace("USER", ""));
                maxId = Math.max(maxId, idNum);
            } catch (NumberFormatException ignored) {}
        }
        return "USER" + (maxId + 1);
    }
}