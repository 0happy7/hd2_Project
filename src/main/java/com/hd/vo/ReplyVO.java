/* ********************************
클래스 기능 : 댓글 정보 클래스
작성자 : 노승룡
작성일 : 2024.07.17
******************************** */

package com.hd.vo;

public class ReplyVO 
{
	private String rno;     	//댓글번호
	private String bno;     	//게시물번호
	private String ruserno; 	//댓글작성회원번호
	private String rcontent;   	//댓글내용
	private String rwdate;  	//작성일자
	private String runame;    	//작성자	
		
	public String getRno()     					{ 	return rno;     			}
	public String getBno()     					{ 	return bno;    			 	}
	public String getRcontent() 				{	return rcontent;			}
	public String getRuname() 					{	return runame;				}	
	public String getRuserno() 					{ 	return ruserno; 			}
	public String getRwdate()  					{ 	return rwdate;  			}
	
	public void setRno(String rno)         		{	this.rno 		= rno;      }
	public void setBno(String bno)         		{	this.bno 		= bno;      }
	public void setRuserno(String ruserno) 		{	this.ruserno 	= ruserno;	}
	public void setRwdate(String rwdate)   		{	this.rwdate 	= rwdate;  	}
	public void setRcontent(String rcontent) 	{	this.rcontent 	= rcontent;	}
	public void setRuname(String runame) 		{	this.runame 	= runame;	}
}
