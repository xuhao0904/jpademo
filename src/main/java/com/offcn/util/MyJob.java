package com.offcn.util;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class MyJob implements Job {
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
      Object o=  jobExecutionContext.getJobDetail().getJobDataMap().get("group");
        System.out.println(o);
    }
}
