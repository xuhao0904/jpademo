package com.offcn.service.impl;

import com.offcn.MyEx.ResultInfo;
import com.offcn.mapper.SourcesMapper;
import com.offcn.pojo.Sources;
import com.offcn.pojo.SourcesExample;
import com.offcn.service.SourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class SourcesServiceImpl implements SourcesService {
    @Autowired
    private SourcesMapper sourcesMapper;

    @Override
    public List<Sources> findAll() {
        return findAll(0);
    }

    @Override
    public ResultInfo addSource(Sources source) {
         int i= sourcesMapper.insert(source);
         ResultInfo resultInfo=new ResultInfo();
         if(i==1){
             resultInfo.setMessages("添加成功");
             resultInfo.setFlag(true);
         }else{
             resultInfo.setMessages("添加失败");
             resultInfo.setFlag(false);
        }
         return  resultInfo;
    }

    @Override
    public Sources findOne(int id) {
        Sources sources = sourcesMapper.selectByPrimaryKey(id);
        Integer pid = sources.getPid();
        Sources  parent = sourcesMapper.selectByPrimaryKey(pid);
        Integer pid1 = parent.getPid();
        SourcesExample sourcesExample=new SourcesExample();
        SourcesExample.Criteria criteria = sourcesExample.createCriteria();
        criteria.andPidEqualTo(pid1);
        List<Sources> sources1 = sourcesMapper.selectByExample(sourcesExample);
        sources.setChildren(sources1);
        return  sources;

    }

    @Override
    public ResultInfo update(Sources sources) {
        int i = sourcesMapper.updateByPrimaryKey(sources);
        ResultInfo resultInfo=new ResultInfo();
            if(i==1){
                resultInfo.setFlag(true);
            }else{
                resultInfo.setFlag(false);
            }
            return  resultInfo;
    }

    @Override
    public Set<String> findByUsername(String username) {
        return null;
    }


    public List<Sources> findAll(int id){
        SourcesExample sourcesExample=new SourcesExample();
        SourcesExample.Criteria criteria = sourcesExample.createCriteria();
        SourcesExample.Criteria criteria1 = criteria.andPidEqualTo(id);
        List<Sources> sources = sourcesMapper.selectByExample(sourcesExample);
        if(sources!=null &&sources.size()>0) {
            for (Sources source : sources) {
                Integer pid = source.getId();
                List<Sources> all = findAll(pid);
                source.setChildren(all);
            }
        }
        return sources;
    }

}
