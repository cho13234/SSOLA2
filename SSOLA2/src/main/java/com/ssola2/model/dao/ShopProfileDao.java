package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Shop_Profile;

public interface ShopProfileDao {

	void insertShopProfileById(String id);

	void updateShopProfile(Shop_Profile shopProfile);

	Shop_Profile selectShopProfile(String id);

	void insertReservation(Reservation reservation);

	List<Reservation> selectReservationByShopId(String id);

	void updateReservationChecked(Reservation reservation);

}
