package com.offcn.controller;


import com.offcn.pojo.Function;
import com.offcn.service.FunctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/function")
@Controller
public class FucntionController {

        @Autowired
    private FunctionService functionService;

        @RequestMapping("/find")
        @ResponseBody
        public List<Function> findFunction(){
           return functionService.findFunction();
        }

}
