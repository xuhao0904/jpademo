package com.offcn.service.impl;

import com.offcn.mapper.ArchivesMapper;
import com.offcn.pojo.Archives;
import com.offcn.service.ArchivesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArchivesServiceImpl implements ArchivesService {
    @Autowired
    private ArchivesMapper archivesMapper;


    @Override
    public List<Archives> finAll() {
        return  archivesMapper.findAll();
    }
}
