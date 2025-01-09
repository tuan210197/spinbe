package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.Special;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SpecialRepository extends JpaRepository<Special,String> {
   @Query(value = "select * from sp.choose_special()", nativeQuery = true)
    Special callSpecial();

    @Query(value = "call sp.on_deletedb(:code, :bu)", nativeQuery = true)
    void deleteSpecial(@Param("code") String code, @Param("bu") String bu);

    @Query(value = "SELECT u FROM Special u WHERE u.code = :code")
    Special findByCode(@Param("code") String code);

    @Transactional
    @Modifying
    @Query(value = "CALL sp.on_deletedb(:bu)", nativeQuery = true)
    void deleteSpecialPrize(@Param("bu") String bu);

    @Query(value = "select * from sp.special where receive = 1 ORDER BY id", nativeQuery = true)
    List<Special> lastPerson();

    @Query(value = "SELECT COUNT(*) FROM sp.special s WHERE s.receive = 1", nativeQuery = true)
    int countSpecial();
    @Query(value = "select * from sp.special order by receive desc, id desc", nativeQuery = true)
    List<Special> findAllSpecial();
}
