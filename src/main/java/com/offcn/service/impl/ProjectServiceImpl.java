package com.offcn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.ProjectMapper;
import com.offcn.pojo.Project;
import com.offcn.pojo.ProjectExample;
import com.offcn.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ProjectMapper  projectMapper;



    @Override
    public PageInfo<Project> findByRule(int pagenum, int pagesize, String ctype, String keyword, String orderby) {
        PageHelper.startPage(pagenum,pagesize);
        List<Project> projects=projectMapper.selectByRule(ctype,keyword,orderby);

        PageInfo<Project> page =new PageInfo<>(projects);
        return page;
    }

    @Override
    public List<Project> findProjectNoAna() {
        List<Project> projectNoAna = projectMapper.findProjectNoAna();
        return  projectNoAna;
    }
}
