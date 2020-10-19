package com.offcn.service.impl;

import com.offcn.mapper.EmployeeMapper;
import com.offcn.pojo.Employee;
import com.offcn.pojo.EmployeeExample;
import com.offcn.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;
    @Override
    public List<Employee> findEmployeeByname(String name) {
        List<Employee> empolyeeByName = employeeMapper.findEmpolyeeByName(name);
        return empolyeeByName;
    }

    @Override
    @Cacheable
    public Employee findEmployeeByUsernameAndPassword(String username, String password) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andUsernameEqualTo(username);
        criteria.andPasswordEqualTo(DigestUtils.md5DigestAsHex(password.getBytes()));
        List<Employee> employees = employeeMapper.selectByExample(employeeExample);
        if(employees!=null){
            return  employees.get(0);
        }
            return null;

    }

    @Override
    public List<Employee> findAllEmployee(int eid) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEidNotEqualTo(eid);

        return employeeMapper.selectByExample(employeeExample);
    }

    @Override
    public Employee findByUsername(String username) {
        return null;
    }


}
