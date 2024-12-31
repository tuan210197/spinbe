package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.entity.Third;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import com.foxconn.EmployeeManagerment.service.ThirdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/third")
public class ThirdController {

    @Autowired
    private ThirdService thirdService;

    @GetMapping("/get")
    public Third getSpecials() {
        return thirdService.getThird();
    }
    @GetMapping("/get-3a")
    public List<Third> getFourA(){
        return thirdService.getA();
    }

    @GetMapping("/get-3b")
    public List<Third> getFourB(){
        return thirdService.getB();
    }
    @PostMapping("/get-list")
    public List<Third> postFour(@RequestBody Third third){
        return thirdService.getList(third.getWorking_time());
    }
    @GetMapping("/check")
    public int checkThird(){
        return thirdService.check();
    }
}
