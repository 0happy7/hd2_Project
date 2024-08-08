package com.hd.vo;

public class OrderVO {
	private int orderno;			//주문순서번호
	private String ordernum; 		// 주문번호
	private int ouserno;			//회원번호
	private int oitemno;			//상품번호
	private String status; 			//주문상태
	private String odate; 			//주문일시
	private String deliveryc; 		//택배회사
	private String trackingno; 		//운송장번호
	private int tprice;				//총주문금액
	private int oitemcnt;			//수량
	private String oaddrname; 		//수취인명
	private String oaddrtel; 		//수취인번호
	private String oaddr; 			//주소
	private String oaddrdetail; 	//상세주소
	private String oreq;			//요청사항
	private String omemo;			//관리자메모
	
	// 주문목록을 표시하기위한 변수
	private String iname;
	private int price;
	private int lpayprice;
	private String paydate;
	private String uname;
	private String payment;
	
	public int getOrderno() 			{	return orderno;			}
	public int getOuserno() 			{	return ouserno;			}
	public int getOitemno()				{	return oitemno;			}
	public String getStatus() 			{	return status;			}
	public String getOdate() 			{	return odate;			}
	public String getDeliveryc() 		{	return deliveryc;		}
	public String getTrackingno() 		{	return trackingno;		}
	public int getTprice() 				{	return tprice;			}
	public int getOitemcnt() 			{	return oitemcnt;		}
	public String getOaddrname() 		{	return oaddrname;		}
	public String getOaddrtel() 		{	return oaddrtel;		}
	public String getOaddr() 			{	return oaddr;			}
	public String getOaddrdetail() 		{	return oaddrdetail;		}
	public String getOreq() 			{	return oreq;			}
	public String getOmemo() 			{	return omemo;			}
	public String getOrdernum() 		{	return ordernum;		}
	
	public void setOrderno(int orderno) 				{	this.orderno = orderno;			}
	public void setOuserno(int ouserno) 				{	this.ouserno = ouserno;			}
	public void setOitemno(int oitemno) 				{	this.oitemno = oitemno;			}
	public void setOdate(String odate) 					{	this.odate = odate;				}
	public void setTrackingno(String trackingno) 		{	this.trackingno = trackingno;	}
	public void setTprice(int tprice) 					{	this.tprice = tprice;			}
	public void setOitemcnt(int oitemcnt) 				{	this.oitemcnt = oitemcnt;		}
	public void setOaddrname(String oaddrname) 			{	this.oaddrname = oaddrname;		}
	public void setOaddrtel(String oaddrtel) 			{	this.oaddrtel = oaddrtel;		}
	public void setOaddr(String oaddr) 					{	this.oaddr = oaddr;				}
	public void setOaddrdetail(String oaddrdetail) 		{	this.oaddrdetail = oaddrdetail;	}
	public void setOreq(String oreq) 					{	this.oreq = oreq;				}
	public void setOmemo(String omemo) 					{	this.omemo = omemo;				}
	public void setOrdernum(String ordernum) 			{	this.ordernum = ordernum;		}
	
	public void setStatus(String status) {
		this.status = status;
		if(status.equals("s1"))  {this.status = "결제대기";}
		else if(status.equals("s2")) {this.status = "결제완료";}
		else if(status.equals("s3")) {this.status = "상품준비중";}
		else if(status.equals("s4")) {this.status = "배송중";}
		else if(status.equals("s5")) {this.status = "배송완료";}
		else if(status.equals("s6")) {this.status = "구매확정";}
		else if(status.equals("s7")) {this.status = "주문취소";}
	}
	public void setDeliveryc(String deliveryc){
		this.deliveryc = deliveryc;
		if(deliveryc.equals("d1"))  {this.deliveryc = "우체국택배";}
		else if(deliveryc.equals("d2")) {this.deliveryc = "대한통운";}
		else if(deliveryc.equals("d3")) {this.deliveryc = "로젠택배";}
	}
	
// 주문목록을 위한 get set
public String getIname() {	return iname;}
public int getPrice() {	return price;}
public int getLpayprice() {	return lpayprice;}
public String getPaydate() {	return paydate;}
public void setIname(String iname) {	this.iname = iname;}
public void setPrice(int price) {	this.price = price;}
public void setLpayprice(int lpayprice) {	this.lpayprice = lpayprice;}
public void setPaydate(String paydate) {	this.paydate = paydate;}
	
public String getUname() {return uname;}
public void setUname(String uname) {this.uname = uname;}
public String getPayment() {return payment;}
public void setPayment(String payment) {this.payment = payment;}
	
public void printinfo() {
		System.out.println("주문정보목록");
		System.out.println(orderno);
		System.out.println(ordernum);
		System.out.println(ouserno);
		System.out.println(oitemno);
		System.out.println(status);
		System.out.println(odate);
		System.out.println(deliveryc);
		System.out.println(trackingno);
		System.out.println(tprice);
		System.out.println(oitemcnt);
		System.out.println(oaddrname);
		System.out.println(oaddrtel);
		System.out.println(oaddr);
		System.out.println(oaddrdetail);
		System.out.println(oreq);
		System.out.println(omemo);
		System.out.println("--------------------");
		System.out.println("주문목록을 위한 변수들");
		System.out.println(iname);
		System.out.println(price);
		System.out.println(lpayprice);
		System.out.println(paydate);
		System.out.println("---------------");
	}
	
	
}
