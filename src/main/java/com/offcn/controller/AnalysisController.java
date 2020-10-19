package com.offcn.controller;


import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Analysis;
import com.offcn.pojo.Project;
import com.offcn.service.AnalysisService;
import com.offcn.service.ProjectService;
import com.offcn.service.impl.AnalysisServiceImpl;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/analysis")
@Controller
public class AnalysisController {
    @Autowired
    private AnalysisService analysisService;
    @Autowired
    private ProjectService projectService;
    @RequestMapping("/{path}")
    public String  pathAnalysis(@PathVariable("path")String path){
        return  "project/project-need-"+path;
    }

    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Analysis> findAnalysisBypage(@RequestParam(value = "pagenum", defaultValue = "1")int pagenum, @RequestParam(defaultValue = "5") int pagesize){
        if(pagenum<1){
            pagenum=1;
        }
        PageInfo <Analysis>analysisBypage = analysisService.findAnalysisBypage(pagenum, pagesize);
        return  analysisBypage;
    }
    @ResponseBody
    @RequestMapping("/findProjectNoAna")
    public List<Project>  findProjectNoAna(){
        List<Project> projectNoAna = projectService.findProjectNoAna();
        return  projectNoAna;
    }

}
