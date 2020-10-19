package com.offcn.controller;


import com.offcn.pojo.Module;
import com.offcn.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/module")
public class ModuleController {
    @Autowired
    private ModuleService moduleService;
    @RequestMapping("/findMoudleByProject")
    @ResponseBody
    public List<Module> findMoudleByProject(String proname){
        return moduleService.findMoudleByProject(proname);
    }

}
