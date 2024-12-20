package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.FirstService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/first")
public class FirstController {

    @Autowired
    private FirstService firstService;

    @GetMapping("/get")
    public First getSpecials() {
        return firstService.getFirst();
    }
    @GetMapping("/list")
    public List<First> getList(){
        return  firstService.getList();
    }

    @PostMapping("/delete")
    public void deleteSecond(@RequestBody First second ){
        firstService.delete(second.getCode(), second.getBu());
    }
}
