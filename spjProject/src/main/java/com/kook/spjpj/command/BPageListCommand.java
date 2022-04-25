package com.kook.spjpj.command;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.dto.BDto;
import com.kook.spjpj.util.Constant;

public class BPageListCommand implements ICommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		Dao dao = Constant.dao;
		String pageNo = request.getParameter("pageNo");
		ArrayList<BDto> dtos = dao.pageList(pageNo);
		request.setAttribute("listContent", dtos);
	}

}
