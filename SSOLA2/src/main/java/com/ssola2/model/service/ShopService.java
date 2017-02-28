package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Shop_Profile;

public interface ShopService {

	void insertShopProfileById(String id);

	void updateShopProfile(Shop_Profile shopProfile);

	Shop_Profile selectShopProfile(String id);

	void insertReservation(Reservation reservation);

	List<Reservation> searchReservationByShopId(String id);

	void setReservationChecked(Reservation reservation);

}
