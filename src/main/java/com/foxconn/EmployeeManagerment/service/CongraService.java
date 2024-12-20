package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.Congra;
import com.foxconn.EmployeeManagerment.repository.CongraRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CongraService {
    @Autowired
    private CongraRepository congraRepository;

    public Congra getCongra(int num) {
        return congraRepository.callCongra(num);
    }
    public List<Congra> getAll() {
        return congraRepository.findAll();
    }
}
