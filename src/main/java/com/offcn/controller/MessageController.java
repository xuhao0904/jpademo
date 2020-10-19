package com.offcn.controller;


import com.offcn.pojo.Employee;
import com.offcn.service.EmployeeService;
import com.offcn.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/message")
@Controller
public class MessageController {
    @Autowired
    private MessageService messageService;
    @Autowired
    private EmployeeService employeeService;
    @RequestMapping("/{path}")
    public String forwarid(@PathVariable String path){
        return "message/"+path;
    }


    @RequestMapping("/findAllEmp")
    @ResponseBody
    public List<Employee> findAllEmp(HttpSession session)
    {
        Employee activeUser = (Employee) session.getAttribute("activeUser");
        Integer eid = activeUser.getEid();
        return employeeService.findAllEmployee(eid);
    }

}
