package com.offcn.controller;

import com.offcn.MyEx.ResultInfo;
import com.offcn.pojo.Employee;
import com.offcn.service.EmployeeService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("/login")
    public ResultInfo login(String username, String password, HttpSession session) {
        try {
            //通过SecurityManager对象进行调度,实现用户登录认证
            Subject subject = SecurityUtils.getSubject();
            //对登录的用户名与密码进行封装
            UsernamePasswordToken token = new UsernamePasswordToken(username, DigestUtils.md5DigestAsHex(password.getBytes()));
            //进行登录认证
            subject.login(token);
            //获取登录的用户
            Employee employee = (Employee) subject.getPrincipal();
            session.setAttribute("activeUser", employee);
            return new ResultInfo(true, "登陆成功");
        } catch (AuthenticationException e) {
            e.printStackTrace();
            return new ResultInfo(false, "账号或密码错误");
        }
    }
}