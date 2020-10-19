package com.offcn.service;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Task;

import java.util.List;

public interface TaskService {
    PageInfo<Task> findByPage(int pagenum, int pagesize);
}
