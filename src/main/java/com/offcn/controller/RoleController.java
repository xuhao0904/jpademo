package com.offcn.controller;


import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Role;
import com.offcn.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;
    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Role> findByPage(@RequestParam(value = "pagenum", defaultValue = "1")int pagenum, @RequestParam(defaultValue = "5") int pagesize){
        if(pagenum<1){
            pagenum=1;
        }
        return   roleService.findByPage(pagenum,pagesize);
    }

    @RequestMapping("/findRoleById")
    @ResponseBody
    public Role findRoleById(int roleid){
     return    roleService.findRoleById(roleid);
    }

}
