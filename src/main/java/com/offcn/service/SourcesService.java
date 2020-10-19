package com.offcn.service;

import com.offcn.MyEx.ResultInfo;
import com.offcn.pojo.Sources;

import java.util.List;
import java.util.Set;

public interface SourcesService {
    List<Sources> findAll();

    ResultInfo addSource(Sources source);

    Sources findOne(int id);

    ResultInfo update(Sources sources);

    Set<String> findByUsername(String username);
}
