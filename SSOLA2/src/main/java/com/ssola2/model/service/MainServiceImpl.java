package com.ssola2.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;
import com.ssola2.model.dao.MainDao;
import com.ssola2.model.dto.Article;


@Service(value="mainService")
public class MainServiceImpl implements MainService {
	
	@Autowired
	@Qualifier("mainDao")
	private MainDao dao;

	@Override
	public void registerArticleTx(Article article) {
		
		String[] a = geoCoding(article.getSection1().getAddress());
		String[] b = geoCoding(article.getSection2().getAddress());
		String[] c = geoCoding(article.getSection3().getAddress());
		String[] d = geoCoding(article.getSection4().getAddress());
		if(a !=null && b !=null && c !=null && d !=null) {
		article.getSection1().setLAT(a[0]);
		article.getSection1().setLNG(a[1]);
		article.getSection2().setLAT(b[0]);
		article.getSection2().setLNG(b[1]);
		article.getSection3().setLAT(c[0]);
		article.getSection3().setLNG(c[1]);
		article.getSection4().setLAT(d[0]);
		article.getSection4().setLNG(d[1]);
		} else {
			article.getSection1().setLAT("0");
			article.getSection1().setLNG("0");
			article.getSection2().setLAT("0");
			article.getSection2().setLNG("0");
			article.getSection3().setLAT("0");
			article.getSection3().setLNG("0");
			article.getSection4().setLAT("0");
			article.getSection4().setLNG("0");
		}
		dao.insertSection(article.getSection1());
		dao.insertSection(article.getSection2());
		dao.insertSection(article.getSection3());
		dao.insertSection(article.getSection4());
		dao.insertArticle(article);
		
		
	}

	@Override
	public List<Article> getArticleList() {
		return dao.selectArticles();
	}
	
	@Override
	public List<Article> getArticleListByNum(int start, int end) {
		return dao.selectArticlesByNum(start, end);
	}
	
	@Override
	public Article getArticleByArticleNoSize(int articleNo) {
		return dao.selectArticleByArticleNoSize(articleNo);
	}

	@Override
	public Article getArticleByArticleNo(Integer articleNo) {
		return dao.getArticleByAritcleNo(articleNo);
	}

	@Override
	public Article editArticleByArticleNo(Integer articleNo) {
		return dao.editArticleByArticleNo(articleNo);
		
	}
	
	@Override
	public void editArticle(Article article) {
		dao.editSection(article.getSection1());
		dao.editSection(article.getSection2());
		dao.editSection(article.getSection3());
		dao.editSection(article.getSection4());
		dao.editArticle(article);
		
	}

	@Override
	public void deleteArticle(int articleNo) {
		dao.deleteArticle(articleNo);
		
	}
	
	public static String[] geoCoding(String location) {
		if (location == null)  
		return null;
				       
		Geocoder geocoder = new Geocoder();
		// setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
		// setLanguate : 인코딩 설정
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(location).setLanguage("ko").getGeocoderRequest();
		GeocodeResponse geocoderResponse;

		try {
		geocoderResponse = geocoder.geocode(geocoderRequest);
		if (geocoderResponse.getStatus() == GeocoderStatus.OK & !geocoderResponse.getResults().isEmpty()) {

		GeocoderResult geocoderResult=geocoderResponse.getResults().iterator().next();
		LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();
						  
		String[] coords = new String[2];
		coords[0] = latitudeLongitude.getLat().toString();
		coords[1] = latitudeLongitude.getLng().toString();
		return coords;
		}
		} catch (IOException ex) {
		ex.printStackTrace();
		}
		return null;
		}

	
	

}
