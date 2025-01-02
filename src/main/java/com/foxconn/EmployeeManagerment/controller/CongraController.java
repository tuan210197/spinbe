package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.Congra;
import com.foxconn.EmployeeManagerment.service.CongraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/congra")
public class CongraController {

    @Autowired
    private CongraService congraService;

    @GetMapping("/get/{num}")
    public ResponseEntity<Congra> getCongra(@PathVariable int num) {
        Congra congra = congraService.getCongra(num);
        return ResponseEntity.ok(congra);
    }

    @GetMapping("/get-all")
    public List<Congra> getAll() {
        return   congraService.getAll();
    }


    @GetMapping("/list-chosen")
    public List<String> getAllByEmp() {
        return congraService.getListChosen();
    }
    @GetMapping ("/list-number")
    public List<String> getAllNumber(){
        return congraService.getListNumber();
    }

}