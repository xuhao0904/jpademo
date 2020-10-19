package com.offcn.service;

import com.offcn.pojo.Module;

import java.util.List;

public interface ModuleService {
    List<Module> findMoudleByProject(String proname);
}
