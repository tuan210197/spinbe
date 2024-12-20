package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.repository.SpecialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class SpecialService {

    @Autowired
    private SpecialRepository repository;

    public Special getSpecialData() {
        return repository.callSpecial();
    }
    public List<Special> getList(){
        return repository.findAll();
    }
    public void delete(String code, String bu){

        try {
            repository.deleteSpecial(code, bu);
            ResponseEntity.noContent().build();

        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
