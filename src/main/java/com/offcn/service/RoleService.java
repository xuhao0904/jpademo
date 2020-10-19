package com.offcn.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.offcn.pojo.Role;

import java.util.List;
import java.util.Set;

public interface RoleService {
   PageInfo<Role> findByPage(int pagenum, int pagesize);

   Role findRoleById(int roleid);

    Set<String> findRolesByUsername(String username);
}
