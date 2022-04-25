package com.kook.spjpj.command;
import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.util.Constant;

public class BModifyCommand implements ICommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		Dao dao = Constant.dao;
		String id = request.getParameter("bid");
		String user = request.getParameter("buser");
		String title = request.getParameter("btitle");
		String content = request.getParameter("bcontent");
		
		dao.modify(id, user, title, content);

	}

}
