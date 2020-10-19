package com.offcn.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/system")
public class SystemController {
    @RequestMapping("/{path}")
    public String  forward(@PathVariable String path){
        return  "system/"+path;
    }

}
