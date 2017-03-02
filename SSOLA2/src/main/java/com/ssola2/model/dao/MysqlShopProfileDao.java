package com.ssola2.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Shop_Profile;
import com.ssola2.model.mapper.ShopMapper;

@Repository(value="shopProfileDao")
public class MysqlShopProfileDao implements ShopProfileDao{

	@Autowired
	@Qualifier("shopMapper")
	private ShopMapper shopMapper;
	
	@Override
	public void insertShopProfileById(String id) {
		shopMapper.insertShopProfileById(id);
	}

	@Override
	public void updateShopProfile(Shop_Profile shopProfile) {
		shopMapper.updateShopProfile(shopProfile);
	}

	@Override
	public Shop_Profile selectShopProfile(String id) {		
		return shopMapper.selectShopProfile(id);
	}

	@Override
	public void insertReservation(Reservation reservation) {
		shopMapper.insertReservation(reservation);
	}

	@Override
	public List<Reservation> selectReservationByShopId(String id) {
		return shopMapper.selectReservationByShopId(id);
	}

	@Override
	public void updateReservationChecked(Reservation reservation) {
		shopMapper.updateReservationChecked(reservation);
	}

}
