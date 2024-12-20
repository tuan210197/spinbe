package com.foxconn.EmployeeManagerment.repository;

import com.foxconn.EmployeeManagerment.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    @Query(value = "SELECT u.code, u.vn_name, u.bu, u.joins  FROM sp.user u order by random() limit 2500 ", nativeQuery = true)
    List<User> random();
}
