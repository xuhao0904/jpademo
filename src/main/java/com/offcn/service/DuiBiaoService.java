package com.offcn.service;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Datacollect;

public interface DuiBiaoService {


    PageInfo<Datacollect> findBypage(int pagenum,int pagesize);
}
