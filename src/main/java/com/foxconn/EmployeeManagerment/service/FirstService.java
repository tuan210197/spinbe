package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.repository.FirstRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FirstService {
    @Autowired
    private FirstRepository firstRepository;


    public First getFirst() {

        return firstRepository.callFirst();

    }

    public List<First> getList() {
        return firstRepository.findAll();
    }
    public void delete(String code, String bu){

        try {
            firstRepository.deleteFirst(code, bu);
            ResponseEntity.noContent().build();

        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
