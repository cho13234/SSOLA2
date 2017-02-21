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
public boolean updateProfile(MultipartHttpServletRequest mRequest , String id) {
	
	
	Profile profile = new Profile();
	
	boolean isSuccess = false;

	String uploadPath = "/Bigdata/GIT/SSOLA2/SSOLA2/src/main/webapp/resources/profileImages/";

	File dir = new File(uploadPath);

	if (!dir.isDirectory()) {

		dir.mkdirs();

	}

	Iterator<String> iter = mRequest.getFileNames();

	while(iter.hasNext()) {

		String uploadFileName = iter.next();

		MultipartFile mFile = mRequest.getFile(uploadFileName);

		String originalFileName = mFile.getOriginalFilename();

		String saveFileName = originalFileName;

			

		if(saveFileName != null && !saveFileName.equals("")) {

			if(new File(uploadPath + saveFileName).exists()) {

				saveFileName = saveFileName + "_" + System.currentTimeMillis();

			}

			try {

				mFile.transferTo(new File(uploadPath + saveFileName));
					
				profile.setImage(saveFileName);
				profile.setId(id);
				
				 dao.updateProfile(profile); //이미지 네임을 디비에 저장하는 곳
				
				isSuccess = true;				

			} catch (IllegalStateException e) {

				e.printStackTrace();

				isSuccess = false;

			} catch (IOException e) {

				e.printStackTrace();

				isSuccess = false;

			}

		} // if end

	} // while end

	return isSuccess;

} // fileUpload end
	
	
	
}

