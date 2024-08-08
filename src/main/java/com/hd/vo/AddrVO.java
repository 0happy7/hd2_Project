package com.hd.vo;

public class AddrVO {
	private int addrno;			//배송지번호
	private int auserno;		//회원번호
	private String dname;		//배송지명
	private String addrname; 	//수취인명
	private String addrtel;		//수취인 전화번호
	private String addr; 		//수취인 주소
	private String addrdetail;  //상세주소
	private String req; 		//요청사항
	private String def; 		//기본배송지여부
	
	public int getAddrno() 			{	return addrno;		}
	public int getAuserno() 		{	return auserno;		}
	public String getAddrname() 	{	return addrname;	}
	public String getAddrtel() 		{	return addrtel;		}
	public String getAddr() 		{	return addr;		}
	public String getAddrdetail() 	{	return addrdetail;	}
	public String getReq() 			{	return req;			}
	public String getDef() 			{	return def;			}
	public String getDname() 		{	return dname;		}
	
	public void setAddrno(int addrno) 				{	this.addrno = addrno;			}
	public void setAuserno(int auserno) 			{	this.auserno = auserno;			}
	public void setAddrname(String addrname) 		{	this.addrname = addrname;		}
	public void setAddrtel(String addrtel) 			{	
	    // 입력된 핸드폰 번호가 하이픈을 포함하고 있는지 확인
	    if (!addrtel.contains("-")) {
	        // 숫자만 있는 경우 하이픈을 추가
	        if (addrtel.length() == 10) {
	            // 10자리 번호 (예: 0101234567)
	            addrtel = addrtel.replaceAll("(\\d{3})(\\d{3})(\\d{4})", "$1-$2-$3");
	        } else if (addrtel.length() == 11) {
	            // 11자리 번호 (예: 01012345678)
	            addrtel = addrtel.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
	        } else if (addrtel.length() == 12) {
	            // 12자리 번호 (예: 010012345678)
	            addrtel = addrtel.replaceAll("(\\d{4})(\\d{4})(\\d{4})", "$1-$2-$3");
	        }
	    }
	    // 전화번호 저장
	    this.addrtel = addrtel;		
		
	}
	public void setAddr(String addr) 				{	this.addr = addr;				}
	public void setAddrdetail(String addrdetail) 	{	this.addrdetail = addrdetail;	}
	public void setReq(String req) 					{	this.req = req;					}
	public void setDef(String def) 					{	this.def = def;					}
	public void setDname(String dname) 				{	this.dname = dname;				}
	
	public void printinfo() {
		System.out.println("배송지정보 VO");
		System.out.println(addrno);
		System.out.println(auserno);
		System.out.println(dname);
		System.out.println(addrname);
		System.out.println(addrtel);
		System.out.println(addr);
		System.out.println(addrdetail);
		System.out.println(req);
		System.out.println(def);
		System.out.println("---------------------");
		
	}
	
	
	
}
