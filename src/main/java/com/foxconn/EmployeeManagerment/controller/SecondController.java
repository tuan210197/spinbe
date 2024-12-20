package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.SecondService;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/second")
public class SecondController {

    @Autowired
    private SecondService secondService;

    @GetMapping("/get")
    public Second getSecond() {
        return secondService.getSecond();
    }
    @GetMapping("/get-2a")
    public List<Second> getFourA(){
        return secondService.getA();
    }

    @GetMapping("/get-2b")
    public List<Second> getFourB(){
        return secondService.getB();
    }
    @PostMapping("/get-list")
    public List<Second> postFour(@RequestBody Second four){
        return secondService.getList(four.getWorking_time());
    }

    @PostMapping("/delete")
    public void deleteSecond(@RequestBody Second  second ){
         secondService.delete(second.getCode(), second.getBu());
    }
}
