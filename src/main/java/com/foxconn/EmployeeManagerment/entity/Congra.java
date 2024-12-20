package com.foxconn.EmployeeManagerment.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Congra {

    @Id
    @Column
    private Long id;
    @Column
    private Long number;
    @Column
    private Long count;
}
