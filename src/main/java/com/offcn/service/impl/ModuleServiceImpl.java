package com.offcn.service.impl;

import com.offcn.mapper.ModuleMapper;
import com.offcn.pojo.Module;
import com.offcn.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModuleServiceImpl implements ModuleService {
    @Autowired
    private ModuleMapper moduleMapper;

    @Override
    public List<Module> findMoudleByProject(String proname) {
        return moduleMapper.findMoudleByProject( proname);
    }
}
