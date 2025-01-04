package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.controller.SpecialController;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.repository.SecondRepository;
import io.jsonwebtoken.lang.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SecondService {
    @Autowired
    private SecondRepository repository;


    public Second getSecond() {
        return repository.callSecond();
    }
    public List<Second> getA() {
        List<Second> thirdArrayList = new ArrayList<>();
        List<Second> actual = repository.findAll();
            Second third = repository.callSecondA();
            thirdArrayList.add(third);
        return thirdArrayList;
    }
    public List<Second> getB() {
        List<Second> fourArrayList = new ArrayList<>();
            Second third = repository.callSecondB();
            fourArrayList.add(third);
        return fourArrayList;
    }

    public List<Second> getList(String working_time) {
        return repository.getListSecond(working_time);
    }
    public List<Second> getList2(String working_time) {
        return repository.getListSecond2(working_time);
    }

    public void delete(String code, String bu){

        try {
          repository.deleteSecond(code, bu);
            ResponseEntity.noContent().build();

        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    public boolean updatePrize(String code){
        Second second = repository.findByCode(code);
        Assert.notNull(second, "CODE NOT FOUND");
        if(second.getReceive() == 1){
            second.setReceive(0);
            repository.save(second);
            repository.deleteSecondPrize(second.getBu());
            return true;
        }
        else return false;
    }

    public int check() {
        return repository.checkSecond();
    }

    public int checkCountSecondA(String working_time ) {
        return repository.checkCountSecondA(working_time);
    }

    public int countSecond() {
        return  repository.countSecond();
    }
}
