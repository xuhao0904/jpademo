package com.offcn.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Customer;
import com.offcn.pojo.Employee;
import com.offcn.pojo.Project;
import com.offcn.service.CustomerService;
import com.offcn.service.EmployeeService;
import com.offcn.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/project")
@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/{path}")
    public String project(@PathVariable("path")String path)
    {
        return "project/project-"+path;
    }




    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Project> findByPage(@RequestParam(value = "pagenum",defaultValue = "1")int pagenum,
                                         @RequestParam(value = "pagesize",defaultValue ="5" )int pagesize, String ctype,
                                        String keyword, String orderby){
        if(pagenum<1){
            pagenum=1;
        }

        PageInfo<Project> pageInfo = projectService.findByRule(pagenum, pagesize, ctype, keyword, orderby);

        return pageInfo;

    }

    @RequestMapping("/addProject")
    @ResponseBody
    public Map<String, List> findByPage(String name){
        Map map=new HashMap();
        List<Customer> all = customerService.findAll();
        List<Employee> employee = employeeService.findEmployeeByname(name);
        map.put("customer",all);
        map.put("employee",employee);
        return map;

    }

}
