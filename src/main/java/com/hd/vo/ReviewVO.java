package com.hd.vo;

public class ReviewVO {
	private int reviewno; 			//리뷰번호
	private int reitemno; 			//상품번호
	private int reuserno; 			//회원번호
	private double rate; 			//별점
	private String recontent; 		//내용
	private String redate; 			//작성일
	//출력을 위한 변수
	private String name;			//작성자
	
	public int getReviewno() 		{	return reviewno;	}
	public int getReitemno() 		{	return reitemno;	}
	public int getReuserno() 		{	return reuserno;	}
	public double getRate() 		{	return rate;		}
	public String getRecontent() 	{	return recontent;	}
	public String getRedate() 		{	return redate;		}
	public String getName() 		{	return name;		}
	
	public void setReviewno(int reviewno) 		{	this.reviewno = reviewno;	}
	public void setReitemno(int reitemno) 		{	this.reitemno = reitemno;	}
	public void setReuserno(int reuserno) 		{	this.reuserno = reuserno;	}
	public void setRate(double rate) 			{	this.rate = rate;			}
	public void setRecontent(String recontent) 	{	this.recontent = recontent;	}
	public void setRedate(String redate) 		{	this.redate = redate;		}	
	public void setName(String name) 			{	this.name = name;			}
	
	public void printinfo() {
		System.out.println("---리뷰VO 정보---");
		System.out.println(reviewno);
		System.out.println(reitemno);
		System.out.println(reuserno);
		System.out.println(rate);
		System.out.println(recontent);
		System.out.println(redate);
		System.out.println(name);
		System.out.println("----------------");
	}
	
}
