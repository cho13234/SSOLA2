package com.ssola2.model.mapper;

import java.util.List;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Scrap;

public interface ScrapMapper {
	public List<Scrap> selectListById (String id);
	public void InsertScrap(Scrap scrap);
	public void deleteScrap(int scrapNo);
	public Scrap selectScrapInfo(int articleNo);
	public List<Article> selectScrapJoin(String id);
	
	
}
