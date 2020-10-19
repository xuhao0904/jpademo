package com.offcn.mapper;

import com.offcn.pojo.Baoxiao;
import com.offcn.pojo.BaoxiaoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BaoxiaoMapper {
    long countByExample(BaoxiaoExample example);

    int deleteByExample(BaoxiaoExample example);

    int deleteByPrimaryKey(String bxid);

    int insert(Baoxiao record);

    int insertSelective(Baoxiao record);

    List<Baoxiao> selectByExample(BaoxiaoExample example);

    Baoxiao selectByPrimaryKey(String bxid);

    int updateByExampleSelective(@Param("record") Baoxiao record, @Param("example") BaoxiaoExample example);

    int updateByExample(@Param("record") Baoxiao record, @Param("example") BaoxiaoExample example);

    int updateByPrimaryKeySelective(Baoxiao record);

    int updateByPrimaryKey(Baoxiao record);

    List<Baoxiao> findMybaoxiaopage(int id);

    List<Baoxiao> findBaoxiaoByStatus(int status);
}