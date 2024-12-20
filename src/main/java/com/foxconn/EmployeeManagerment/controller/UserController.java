package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.User;
import com.foxconn.EmployeeManagerment.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private final UserService userService;
    public UserController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping("/random")
    private List<User> getRandom(){
        return userService.getUser();
    }
}
