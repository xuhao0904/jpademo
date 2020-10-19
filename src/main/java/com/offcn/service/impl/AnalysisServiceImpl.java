package com.offcn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.AnalysisMapper;
import com.offcn.pojo.Analysis;
import com.offcn.service.AnalysisService;
import com.offcn.service.factory.MyJobFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalysisServiceImpl implements AnalysisService {
    @Autowired
    private AnalysisMapper analysisMapper;

    @Override
    public PageInfo findAnalysisBypage(int pagenum, int pagesize) {
        PageHelper.startPage(pagenum,pagesize);
        List<Analysis> analyses = analysisMapper.selectByExample(null);

        PageInfo<Analysis>pageInfo=new PageInfo<>(analyses);
        return  pageInfo;

    }

}
