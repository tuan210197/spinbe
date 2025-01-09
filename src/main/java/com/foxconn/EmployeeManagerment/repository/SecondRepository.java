package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.First;
import com.foxconn.EmployeeManagerment.entity.Second;
import com.foxconn.EmployeeManagerment.entity.Third;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
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

    @Query(value = "select id, code, vn_name,bu,working_time, joins, receive  from sp.second where working_time = :working_time ORDER BY id  desc", nativeQuery = true)
    List<Second> getListSecond(@Param("working_time") String working_time);

    @Query(value = "select id, code, vn_name,bu,working_time, joins, receive  from sp.second where working_time = :working_time " +
            "ORDER BY receive DESC, id DESC", nativeQuery = true)
    List<Second> getListSecond2(@Param("working_time") String working_time);

    @Query(value = "call sp.on_delete(:code, :bu)", nativeQuery = true)
    void deleteSecond( @Param("code") String code, @Param("bu") String bu);

    @Query(value = "SELECT u FROM Second u WHERE u.code = :code")
    Second findByCode(String code);

    @Query(value = "select * from sp.check_second()", nativeQuery = true)
    int checkSecond();

    @Transactional
    @Modifying
    @Query(value = "CALL sp.on_delete2(:bu)", nativeQuery = true)
    void deleteSecondPrize(@Param("bu") String bu);


    @Query(value = "Select count(s) from Second s where s.working_time = :working_time and s.receive = :receive")
    int checkCountSecondA(@Param("working_time") String working_time, @Param("receive") int receive);

    @Query(value = "Select count(s) from Second s where receive = 1 and s.working_time = 'A'")
    int countSeconda();

    @Query(value = "Select count(s) from Second s where receive = 1")
    int countSecondb();
}