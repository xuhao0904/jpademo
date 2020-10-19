package com.offcn.service.impl;

import com.offcn.mapper.NoticeMapper;
import com.offcn.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeMapper noticeMapper;


}
