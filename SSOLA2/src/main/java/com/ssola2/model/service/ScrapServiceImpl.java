package com.ssola2.model.service;


import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ssola2.model.dao.ScrapDao;
import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Profile;
import com.ssola2.model.dto.Scrap;

@Service(value="scrapService")
public class ScrapServiceImpl implements ScrapService {

   @Autowired
   @Qualifier(value="scrapDao")
   private ScrapDao dao;   


   
   @Override
   public void deleteScrap(int scrapNo) {
      dao.deleteScrap(scrapNo);
      
   }
   @Override
   public List<Scrap> getListById(String id) {
      List<Scrap> getListById = dao.selectListById(id);
   
      return getListById;
   }
   
   @Override
   public void InsertScrapTx(Scrap scrap) {
	   dao.InsertScrap(scrap);
   }
   
   @Override
   public  Scrap selectScrapInfo(int articleNo) {
		
      
      return dao.selectScrapInfo(articleNo);
   }
@Override
public List<Article> selectScrapJoin(String id) {
	
	return dao.selectScrapJoin(id);
}
@Override
public void updateProfile(Profile profile) {
	dao.updateProfile(profile);
	
}
	
	
	
	
}

