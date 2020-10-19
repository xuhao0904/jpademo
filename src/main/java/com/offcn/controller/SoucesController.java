package com.offcn.controller;


import com.offcn.MyEx.ResultInfo;
import com.offcn.pojo.Sources;
import com.offcn.service.SourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/sources")
@Controller
public class SoucesController {

    @Autowired
    private SourcesService sourcesService;
    @RequestMapping("/{path}")
    public String  forward(@PathVariable String path){
        return  "system/"+path;
    }
    @RequestMapping("showAll")
    @ResponseBody
    public List<Sources> showAll(){
        return  sourcesService.findAll();
    }

   @RequestMapping("/add")
   @ResponseBody
   public ResultInfo addSource(Sources source){
        return  sourcesService.addSource(source);
   }

    @RequestMapping("/findOne")
    @ResponseBody
    public Sources  findOne(int id){
        return   sourcesService.findOne(id);
    }
    @RequestMapping("/update")
    @ResponseBody
    public ResultInfo  findOne(Sources sources){
        return   sourcesService.update(sources);
    }

}
