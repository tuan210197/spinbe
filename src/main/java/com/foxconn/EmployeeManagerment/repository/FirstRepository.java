package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Special;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FirstRepository extends JpaRepository<First, String> {

    @Query(value = "select * from sp.choose_1()", nativeQuery = true)
    First callFirst();

    @Query(value = "call sp.on_delete1(:code, :bu)", nativeQuery = true)
    void deleteFirst(@Param("code") String code, @Param("bu") String bu);

    @Query(value = "SELECT u FROM First u WHERE u.code = :code")
   First findByCode(@Param("code") String code);
}
