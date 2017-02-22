package com.ssola2.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Profile;
import com.ssola2.model.dto.Scrap;

public interface ScrapService {
	public List<Scrap> getListById(String id);
	public void deleteScrap(int scrapNo);

	public void InsertScrapTx(Scrap scrap);
	public Scrap selectScrapInfo(int articleNo);
	public List<Article> selectScrapJoin(String id);
	public void updateProfile(Profile profile);
	
}
