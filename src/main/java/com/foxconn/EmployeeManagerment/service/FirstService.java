package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.repository.FirstRepository;
import io.jsonwebtoken.lang.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FirstService {
    @Autowired
    private FirstRepository firstRepository;


    public First getFirst() {

        return firstRepository.callFirst();

    }

    public List<First> getList() {
        return firstRepository.findAll(Sort.by(Sort.Direction.DESC, "receive"));
    }

    public List<First> getListReload() {
       return firstRepository.getListReload();
    }
    public void delete(String code, String bu){

        try {
            firstRepository.deleteFirst(code, bu);
            ResponseEntity.noContent().build();

        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public boolean updatePrize(String code){
        First first = firstRepository.findByCode(code);
        Assert.notNull(first, "CODE NOT FOUND");
        if(first.getReceive() == 1){
            first.setReceive(0);
            firstRepository.save(first);
            firstRepository.deleteFirstPrize(first.getBu());
            return true;
        }
        else return false;
    }

    public int checkFirst() {
        return firstRepository.checkFirst();
    }

    public int countFirst() {
        return firstRepository.countFirst();
    }
}
