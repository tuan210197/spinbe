package com.foxconn.EmployeeManagerment.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class User {

    @Id
    @Column
    private String code;
    @Column
    private String vn_name;
    @Column
    private String bu;
    @Column
    private String joins;

}
