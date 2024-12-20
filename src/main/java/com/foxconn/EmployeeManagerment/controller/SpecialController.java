package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/special")
public class SpecialController {

    @Autowired
    private SpecialService specialService;

    @GetMapping("/get")
    public Special getSpecials() {
        return specialService.getSpecialData();
    }

    @GetMapping("list")
    public List<Special> getList(){
        return specialService.getList();
    }

    @PostMapping("/delete")
    public void deleteSecond(@RequestBody Special second ){
        specialService.delete(second.getCode(), second.getBu());
    }
}
