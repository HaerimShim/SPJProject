package com.kook.spjpj.dao;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;

import com.kook.spjpj.dto.BDto;
import com.kook.spjpj.dto.JoinDto;
import com.kook.spjpj.dto.RDto;

public interface IDao {
	//===== join =====
	public String join(JoinDto dto);
	
	//===== login====
	public JoinDto login(String bid);
	
	//===== board =====
	public ArrayList<BDto> list();
	public void write(String buser, String btitle, String bcontent);
	public BDto contentView(String bid);
	public void upHit(String bid);
	public void modify(String bid, String buser, String btitle, String bcontent);
	public void delete(String bid);
	public ArrayList<BDto> pageList(String pageNo);

	//===== record =====
	public void record(String rcompany, String ruser, String rtime_from, String rtime_to, 
			String rtime_day, String rwage_hour, String rwage_day);
	public ArrayList<RDto> wageBill(String rid);


}
