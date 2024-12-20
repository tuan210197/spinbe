package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Four;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FourRepository extends JpaRepository<Four, String> {
    @Query(value = "select * from sp.choose_4()", nativeQuery = true)
    Four callFour();


    @Query(value = "select * from sp.choose_4a()", nativeQuery = true)
    Four callFourA();

    @Query(value = "select * from sp.choose_4b()", nativeQuery = true)
    Four callFourB();

    @Query(value = "select  code, vn_name,bu,working_time from sp.four where working_time = :working_time ORDER BY id desc", nativeQuery = true)
    List<Four> getListFour(@Param("working_time") String working_time);
}
