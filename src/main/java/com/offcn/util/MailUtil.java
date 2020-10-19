package com.offcn.util;

import com.offcn.pojo.Email;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

/**
 * name:ssmdemo
 * author: xiaoming
 * createtime:2020-07-30 10:26
 **/
public class MailUtil {
    //spring_mail.xml中配置
    private JavaMailSenderImpl javaMailSender;

    //通过setter实现注入
    public void setJavaMailSender(JavaMailSenderImpl javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendEmail(Email email, String receiveMail, MultipartFile file) throws MessagingException {
        //封装邮件信息
        MimeMessage mimeMessage= javaMailSender.createMimeMessage();
        //设置可以发送有附件的邮件（构造器第二个参数为true）
        MimeMessageHelper mimeMessageHelper=new MimeMessageHelper(mimeMessage,true);
        //设置发件人
        mimeMessageHelper.setFrom(javaMailSender.getUsername());
        //设置收件人
        mimeMessageHelper.setTo(receiveMail);
        //设置标题
        mimeMessageHelper.setSubject(email.getTitle());
        //设置邮件的内容
        mimeMessageHelper.setText(email.getEmailcontent());
        //设置发送的附件
        mimeMessageHelper.addAttachment(file.getOriginalFilename(),file);
        //发送邮件
        javaMailSender.send(mimeMessage);
    }
}
