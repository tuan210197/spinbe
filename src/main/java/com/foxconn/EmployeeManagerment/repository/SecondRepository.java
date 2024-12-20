package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Third;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SecondRepository extends JpaRepository<Second, String> {

    @Query(value = "select * from sp.choose_2()", nativeQuery = true)
    Second callSecond();

    @Query(value = "select * from sp.choose_2a()", nativeQuery = true)
    Second callSecondA();

    @Query(value = "select * from sp.choose_2b()", nativeQuery = true)
    Second callSecondB();

    @Query(value = "select  code, vn_name,bu,working_time, joins from sp.second where working_time = :working_time ORDER BY id desc", nativeQuery = true)
    List<Second> getListSecond(@Param("working_time") String working_time);

    @Query(value = "call sp.on_delete(:code, :bu)", nativeQuery = true)
    void deleteSecond( @Param("code") String code, @Param("bu") String bu);
}
