package com.offcn.controller;


import com.github.pagehelper.PageInfo;
import com.offcn.MyEx.ResultInfo;
import com.offcn.pojo.Baoxiao;
import com.offcn.pojo.Employee;
import com.offcn.service.BaoxiaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RequestMapping("/baoxiao")
@Controller
public class BaoxiaoController {
    @Autowired
    private BaoxiaoService baoxiaoService;


    @RequestMapping("/{path}")
    public String  forward(@PathVariable String path){
        return "baoxiao/"+path;
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResultInfo insert( Baoxiao baoxiao , HttpSession session){
        Employee acticeUser = (Employee) session.getAttribute("activeUser");
        baoxiao.setEmpFk(acticeUser.getEid());
        baoxiao.setBxstatus(0);
        baoxiao.setBxid(UUID.randomUUID().toString());
       return baoxiaoService.insert(baoxiao);
    }
    @RequestMapping("/mybaoxiaopage")
    @ResponseBody
    public PageInfo<Baoxiao> mybaoxiaopage(@RequestParam(value = "pagenum",defaultValue = "1")int pagenum,
                                           @RequestParam(value = "pagesize",defaultValue ="5" )int pagesize, HttpSession session){
        Employee acticeUser = (Employee) session.getAttribute("activeUser");
        return baoxiaoService.findMybaoxiaopage(pagenum,pagesize, acticeUser.getEid());

    }
    @RequestMapping(value = "/myupdate",method = RequestMethod.POST)
    public ResultInfo myupdate(Baoxiao baoxiao){

        return  baoxiaoService.updateMyBaoxiao(baoxiao);

    }
    @RequestMapping("/myupdate")
    public String myupdate(String  bxid, Model model){
        model.addAttribute("baoxiao", baoxiaoService.myupdataById(bxid));
        return "baoxiao/mybaoxiao-edit";

    }
    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Baoxiao>mybaoxiaopage(@RequestParam(value = "pagenum",defaultValue = "1")int pagenum,
                                           @RequestParam(value = "pagesize",defaultValue ="5" )int pagesize, int status){
     return    baoxiaoService.findBaoxiaoByStatus(pagenum,pagesize,status);

    }
    @RequestMapping("/update")
    public String  huixian(String bxid,Model model){
       model.addAttribute("baoxiao",baoxiaoService.findBaoxiaoByBxid(bxid)) ;
        return  "baoxiao/baoxiao-task-edit";
    }
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResultInfo  update(Baoxiao baoxiao,HttpSession session){
        Employee employee = (Employee)session.getAttribute("activeUser");
        if(employee!=null){
            baoxiao.setCaiwuFk(employee.getEid());
        }
        return baoxiaoService.updateBaoxiao(baoxiao);
    }
}
