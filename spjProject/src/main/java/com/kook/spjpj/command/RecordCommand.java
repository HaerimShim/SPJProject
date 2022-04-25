package com.kook.spjpj.command;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.util.Constant;

public class RecordCommand implements ICommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		Dao dao = Constant.dao;
		
		String company = request.getParameter("rcompany");
		String user = request.getParameter("ruser");
		String time_from = request.getParameter("rtime_from");
		String time_to = request.getParameter("rtime_to");
		String time_day = request.getParameter("rtime_day");
		String wage_hour = request.getParameter("rwage_hour");
		String wage_day = request.getParameter("rwage_day");
		
		dao.record(company, user, time_from, time_to, time_day, wage_hour, wage_day);
	}
}
