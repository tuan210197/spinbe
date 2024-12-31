package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.FourService;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/four")
public class FourController {

    @Autowired
    private FourService fourService;

    @GetMapping("/get")
    public Four getFour() {
        return fourService.getFour();
    }
    @GetMapping("/get-4a")
    public List<Four> getFourA(){
        return fourService.getA();
    }

    @GetMapping("/get-4b")
    public List<Four> getFourB(){
        return fourService.getB();
    }
    @PostMapping("/get-list")
    public List<Four> postFour(@RequestBody  Four four){
        return fourService.getList(four.getWorking_time());
    }
    @GetMapping("/check")
    public int checkFour(){
        return fourService.check();
    }
}
