package com.offcn.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.DatacollectMapper;
import com.offcn.pojo.Datacollect;
import com.offcn.pojo.DatacollectExample;
import com.offcn.service.DuiBiaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DuiBiaoServiceImpl implements DuiBiaoService {
 @Autowired
 private DatacollectMapper datacollectMapper;

    @Override
    public PageInfo<Datacollect> findBypage(int pagenum, int pagesize) {
        PageHelper.startPage(pagenum,pagesize);
        List<Datacollect> byPageNeW = datacollectMapper.findByPageNeW();
        PageInfo<Datacollect> pageInfo=new PageInfo<>(byPageNeW);
        return  pageInfo;

    }
}
