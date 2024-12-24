package com.foxconn.EmployeeManagerment.controller;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.service.SpecialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/special")
public class SpecialController extends BaseController {

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
    public void deleteSecond(@RequestBody Special special ){
        specialService.delete(special.getCode(), special.getBu());
    }
    @PostMapping( "/update")
    public ResponseEntity<?> updatePrize(@RequestBody Special special){
     boolean check =   specialService.updatePrize(special.getCode());
     if(check){
         return toSuccessResult(null, "UPDATE SUCCESS");
     }
        return toExceptionResult(null, 400);
    }
}
