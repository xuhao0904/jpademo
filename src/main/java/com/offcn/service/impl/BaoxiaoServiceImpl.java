package com.offcn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.MyEx.ResultInfo;
import com.offcn.mapper.BaoxiaoMapper;
import com.offcn.pojo.Baoxiao;
import com.offcn.pojo.BaoxiaoExample;
import com.offcn.service.BaoxiaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BaoxiaoServiceImpl implements BaoxiaoService {
    @Autowired
    private BaoxiaoMapper baoxiaoMapper;

    @Override
    public Baoxiao myupdataById(String bxid) {
        return baoxiaoMapper.selectByPrimaryKey(bxid);
    }

    @Override
    public ResultInfo insert(Baoxiao baoxiao) {
        int insert = baoxiaoMapper.insert(baoxiao);
        ResultInfo resultInfo=new ResultInfo();
        if(insert==1){
            resultInfo.setFlag(true);
            resultInfo.setMessages("操作成功");
        }else{
            resultInfo.setMessages("操作失败");
            resultInfo.setFlag(false);

        }
        return resultInfo;
    }

    @Override
    public PageInfo<Baoxiao> findMybaoxiaopage(int pagenum, int pagesize,int id) {
        PageHelper.startPage(pagenum,pagesize);
        List<Baoxiao> mybaoxiaopage = baoxiaoMapper.findMybaoxiaopage(id);
        PageInfo<Baoxiao> pageInfo=new PageInfo<>(mybaoxiaopage);
        return  pageInfo;

    }

    @Override
    public ResultInfo updateMyBaoxiao(Baoxiao baoxiao) {
        int i = baoxiaoMapper.updateByPrimaryKeySelective(baoxiao);
        ResultInfo resultInfo=new ResultInfo();
        if(i==1){
            resultInfo.setFlag(true);
            resultInfo.setMessages("操作成功");
        }else{
            resultInfo.setFlag(false);
            resultInfo.setMessages("操作失败");
        }
        return  resultInfo;
    }

    @Override
    public PageInfo<Baoxiao> findBaoxiaoByStatus(int pagenum, int pagesize, int status) {
        PageHelper.startPage(pagenum,pagesize);
       List<Baoxiao> baoxiaos= baoxiaoMapper.findBaoxiaoByStatus(status);
       PageInfo<Baoxiao> pageInfo=new PageInfo<>(baoxiaos);
       return  pageInfo;
    }

    @Override
    public Baoxiao findBaoxiaoByBxid(String bxid) {
        Baoxiao baoxiao = baoxiaoMapper.selectByPrimaryKey(bxid);
        return baoxiao;
    }

    @Override
    public ResultInfo updateBaoxiao(Baoxiao baoxiao) {
        int i = baoxiaoMapper.updateByPrimaryKeySelective(baoxiao);
        ResultInfo resultInfo=new ResultInfo();
        if(i==1){
            resultInfo.setFlag(true);
            resultInfo.setMessages("操作成功");
        }else{
            resultInfo.setFlag(false);
            resultInfo.setMessages("操作失败");
        }
        return  resultInfo;
    }
}
