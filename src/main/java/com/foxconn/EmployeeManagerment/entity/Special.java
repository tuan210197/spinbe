package com.foxconn.EmployeeManagerment.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Special {
    @Id
    private int id;
    @Column
    private String code;
    @Column
    private String vn_name;
    @Column
    private String bu;
    @Column
    private String joins;
    @Column
    private int receive;
}
