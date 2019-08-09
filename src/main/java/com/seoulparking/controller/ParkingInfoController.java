package com.seoulparking.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@RequestMapping(value = "/all", method = {RequestMethod.POST, RequestMethod.GET})   //반경 내 주차장 마커생성
	public List<ParkingInfoDto> findAll() throws Exception {
		List<ParkingInfoDto> addr2all = infodao.findAll();
		return addr2all;
	}
	
	@RequestMapping(value = "/{addr2}")
	public List<ParkingInfoDto> findByAddr2(@PathVariable("addr2") String addr2) throws Exception {
		return infodao.findByAddr2(addr2); 
	}
	
	@RequestMapping(value = "/radius", method = {RequestMethod.POST, RequestMethod.GET})   //반경 내 주차장 마커생성
	public List<ParkingInfoDto> within(@RequestParam(value="x", required = false) double x,@RequestParam(value="y",required = false) double y) throws Exception {
		System.out.println("클릭한 위치 좌표: "+x+' '+y);
		List<ParkingInfoDto> within= infodao.findAll();
		return within;
	}
	@RequestMapping(value = "/center", method = {RequestMethod.POST, RequestMethod.GET})   //반경 내 주차장 마커생성
	public List<ParkingInfoDto> center(@RequestParam(value="_x", required = false) double x,@RequestParam(value="_y",required = false) double y) throws Exception {
		System.out.println("지도 중심 좌표: "+x+' '+y);
		List<ParkingInfoDto> within= infodao.findAll();
		return within;
	}
	
}
	
	
