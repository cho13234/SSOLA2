package com.ssola2.controller;

import java.text.SimpleDateFormat;
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
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		List<Reservation> reservations = shopService.searchReservationByShopId(id);
		
		StringBuffer sb = new StringBuffer();
		
		if (reservations.size() > 0) {
		
			sb.append("Before Reservation\n");
			
			for (int i = 0; i < ((reservations.size() > 3) ? 3 : reservations.size()) ; i++) {
				Reservation reservation = reservations.get(i);
				if (reservation == null) {
					continue;
				}
				sb.append(String.format("Book Date: %s\n", sdf.format(reservation.getBook_date())))
					.append(String.format("Book Time: %s ~ %d\n", reservation.getBook_time(), (Integer.parseInt(reservation.getBook_time()) + 1)))
					.append(String.format("Booker: %s\nGuest Numbers: %s\n", reservation.getBooker(), reservation.getBook_size()))
					.append(String.format("Reg Date: %s\n\n", sdf1.format(reservation.getReg_date())));
				shopService.setReservationChecked(reservation);
			}
			
			sb.append(String.format("Now Date: %s\n", sdf1.format(new Date().toString())))
				.append(String.format("Connect Id: %s\n", id))
				.append("End Reservation\n\n");
		}
		
		return sb.toString();
	}
}
