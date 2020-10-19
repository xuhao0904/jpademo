package com.offcn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.CustomerMapper;
import com.offcn.pojo.Customer;
import com.offcn.pojo.CustomerExample;
import com.offcn.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public PageInfo<Customer> findByPage(int pagenum, int pagesize,String ctype,String keyword,String orderby) {
        PageHelper.startPage(pagenum,pagesize);
        CustomerExample customerExample=new CustomerExample();
        CustomerExample.Criteria criteria = customerExample.createCriteria();
        if(!StringUtils.isEmpty(keyword)){
            if("comname".equals(ctype)){
                criteria.andComnameLike("%"+keyword+"%");
            }else if("companyperson".equals(ctype)){
                criteria.andCompanypersonLike("%"+keyword+"%");
            }
        }
        if("addtime".equals(orderby)){
            customerExample.setOrderByClause(orderby);
        }
        List<Customer> customers = customerMapper.selectByExample(customerExample);

        PageInfo<Customer> pageInfo=new PageInfo<>(customers);
        return pageInfo;
    }

    @Override
    public Customer findOne(int id) {
        Customer customer = customerMapper.selectByPrimaryKey(id);
        return customer;
    }

    @Override
    public void updataCostomer(Customer customer) {
        customerMapper.updateByPrimaryKeySelective(customer);
    }

    @Override
    public void addCostomer(Customer customer) {
        customerMapper.insertSelective(customer);
    }

    @Override
    public void delete(int cid) {
        customerMapper.deleteByPrimaryKey(cid);
    }

    @Override
    public List<Customer> findAll() {
        List<Customer> customers = customerMapper.selectByExample(null);
    return customers;
    }

    @Override
    public void deleteTest() {

            Customer customer = new Customer();
            customer.setId(27);
            customer.setAddtime(new Date());
            customer.setComname("sss");
            customerMapper.insert(customer);
            int i = 1 / 0;
            customerMapper.deleteByPrimaryKey(27);

    }

}
