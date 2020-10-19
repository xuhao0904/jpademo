package com.offcn.service.impl;

import com.offcn.mapper.FunctionMapper;
import com.offcn.pojo.Function;
import com.offcn.service.FunctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FunctionServiceImpl implements FunctionService {
    @Autowired
    private FunctionMapper functionMapper;
    @Override
    public List<Function> findFunction() {
      return   functionMapper.findFunction();
    }
}
