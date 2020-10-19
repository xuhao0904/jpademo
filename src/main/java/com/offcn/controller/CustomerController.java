package com.offcn.controller;

import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.Connection;
import com.offcn.pojo.Customer;
import com.offcn.service.CustomerService;
import com.offcn.service.impl.CustomerServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Date;

@Controller
@RequestMapping("/cust")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @RequestMapping("/{path}")
  public String custCon(@PathVariable("path")String path ){

        return "customer/customer-"+path;
    }

    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Customer> findByPage(@RequestParam(value = "pagenum",defaultValue = "1")int pagenum,
                                         @RequestParam(value = "pagesize",defaultValue ="5" )int pagesize,String ctype,String keyword,String orderby){
        System.out.println(orderby);
        PageInfo<Customer> byPage = customerService.findByPage(pagenum, pagesize,ctype,keyword,orderby);


        return  byPage;

    }
    @RequestMapping("/edit")
    public ModelAndView custCon(int id ) {
       Customer customer=  customerService.findOne(id);
      ModelAndView modelAndView=new ModelAndView();
       modelAndView.addObject("customer",customer);

        modelAndView.setViewName("customer/customer-edit");
        return modelAndView;
    }
    @RequestMapping("/update")
    public String updataCustomer( Customer customer ) {
        customerService.updataCostomer(customer);
        return "customer/customer-list";
    }
    @RequestMapping("/addCustomer")
    public String addCustomer( Customer customer ) {
        Date date=new Date();
        customer.setAddtime(date);
        customerService.addCostomer(customer);
        return "customer/customer-list";
    }
    @RequestMapping("/delete")
    @ResponseBody
    public  String addCustomer(HttpServletRequest req) {
        String[] cids = req.getParameterValues("cid");
        if(cids!=null){
        for(int i=0;i<cids.length;i++){
            int cid =Integer.parseInt(cids[i]);
            customerService.delete(cid);
        }
        }

        return "s";
    }


}
