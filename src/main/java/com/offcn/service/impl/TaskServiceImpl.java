package com.offcn.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.TaskMapper;
import com.offcn.pojo.Task;
import com.offcn.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskServiceImpl implements TaskService {
   @Autowired
    private TaskMapper taskMapper;


    @Override
    public PageInfo<Task> findByPage(int pagenum, int pagesize) {
        PageHelper.startPage(pagenum,pagesize);
        List<Task> tasks=taskMapper.selectByExample(null);
        PageInfo<Task> pageInfo=new PageInfo<>(tasks);
        return pageInfo;
    }
}
