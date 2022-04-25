package com.kook.spjpj.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

//�Խ��� DB SPJ_BOARD ���̺�� ���εǴ� DTOŬ����
public class BDto {
		//������� �̸��� SPJ_BOARD ���̺��� �÷��� ���������� ����
		//��ҹ��ڸ� �����ϳ� �̸��� ���ƾ� �ϰ� ���������� ���� �����ϴ� ���̾�� ��
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
