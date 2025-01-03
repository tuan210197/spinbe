package com.foxconn.EmployeeManagerment.service;

import com.foxconn.EmployeeManagerment.entity.Special;
import com.foxconn.EmployeeManagerment.repository.SpecialRepository;
import io.jsonwebtoken.lang.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class SpecialService {

    @Autowired
    private SpecialRepository repository;

    public Special getSpecialData() {
        return repository.callSpecial();
    }
    public List<Special> getList(){
        return repository.findAll(Sort.by(Sort.Direction.DESC, "receive"));
//        Sort.by(Sort.Direction.DESC, "receive")
//    return repository.lastPerson();
    }
    public List<Special> getListReload() {
        return repository.lastPerson();
    }
    public void delete(String code, String bu){

        try {
            repository.deleteSpecial(code, bu);
            ResponseEntity.noContent().build();

        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
   public boolean updatePrize(String code){
        Special special1 = repository.findByCode(code);
        Assert.notNull(special1, "CODE NOT FOUND");
        if(special1.getReceive() == 1){
           special1.setReceive(0);
           repository.save(special1);
           repository.deleteSpecialPrize(special1.getBu());
            return true;
        }
        else return false;
    }


}
