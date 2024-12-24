package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.Special;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SpecialRepository extends JpaRepository<Special,String> {
   @Query(value = "select * from sp.choose_special()", nativeQuery = true)
    Special callSpecial();

    @Query(value = "call sp.on_deletedb(:code, :bu)", nativeQuery = true)
    void deleteSpecial(@Param("code") String code, @Param("bu") String bu);

    @Query(value = "SELECT u FROM Special u WHERE u.code = :code")
    Special findByCode(@Param("code") String code);
}
