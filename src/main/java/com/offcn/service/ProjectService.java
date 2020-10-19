package com.offcn.service;

import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Project;

import java.util.List;

public interface ProjectService {
    PageInfo<Project> findByRule(int pagenum, int pagesize, String ctype, String keyword, String orderby);
    List<Project>  findProjectNoAna();
}
