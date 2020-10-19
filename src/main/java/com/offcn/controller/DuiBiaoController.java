package com.offcn.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Datacollect;
import com.offcn.service.DuiBiaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/duibiao")
public class DuiBiaoController {
@Autowired
private DuiBiaoService duiBiaoService;

    @RequestMapping("/{path}")
    public String  forward(@PathVariable String path){
        return "duibiao/"+path;
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Datacollect> findByPage(@RequestParam(value="pagenum",defaultValue = "1")int pagenum,@RequestParam(value = "pagesize",defaultValue = "5")int pagesize){
        if(pagenum<1){
            pagenum=1;
        }
        return   duiBiaoService.findBypage(pagenum,pagesize);
    }
}
