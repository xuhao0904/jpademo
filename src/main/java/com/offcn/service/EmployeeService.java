package com.offcn.service;

import com.offcn.pojo.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> findEmployeeByname(String name);
    Employee  findEmployeeByUsernameAndPassword(String username,String password);
    List<Employee> findAllEmployee(int eid);

    Employee findByUsername(String username);
}
