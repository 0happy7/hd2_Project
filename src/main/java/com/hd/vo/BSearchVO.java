package com.hd.vo;

public class BSearchVO
{
	private int 	pageno;		// 페이지 번호
	private int		startno;	// limit 시작 번호
	private String	kind;		// 게시물 종류
	private String 	area;		// 지역 종류
	private String 	sena;		// 검색종류
	private String 	keyword;	// 검색어	
	private String 	tel;		// 전화번호 앞자리
	private String 	tel1;		// 전화번호 앞자리
	private String	tel2;		// 전화번호 뒷자리
	private String	food_time1;	// 앞시간
	private String	food_time2;	// 뒤시간
	private String	ugrade;		// 유저 등급
	
	
	
	private int		total;		// 게시물 전체 번호
	private int		maxpage;	// 최대 페이지 번호
	private int		startbk;	// 시작블럭 번호
	private int		endbk;		// 끝블럭 번호
	
	private int		viewno = 8;		// 보여주고 싶은 갯수
	private int		nviewno = 10;		// 보여주고 싶은 갯수
	
	private int buserno;
	public int getBuserno() {
		return buserno;
	}
	public void setBuserno(int buserno) {
		this.buserno = buserno;
	}
	
	
	public int 		getPageno() 		{	return pageno;		}
	public int 		getStartno()		{	return startno;		}
	public String 	getKind() 			{	return kind;		}
	public int 		getTotal() 			{	return total;		}
	public int 		getMaxpage() 		{	return maxpage;		}
	public int		getStartbk()		{	return startbk;		}
	public int		getEndbk()			{	return endbk;		}
	public String 	getArea() 			{	return area;		}
	public String 	getSena() 			{	return sena;		}
	public String 	getKeyword()		{	return keyword;		}
	public String	getUgrade() 		{	return ugrade;		}
	
	public String getTel() 				{	return tel;			}
	public String getTel1() 			{	return tel1;		}
	public String getTel2() 			{	return tel2;		}
	public String getFood_time1() 		{	return food_time1;	}
	public String getFood_time2() 		{	return food_time2;	}
	
	/*
	  public String getTitle()
	  {
	  	String title = "자바학습 게시판";
	  	if(this.kind.equals("T")) title = "자바학습 게시판"
	  	if(this.kind.equals("F")) title = "HTML학습 게시판";
	  	return title;
	  	}
	 */
	
	public void setPageno(int pageno) 	
	{
		this.pageno = pageno;
		
		// limit 시작 번호
		this.startno = (pageno - 1 ) * viewno;
	}
	public void nsetPageno(int pageno) 	
	{
		this.pageno = pageno;
		
		// limit 시작 번호
		this.startno = (pageno - 1 ) * nviewno;
	}
	public void setKind(String kind) 
	{	
		this.kind = kind;	
	}
	
	public void setTotal(int total) 	
	{	
		this.total = total;
		
		// 전체 게시물 페이지 갯수
		this.maxpage = (this.total / viewno) + 1;
		if( this.total % viewno == 0)
		{
			this.maxpage--;
		}
		
		// 시작 블럭 번호 계산
		startbk = (pageno - 1) - ((pageno - 1) % viewno) + 1;
		
		// 끝 블럭 번호 계산
		endbk = startbk + viewno - 1;
		
		if(endbk > maxpage)
		{
			endbk = maxpage;
		}
	}
	public void nsetTotal(int total) 	
	{	
		this.total = total;
		
		// 전체 게시물 페이지 갯수
		this.maxpage = (this.total / nviewno) + 1;
		if( this.total % nviewno == 0)
		{
			this.maxpage--;
		}
		
		// 시작 블럭 번호 계산
		startbk = (pageno - 1) - ((pageno - 1) % nviewno) + 1;
		
		// 끝 블럭 번호 계산
		endbk = startbk + nviewno - 1;
		
		if(endbk > maxpage)
		{
			endbk = maxpage;
		}
	}
	public void setArea(String area) 				{	this.area 		= area;			}
	public void setSena(String sena) 				{	this.sena 		= sena;			}
	public void setKeyword(String keyword) 			{	this.keyword 	= keyword;		}
	public void setTel(String tel) 					{	this.tel 		= tel;			}
	public void setTel1(String tel1) 				{	this.tel1 		= tel1;			}
	public void setTel2(String tel2) 				{	this.tel2 		= tel2;			}
	public void setFood_time1(String food_time1) 	{	this.food_time1 = food_time1;	}
	public void setFood_time2(String food_time2) 	{	this.food_time2 = food_time2;	}
	public void setUgrade(String ugrade) 			{	this.ugrade 	= ugrade;		}
}
