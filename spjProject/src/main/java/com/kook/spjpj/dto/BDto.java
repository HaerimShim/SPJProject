package com.kook.spjpj.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

//게시판 DB SPJ_BOARD 테이블과 매핑되는 DTO클래스
public class BDto {
		//멤버변수 이름은 SPJ_BOARD 테이블의 컬럼과 데이터형이 매핑
		//대소문자를 무시하나 이름은 같아야 하고 데이터형도 서로 상응하는 형이어야 함
		private int bid;
		private String buser;
		private String btitle;
		private String bcontent;
		@DateTimeFormat(pattern = "yyyy-MM-dd")
	 	private Date bdate;
		private int bhit;
		private int bgroup;
		private int bstep;
		private int bindent;
		
		public BDto() {
			super();
		}

		public BDto(int bid, String buser, String btitle, String bcontent, Date bdate, int bhit, int bgroup, int bstep,
				int bindent) {
			super();
			this.bid = bid;
			this.buser = buser;
			this.btitle = btitle;
			this.bcontent = bcontent;
			this.bdate = bdate;
			this.bhit = bhit;
			this.bgroup = bgroup;
			this.bstep = bstep;
			this.bindent = bindent;
		}

		public int getBid() {
			return bid;
		}

		public void setBid(int bid) {
			this.bid = bid;
		}

		public String getBuser() {
			return buser;
		}

		public void setBuser(String buser) {
			this.buser = buser;
		}

		public String getBtitle() {
			return btitle;
		}

		public void setBtitle(String btitle) {
			this.btitle = btitle;
		}

		public String getBcontent() {
			return bcontent;
		}

		public void setBcontent(String bcontent) {
			this.bcontent = bcontent;
		}

		public Date getBdate() {
			return bdate;
		}

		public void setBdate(Date bdate) {
			this.bdate = bdate;
		}

		public int getBhit() {
			return bhit;
		}

		public void setBhit(int bhit) {
			this.bhit = bhit;
		}

		public int getBgroup() {
			return bgroup;
		}

		public void setBgroup(int bgroup) {
			this.bgroup = bgroup;
		}

		public int getBstep() {
			return bstep;
		}

		public void setBstep(int bstep) {
			this.bstep = bstep;
		}

		public int getBindent() {
			return bindent;
		}

		public void setBindent(int bindent) {
			this.bindent = bindent;
		}

}
