package com.ssola2.model.mapper;

import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Shop_Profile;

public interface ShopMapper {

	void insertShopProfileById(String id);

	void updateShopProfile(Shop_Profile shopProfile);

	Shop_Profile selectShopProfile(String id);

	void insertReservation(Reservation reservation);
	
}
