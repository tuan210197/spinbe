package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.SecondService;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/second")
public class SecondController extends  BaseController{

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
    public List<Second> postFour(@RequestBody Second second){
        return secondService.getList(second.getWorking_time());
    }
    @PostMapping("/get-list2")
    public List<Second> postFour2(@RequestBody Second second){
        return secondService.getList2(second.getWorking_time());
    }

    @PostMapping("/delete")
    public void deleteSecond(@RequestBody Second  second ){
         secondService.delete(second.getCode(), second.getBu());
    }

    @PostMapping( "/update")
    public ResponseEntity<?> updatePrize(@RequestBody Second second){
        boolean check =   secondService.updatePrize(second.getCode());
        if(check){
            return toSuccessResult(null, "UPDATE SUCCESS");
        }
        return toExceptionResult(null, 400);
    }
    @GetMapping("/check")
    public int checkSecond(){
        return secondService.check();
    }

    @PostMapping("/check-count")
    public int checkCount(@RequestBody Second second){
        return secondService.checkCountSecondA(second.getWorking_time(), second.getReceive());
    }
    @GetMapping("/count-second-a")
    public int countSecondA(){
        return secondService.countSeconda();
    }

    @GetMapping("/count-second-b")
    public int countSecondB(){
        return secondService.countSecondb();
    }
}
