package com.offcn.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.RoleMapper;
import com.offcn.mapper.RoleSourcesMapper;
import com.offcn.mapper.SourcesMapper;
import com.offcn.pojo.*;
import com.offcn.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private SourcesMapper sourcesMapper;
    @Autowired
    private RoleSourcesMapper roleSourcesMapper;
    @Override
    public PageInfo<Role> findByPage(int pagenum, int pagesize) {
        PageHelper.startPage(pagenum,pagesize);
        List<Role> roles = roleMapper.selectByExample(null);
        PageInfo<Role> pageInfo=new PageInfo<>(roles);
        return pageInfo;
    }

    @Override
    public Role findRoleById(int roleid) {
        Role role = roleMapper.selectByPrimaryKey(roleid);
        RoleSourcesExample roleSourcesExample=new RoleSourcesExample();
        RoleSourcesExample.Criteria criteria = roleSourcesExample.createCriteria();
        criteria.andRoleidEqualTo(roleid);
        //已经选中的
        List<RoleSources> roleSources = roleSourcesMapper.selectByExample(roleSourcesExample);
        //所有的二三级菜单
        SourcesExample sourcesExample=new SourcesExample();
        sourcesExample.createCriteria().andPidNotEqualTo(0);
        List<Sources> sources = sourcesMapper.selectByExample(sourcesExample);
        //遍历使得被选中的flag属性为true
        for (Sources source : sources) {
            for (RoleSources roleSource : roleSources) {
                if(source.getId()==roleSource.getSid()){
                    source.setChecked(true);
                }
            }
        }
        //封装二三级
        List<Sources> senSourecs=new ArrayList<>();
        for (Sources source : sources) {
            if(source.getPid()==1){
                senSourecs.add(source);
                List<Sources> sou=new ArrayList<>();
                    for(Sources sources1 : sources){
                        if(source.getId()==sources1.getPid()){
                            sou.add(sources1);
                        }
                    }
                    source.setChildren(sou);
            }
        }
        role.setSources(senSourecs);
        return  role;
    }

    @Override
    public Set<String> findRolesByUsername(String username) {
        return null;
    }
}
