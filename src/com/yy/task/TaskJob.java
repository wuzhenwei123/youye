package com.yy.task;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yy.yyCompany.model.YyCompany;
import com.yy.yyCompany.service.YyCompanyService;

@Service
public class TaskJob {
	
	private static Logger logger = Logger.getLogger(TaskJob.class);
	
	
	@Autowired
	private YyCompanyService yycompanyService = null;
	
	/**
	 * 检查所有过期的公司
	 */
	public void updateCompanyState() {
		try{
			 List<YyCompany> list = yycompanyService.getOverTimeCompany(new YyCompany());
			 if(list!=null&&list.size()>0){
				 for(YyCompany c:list){
					 c.setState(0);
					 yycompanyService.updateYyCompany(c);
				 }
			 }
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
