package com.offcn.controller;

import com.offcn.pojo.Archives;
import com.offcn.service.ArchivesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/archives")
@Controller
public class ArchivesController  {
    @Autowired
    private ArchivesService archivesService;
    @RequestMapping("/{path}")
    public String forward(@PathVariable String path){
        return "archives/"+path;
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<Archives> findAll(){
        return  archivesService.finAll();
    }
}
