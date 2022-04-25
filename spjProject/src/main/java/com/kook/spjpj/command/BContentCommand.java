package com.kook.spjpj.command;
import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.dto.BDto;
import com.kook.spjpj.util.Constant;

public class BContentCommand implements ICommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		Dao dao = Constant.dao;
		String bid = request.getParameter("bid");
		System.out.println(bid);
		BDto dto = dao.contentView(bid);
		if(dto != null) {
			model.addAttribute("content_view",dto);
		}

	}

}
