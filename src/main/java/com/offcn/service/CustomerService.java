package com.offcn.service;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Customer;

import java.util.List;

public interface  CustomerService {
   PageInfo<Customer> findByPage(int pagenum,int pagesize,String ctype,String keyword,String orderby);

   Customer findOne(int id);

   void updataCostomer(Customer customer);

   void addCostomer(Customer customer);

   void delete(int cid);
   List<Customer> findAll();
   void  deleteTest();
}
