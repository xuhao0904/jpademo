package com.offcn.service;

import com.github.pagehelper.PageInfo;

public interface AnalysisService {

    PageInfo findAnalysisBypage(int pagenum, int pagesize);
}
