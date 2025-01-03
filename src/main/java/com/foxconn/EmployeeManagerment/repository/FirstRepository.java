package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Special;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FirstRepository extends JpaRepository<First, String> {

    @Query(value = "select * from sp.choose_1()", nativeQuery = true)
    First callFirst();

    @Query(value = "call sp.on_delete1(:code, :bu)", nativeQuery = true)
    void deleteFirst(@Param("code") String code, @Param("bu") String bu);

    @Query(value = "SELECT u FROM First u WHERE u.code = :code")
   First findByCode(@Param("code") String code);

    @Query(value = "select * from sp.check_first()", nativeQuery = true)
    int checkFirst();

    @Transactional
    @Modifying
    @Query(value = "CALL sp.on_delete1(:bu)", nativeQuery = true)
    void deleteFirstPrize(@Param("bu") String bu);

    @Query(value = "select * from sp.first where receive = 1 ORDER BY id", nativeQuery = true)
    List<First> getListReload();
}
