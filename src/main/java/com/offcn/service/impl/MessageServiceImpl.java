package com.offcn.service.impl;

import com.offcn.mapper.MsgMapper;
import com.offcn.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MsgMapper msgMapper;

}
