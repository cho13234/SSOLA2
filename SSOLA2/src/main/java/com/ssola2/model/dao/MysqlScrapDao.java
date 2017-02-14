package com.ssola2.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Scrap;
import com.ssola2.model.mapper.ScrapMapper;

@Repository(value="scrapDao")
public class MysqlScrapDao implements ScrapDao {

	@Autowired
	@Qualifier("scrapMapper")
	private ScrapMapper scrapMapper;
		


	@Override
	public void deleteScrap(int scrapNo) {
		
		
		scrapMapper.deleteScrap(scrapNo);
		
		
	}

	@Override
	public List<Scrap> selectListById(String id) {
		List<Scrap> selectListById = scrapMapper.selectListById(id);
		
		
		
		return selectListById;
	}

	@Override
	public Scrap  selectScrapInfo(int articleNo) {
		
		Scrap selectScrapInfo = scrapMapper.selectScrapInfo(articleNo);
		
		
		
		return selectScrapInfo;
	}

	@Override
	public void InsertScrap(Scrap scrap) {
		scrapMapper.InsertScrap(scrap);
		
		
	}

	@Override
	public List<Article> selectScrapJoin(String id) {
		
		return scrapMapper.selectScrapJoin(id);
	}

	
	

}
