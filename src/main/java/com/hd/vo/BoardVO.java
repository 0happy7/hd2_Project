package com.hd.vo;

import java.util.List;

public class BoardVO
{
	private String bno;			// 게시물 번호
	private String userno;		// 회원 정보
	private String bkind;		// 게시판종류
	private String name;		// 회원 이름
	private String bname;		// 제목
	private String addr;		// 주소 
	private String area;		// 지역명
	private String tel;			// 전화번호
	private String tel1;		// 전화번호앞
	private String tel2;		// 전화번호뒤
	private String btime1;		// 영업시간앞
	private String btime2;		// 영업시간뒤
	private String bcontent;	// 내용
	private String bwdate;		// 등록일 
	private String bhit;		// 조회수
	private List<FileVO> files; // 첨부 파일 목록
	
	// 파일 관련 필드 추가
    private int fid;
    private String bfname;
    private String bpname;
	
	public String getBno() 						{	return bno;					}
	public String getUserno()					{	return userno;				}
	public String getBkind() 					{	return bkind;				}
	public String getName() 					{	return name;				}
	public String getBname() 					{	return bname;				}
	public String getAddr() 					{	return addr;				}
	public String getArea() 					{	return area;				}
	public String getBcontent() 				{	return bcontent;			}
	public String getBwdate() 					{	return bwdate;				}
	public String getBhit() 					{	return bhit;				}
	public List<FileVO> getFiles() 				{	return files;				}
	public int getFid() 						{	return fid;					}
	public String getBfname() 					{	return bfname;				}
	public String getBpname() 					{	return bpname;				}
	public String getTel() 						{	return tel;					}
	public String getTel1() 					{	return tel1;				}
	public String getTel2() 					{	return tel2;				}
	public String getBtime1() 					{	return btime1;				}
	public String getBtime2() 					{	return btime2;				}
	
	public void setBno(String bno) 				{	this.bno 		= bno;		}
	public void setUserno(String userno) 		{	this.userno 	= userno;	}
	public void setBkind(String bkind) 			{	this.bkind 		= bkind;	}
	public void setName(String name) 			{	this.name 		= name;		}
	public void setBname(String bname) 			{	this.bname 		= bname;	}
	public void setAddr(String addr) 			{	this.addr 		= addr;		}
	public void setArea(String area) 			{	this.area 		= area;		}
	public void setBcontent(String bcontent) 	{	this.bcontent 	= bcontent;	}
	public void setBwdate(String bwdate) 		{	this.bwdate 	= bwdate;	}
	public void setBhit(String bhit) 			{	this.bhit 		= bhit;		}
	public void setFiles(List<FileVO> files)	{	this.files 		= files;	}
	public void setFid(int fid) 				{	this.fid 		= fid;		}
	public void setBfname(String bfname) 		{	this.bfname 	= bfname;	}
	public void setBpname(String bpname) 		{	this.bpname 	= bpname;	}
	public void setTel(String tel) 				{	this.tel 		= tel;		}
	public void setTel1(String tel1) 			{	this.tel1 		= tel1;		}
	public void setTel2(String tel2) 			{	this.tel2 		= tel2;		}
	public void setBtime1(String btime1) 		{	this.btime1 	= btime1;	}
	public void setBtime2(String btime2) 		{	this.btime2 	= btime2;	}
	
	// 표시를 위한 변수
	public String userid;
	public String getUserid() {return userid;}
	public void setUserid(String userid) {this.userid = userid;}
	
	
	@Override
	public String toString() {
	    return "BoardVO{" +
	            "bno=" + bno +
	            ", userno=" + userno +
	            ", bkind='" + bkind + '\'' +
	            ", name='" + name + '\'' +
	            ", bname='" + bname + '\'' +
	            ", addr='" + addr + '\'' +
	            ", area='" + area + '\'' +
	            ", tel='" + tel + '\'' +
	            ", tel1='" + tel1 + '\'' +
	            ", tel2='" + tel2 + '\'' +
	            ", btime1='" + btime1 + '\'' +
	            ", btime2='" + btime2 + '\'' +
	            ", bcontent='" + bcontent + '\'' +
	            ", bwdate='" + bwdate + '\'' +
	            ", bhit='" + bhit + '\'' +
	            '}';
	}
}

/*
 * private List<String> bfname; // 원본파일 private List<String> bpname; // 저장된 파일이름
 * 
 * public List<String> getBfname() { return bfname; } public List<String>
 * getBpname() { return bpname; }
 * 
 * public void setBfname(List<String> bfname) { this.bfname = bfname; } public
 * void setBpname(List<String> bpname) { this.bpname = bpname; }
 */

