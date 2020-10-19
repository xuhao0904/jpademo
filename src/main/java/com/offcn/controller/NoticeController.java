package com.offcn.controller;

import com.offcn.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/notice")
@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;
    @RequestMapping("/{path}")
    public String forward(@PathVariable String path){
        return  "notice/"+path;
    }
}
