package com.offcn.shiro;

import com.offcn.pojo.Employee;
import com.offcn.service.EmployeeService;
import com.offcn.service.RoleService;
import com.offcn.service.SourcesService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import sun.security.util.Password;

/**
 * name:ssmdemo
 * author: xiaoming
 * createtime:2020-08-05 10:54
 **/
public class MyRealm extends AuthorizingRealm {


    private EmployeeService employeeService;

    private RoleService roleService;

    private SourcesService sourcesService;

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    public void setSourcesService(SourcesService sourcesService) {
        this.sourcesService = sourcesService;
    }

    //授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //获取当前登录的用户名
        Employee employee= (Employee) principals.getPrimaryPrincipal();
        String username = employee.getUsername();
        SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
        //给当前用户设置的角色
        info.setRoles(roleService.findRolesByUsername(username));
        //给当前用户设置权限菜单
        info.setStringPermissions(sourcesService.findByUsername(username));
        return info;
    }

    //认证:token :调用login 方法中usernamepasswordtoken对象
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取控制层接收到的用户名
        String username = (String) token.getPrincipal();
        Employee employee = employeeService.findByUsername(username);
        if(employee!=null){
            //封装从数据库中根据用户名查询到的对象
            SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(employee, employee.getPassword(),"MyRealm");
            return info;
        }
        return null;
    }


}
