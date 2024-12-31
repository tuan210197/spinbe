package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Third;
import com.foxconn.EmployeeManagerment.repository.ThirdRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ThirdService {
    @Autowired
    private ThirdRepository repository;
    public Third getThird() {
        return repository.callThird();
    }
    public List<Third> getA() {
        List<Third> thirdArrayList = new ArrayList<>();
        List<Third> actual = repository.findAll();

        for (int i = 0; i < 10; i++) {
            Third third = repository.callThirdA();
            thirdArrayList.add(third);

        }

        return thirdArrayList;
    }

    public List<Third> getB() {
        List<Third> fourArrayList = new ArrayList<>();

        for (int i = 0; i < 10; i++) {
            Third third = repository.callThirdB();
            fourArrayList.add(third);
        }
        return fourArrayList;
    }

    public List<Third> getList(String working_time) {
        return repository.getListThird(working_time);
    }

    public int check() {
        return repository.checkThird();
    }
}
