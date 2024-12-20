package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.User;
import com.foxconn.EmployeeManagerment.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    public List<User> getUser() {
        return userRepository.random();
    }
}
