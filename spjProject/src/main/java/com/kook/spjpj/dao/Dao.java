package com.kook.spjpj.dao;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kook.spjpj.dto.BDto;
import com.kook.spjpj.dto.JoinDto;
import com.kook.spjpj.dto.RDto;

public class Dao implements IDao {
//	Mybatis를 이용하여 DAO를 구현하려면 SqlSession 객체가 필요 (참고: https://heewon26.tistory.com/2)	
	@Autowired 
	private SqlSession sqlSession;
	
	@Override
	public String join(JoinDto dto) {
		int res = sqlSession.insert("join", dto); //mapper.xml호출
		System.out.println(res);
		String result = null;
		if(res > 0)
			result = "success";
		else
			result = "failed";
		return result;
	}

	//======login======
	@Override
	public JoinDto login(String bid) {
		System.out.println(bid);
		JoinDto result = sqlSession.selectOne("login",bid);
		return result;
	}
	
	//===== board =====
		@Override
		public ArrayList<BDto> list() {
			ArrayList<BDto> result = (ArrayList)sqlSession.selectList("list");
			return result;
		}
		
		@Override
		public void write(String buser, String btitle, String bcontent) {
			BDto dto = new BDto(0, buser, btitle, bcontent, null,0,0,0,0);
			sqlSession.insert("write",dto);
		}
		
		@Override
		public BDto contentView(String bid) {
			upHit(bid);	//hit수 처리, 내용 조기에 hit수가 더해져야함
			int idNum = Integer.parseInt(bid);	//id는 주키인 게시판 번호로 db에서는 number
			BDto result = sqlSession.selectOne("contentView",idNum);
			return result;
		}
		
		@Override
		public void upHit(String bid) {
			int idNum = Integer.parseInt(bid);
			sqlSession.update("upHit",idNum);
		}
				
		@Override
		public void modify(String id, String buser, String btitle, String bcontent) {
			int idNum = Integer.parseInt(id);
			BDto dto = new BDto(idNum, buser, btitle, bcontent, null, 0, 0, 0, 0);
			sqlSession.update("modify",dto);	//수정이므로 sqlSession의 update메서드를 사용
		}
		
		@Override
		public void delete(String bid) {
			int idNum = Integer.parseInt(bid);
			sqlSession.delete("delete",idNum); //삭제이므로 sqlSession의 delete메서드 사용
		}
		
		@Override
		public ArrayList<BDto> pageList(String pageNo) {
			int page = Integer.parseInt(pageNo);
			int start = (page -1) * 10 + 1 ;
			System.out.println("start : " + start);
			ArrayList<BDto> result = (ArrayList)sqlSession.selectList("pageList",start);
			System.out.println(result);
			return result;
		}

		@Override
		public void record(String company, String ruser, String time_from, String time_to, 
				String time_day, String wage_hour, String wage_day) {
			DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	        LocalDateTime localTime1 = LocalDateTime.from(formatDateTime.parse(time_from));
	        Timestamp rtime_from = Timestamp.valueOf(localTime1);
	        
	        LocalDateTime localTime2 = LocalDateTime.from(formatDateTime.parse(time_to));
	        Timestamp rtime_to = Timestamp.valueOf(localTime2);
	        
	        // 근무시간, 시급, 일급은 소수점자리까지 나타내기 위해서 float로 변경
	        float rtime_day = Float.parseFloat(time_day);
	        float rwage_hour = Float.parseFloat(wage_hour);
	        float rwage_day = Float.parseFloat(wage_day);
			
			RDto dto = new RDto(company, ruser, rtime_from, rtime_to, rtime_day, 0, rwage_hour, rwage_day);
			sqlSession.insert("record", dto);
		}

		@Override
		public ArrayList<RDto> wageBill(String user) {
			System.out.println(user);
			ArrayList<RDto> result = (ArrayList)sqlSession.selectList("wageBill", user);
			return result;
		}
}
