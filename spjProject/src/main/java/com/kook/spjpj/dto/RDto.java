package com.kook.spjpj.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

public class RDto {
	String rcompany;
	String ruser;
	Timestamp rtime_from;
	Timestamp rtime_to;
	float rtime_day;
	float rtime_week;
	float rwage_hour;
	float rwage_day;
	
	public RDto() {
		super();
	}

	public RDto(String rcompany, String ruser, Timestamp rtime_from, Timestamp rtime_to, float rtime_day,
			float rtime_week, float rwage_hour, float rwage_day) {
		super();
		this.rcompany = rcompany;
		this.ruser = ruser;
		this.rtime_from = rtime_from;
		this.rtime_to = rtime_to;
		this.rtime_day = rtime_day;
		this.rtime_week = rtime_week;
		this.rwage_hour = rwage_hour;
		this.rwage_day = rwage_day;
	}

	public String getRcompany() {
		return rcompany;
	}

	public void setRcompany(String rcompany) {
		this.rcompany = rcompany;
	}

	public String getRuser() {
		return ruser;
	}

	public void setRuser(String ruser) {
		this.ruser = ruser;
	}

	public Timestamp getRtime_from() {
		return rtime_from;
	}

	public void setRtime_from(Timestamp rtime_from) {
		this.rtime_from = rtime_from;
	}

	public Timestamp getRtime_to() {
		return rtime_to;
	}

	public void setRtime_to(Timestamp rtime_to) {
		this.rtime_to = rtime_to;
	}

	public float getRtime_day() {
		return rtime_day;
	}

	public void setRtime_day(float rtime_day) {
		this.rtime_day = rtime_day;
	}

	public float getRtime_week() {
		return rtime_week;
	}

	public void setRtime_week(float rtime_week) {
		this.rtime_week = rtime_week;
	}

	public float getRwage_hour() {
		return rwage_hour;
	}

	public void setRwage_hour(float rwage_hour) {
		this.rwage_hour = rwage_hour;
	}

	public float getRwage_day() {
		return rwage_day;
	}

	public void setRwage_day(float rwage_day) {
		this.rwage_day = rwage_day;
	}
	
	
}