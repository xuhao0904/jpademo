package com.offcn.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@RequestMapping("/xh")
@Controller
public class                                                                                                                                                                                HelloController {


    @RequestMapping("/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request, String name) throws IOException {
        String path=request.getSession().getServletContext().getRealPath("/download");

        //获取要下载的文件
        File f=new File(path+"\\"+name);

        //处理附件框的文件乱码
        byte[] bytes = name.getBytes("utf-8");
        name=new String(bytes,"iso8859-1");

        HttpHeaders httpHeaders=new HttpHeaders();
        //附件框
        httpHeaders.setContentDispositionFormData("attachment",name);

        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(f),httpHeaders, HttpStatus.OK);
    }
    @RequestMapping("/findAll")
    public String findAll( Model model){

        /*List<Account> all = accountService.findAll();
        model.addAttribute("list",all);
        return "redirect:/xh/find";

         */
        return  null;
    }
    @RequestMapping("/find")
    public String find(Model model){
        return "forward:/index.jsp";
    }
}
