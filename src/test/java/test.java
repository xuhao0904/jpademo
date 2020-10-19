import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.mapper.CustomerMapper;
import com.offcn.pojo.Customer;
import com.offcn.service.CustomerService;
import com.offcn.service.factory.MyJobFactory;
import com.offcn.util.MyJob;
import com.offcn.util.QuartzManager;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.quartz.*;
import org.quartz.impl.JobDetailImpl;
import org.quartz.impl.JobExecutionContextImpl;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.CronTriggerFactoryBean;
import org.springframework.scheduling.quartz.JobDetailFactoryBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.scheduling.quartz.SimpleTriggerFactoryBean;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.Tuple;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring_service.xml","classpath:spring/spring.xml"})
public class test {
@Autowired
private JedisPool jedisPool;
@Autowired
private CustomerService customerService;

    @Autowired
    private MyJobFactory myJobFactory;
    @Test
    public void t(){


        try {
            List<String> warnings = new ArrayList<String>();
            boolean overwrite = true;
            //文件存放的硬盘路径
            File configFile=new  File("D:\\Program Files\\JetBrains\\IntelliJ IDEA 2019.3.3\\IdeaWorkSpeace\\ssm\\src\\main\\resources\\generator.xml");
            ConfigurationParser cp = new ConfigurationParser(warnings);
            Configuration config = cp.parseConfiguration(configFile);
            DefaultShellCallback callback = new DefaultShellCallback(overwrite);
            MyBatisGenerator MyBatisGenerator =
                    new MyBatisGenerator(config, callback, warnings);
            MyBatisGenerator.generate(null);
        }catch (Exception e){
            e.printStackTrace();
        }
    }






        /*
        * @RequestMapping("/download")
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
    *
    * */

  @Test
    public void lis(){

      /**
      public ResponseEntity<byte[]> download(int id) {
          ResponseEntity responseEntity=null;
          Attachment attachment = attachmentMapper.selectByPrimaryKey(id);
          String path = attachment.getPath();
          //获取文件名
          String fileName=path.substring(path.lastIndexOf("\\")+1);
          try {
              //下载附件框乱码处理
              fileName=new String(fileName.getBytes("utf-8"),"iso-8859-1");
          } catch (UnsupportedEncodingException e) {
              e.printStackTrace();
          }
          File file=new File(path);
          System.out.println(fileName);
          HttpHeaders httpHeaders=new HttpHeaders();
          //设置下载附件框
          httpHeaders.setContentDispositionFormData("attachment",fileName);

          try {
              //args1:字节数组（将读取到要下载的文件转为字节数组）;args2:http头对象；args3:响应状态
              responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), httpHeaders, HttpStatus.OK);
          } catch (IOException e) {
              e.printStackTrace();
          }
          return responseEntity;
      }*/
  }
@Test
        public void ss(){
     String s="";
    String[] split = s.split("/");
    System.out.println(Arrays.toString(split));
}



}
