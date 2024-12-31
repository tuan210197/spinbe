package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Four;
import com.foxconn.EmployeeManagerment.entity.Third;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ThirdRepository extends JpaRepository<Third, String> {

    @Query(value = "select * from sp.choose_3()", nativeQuery = true)
    Third callThird();

    @Query(value = "select * from sp.choose_3a()", nativeQuery = true)
    Third callThirdA();

    @Query(value = "select * from sp.choose_3b()", nativeQuery = true)
    Third callThirdB();

    @Query(value = "select  code, vn_name,bu,working_time from sp.third where working_time = :working_time ORDER BY id asc", nativeQuery = true)
    List<Third> getListThird(@Param("working_time") String working_time);

    @Query(value = "select * from sp.check_third()", nativeQuery = true)
    int checkThird();
}
