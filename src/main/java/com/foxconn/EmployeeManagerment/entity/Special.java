package com.foxconn.EmployeeManagerment.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Special {
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
