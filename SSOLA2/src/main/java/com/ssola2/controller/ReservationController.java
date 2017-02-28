package com.ssola2.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssola2.model.dto.Reservation;
import com.ssola2.model.service.ShopService;

@Controller
@RequestMapping(value="reservation")
public class ReservationController {
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	
	@RequestMapping(value="show.action", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String showReserve(String id) {
		
		List<Reservation> reservations = shopService.searchReservationByShopId(id);
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("Before Reservation\n");
		
		for (int i = 0; i < ((reservations.size() > 3) ? 3 : reservations.size()) ; i++) {
			Reservation reservation = reservations.get(i);
			if (reservation == null) {
				continue;
			}
			sb.append(reservation.getBook_date().toString())
				.append("\n")
				.append(reservation.getBook_time() + " ~ " + (Integer.parseInt(reservation.getBook_time()) + 1))
				.append("\n")
				.append(String.format("%s %s", reservation.getBooker(), reservation.getBook_size()))
				.append("\n")
				.append(reservation.getReg_date())
				.append("\n\n");
			shopService.setReservationChecked(reservation);
		}
		
		sb.append(String.format("Now Date: %s\n", new Date().toString()))
			.append(String.format("Connect Id: %s\n", id))
			.append("End Reservation\n");
		
		return sb.toString();
	}
}
