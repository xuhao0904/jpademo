package com.offcn.service.factory;

import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.SpringBeanJobFactory;
import org.springframework.stereotype.Component;

/**
 *
 * 为了解决quartz不能实现由spring容器管理Job对象
 * author: xiaoming
 * createtime:2020-07-31 09:55
 **/
@Component
public class MyJobFactory extends SpringBeanJobFactory {
    @Autowired
    private AutowireCapableBeanFactory autowireCapableBeanFactory;

    @Override
    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
        //调用父类的方法
        Object jobInstance = super.createJobInstance(bundle);
        //进行注入:job对象就能被spring所管理
        autowireCapableBeanFactory.autowireBean(jobInstance);
        return jobInstance;
    }
}
