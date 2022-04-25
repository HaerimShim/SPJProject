package com.kook.spjpj.command;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.dto.BDto;
import com.kook.spjpj.dto.RDto;
import com.kook.spjpj.util.Constant;

public class WageBillCommand implements ICommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		Dao dao = Constant.dao;
		String user = Constant.username;
//		String nic = request.getParameter("nic");
//		위 처럼, record에서 form tag를 통해서 전송된 nic도 로그인 id이지만, 
//		Controller에서 Constant.username으로 로그인 id를 불러올 수 있음.
		ArrayList<RDto> dtos = dao.wageBill(user);
		request.setAttribute("wageBill", dtos);
		

	}
}
