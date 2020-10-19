package com.offcn.controller;


import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Task;
import com.offcn.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@RequestMapping("/task")
@Controller
public class TaskController {
@Autowired
private TaskService taskService;

    @RequestMapping("/{path}")
    public String task(@PathVariable("path")String path){
      return "task/"+path;
    }

    @RequestMapping("/page")
    public PageInfo<Task> findByPage(@RequestParam(value = "pagenum",defaultValue = "1")int pagenum, @RequestParam(value = "pagesize",defaultValue = "5") int pagesize){
        if(pagenum<1){
            pagenum=1;
        }
        return taskService.findByPage(pagenum,pagesize);

    }

}
