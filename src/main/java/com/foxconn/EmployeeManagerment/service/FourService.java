package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.repository.FirstRepository;
import com.foxconn.EmployeeManagerment.repository.FourRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Slf4j
public class FourService {
    @Autowired
    private FourRepository repository;


    public Four getFour() {
        return repository.callFour();
    }

    public List<Four> getA() {
        List<Four> fourArrayList = new ArrayList<>();
            List<Four> actual = repository.findAll();

        for (int i = 0; i < 10; i++) {
            Four four = repository.callFourA();
                fourArrayList.add(four);

        }

        return fourArrayList;
    }

    public List<Four> getB() {
        List<Four> fourArrayList = new ArrayList<>();

        for (int i = 0; i < 10; i++) {
            Four four = repository.callFourB();
                fourArrayList.add(four);
        }
        return fourArrayList;
    }

    public List<Four> getList(String working_time) {
        return repository.getListFour(working_time);
    }
}
