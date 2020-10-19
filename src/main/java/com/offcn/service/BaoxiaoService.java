package com.offcn.service;

import com.github.pagehelper.PageInfo;
import com.offcn.MyEx.ResultInfo;
import com.offcn.pojo.Baoxiao;

import java.util.List;

public interface BaoxiaoService {
    Baoxiao myupdataById(String bxid);


    ResultInfo insert(Baoxiao baoxiao);

    PageInfo<Baoxiao> findMybaoxiaopage(int pagenum, int pagesize, int id);

    ResultInfo updateMyBaoxiao(Baoxiao baoxiao);

    PageInfo<Baoxiao> findBaoxiaoByStatus(int pagenum, int pagesize, int status);

    Baoxiao findBaoxiaoByBxid(String bxid);

    ResultInfo updateBaoxiao(Baoxiao baoxiao);
}
