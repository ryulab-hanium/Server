package com.seoulparking.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.seoulparking.dao.ParkingInfoDao;
import com.seoulparking.dto.ParkingInfoDto;

@RestController
public class ParkingInfoController{

	@Autowired
	private ParkingInfoDao infodao;

	@RequestMapping(value = "/pname")
	public List<ParkingInfoDto> findByPname(String pname) throws Exception {
		return infodao.findByPname("리츠칼튼호텔");  
	}
	
	@RequestMapping(value = "/all")
	public List<ParkingInfoDto> findAll() throws Exception {
		return infodao.findAll();
	}
	
	@RequestMapping(value = "/{addr2}")
	public List<ParkingInfoDto> findByAddr2(@PathVariable("addr2") String addr2) throws Exception {
		return infodao.findByAddr2(addr2); 
	}
}
