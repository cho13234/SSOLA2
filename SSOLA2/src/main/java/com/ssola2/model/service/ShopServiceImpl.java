package com.ssola2.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.ShopProfileDao;
import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Shop_Profile;

@Service(value="shopService")
public class ShopServiceImpl implements ShopService{

	@Autowired
	@Qualifier("shopProfileDao")
	private ShopProfileDao shopProfileDao;
	
	@Override
	public void insertShopProfileById(String id) {
		shopProfileDao.insertShopProfileById(id);
		
	}

	@Override
	public void updateShopProfile(Shop_Profile shopProfile) {
		shopProfileDao.updateShopProfile(shopProfile);
		
	}

	@Override
	public Shop_Profile selectShopProfile(String id) {		
		return shopProfileDao.selectShopProfile(id);
	}

	@Override
	public void insertReservation(Reservation reservation) {
		shopProfileDao.insertReservation(reservation);
		
	}

}
