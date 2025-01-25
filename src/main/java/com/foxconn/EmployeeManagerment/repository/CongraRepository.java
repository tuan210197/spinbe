package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.Congra;
import com.foxconn.EmployeeManagerment.entity.Third;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CongraRepository extends JpaRepository<Congra, Long> {

    @Query(value = "select * from sp.show_congra(:num) limit 1", nativeQuery = true)
    Congra callCongra(@Param("num") int num);
    @Query(value = "select * from sp.list_chosen()", nativeQuery = true)
    List<String> getListChosen();
    @Query(value = "select * from sp.list_number()", nativeQuery = true)
    List<String> getListNumber();
}
