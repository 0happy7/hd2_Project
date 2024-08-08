package com.hd.vo;

public class ItemVO {
	private int itemno; 			//상품번호
	private String iuserno; 		//상품등록회원번호
	private String category;		//상품분류
	private String icode;			//상품코드
	private String iname;			//상품명
	private String maker;			//제조사
	private int price;				//판매가격
	private int shippingfee;		//배송비
	private String stockSet;		//재고설정
	private int stock;				//재고량
	private String thumbnailF;		//상품 대표이미지 원본파일명
	private String thumbnailP;		//상품 대표이미지 저장파일명
	private String ifname;			//상품이미지원본파일명
	private String ipname;			//상품이미지저장파일명
	private String icontent;		//상품 내용
	private int entityid;			
	private double rating; 			// 평점
	private double ratingStar; 		// 0.5 단위로 : 별표시
	
	public int		getItemno() 		{	return itemno;		}
	public String 	getIuserno() 		{	return iuserno;		}
	public String 	getCategory() 		{	return category;	}
	public String 	getIcode() 			{	return icode;		}
	public String 	getIname() 			{	return iname;		}
	public String 	getMaker() 			{	return maker;		}
	public int		getPrice() 			{	return price;		}
	public int 		getShippingfee() 	{	return shippingfee;	}
	public String 	getStockSet() 		{	return stockSet;	}
	public int 		getStock() 			{	return stock;		}
	public String 	getThumbnailF()		{	return thumbnailF;	}
	public String 	getThumbnailP() 	{	return thumbnailP;	}
	public String 	getIfname() 		{	return ifname;		}
	public String 	getIpname() 		{	return ipname;		}
	public String 	getIcontent() 		{	return icontent;	}
	public int 		getEntityid() 		{	return entityid;	}
	public double 	getRating() 		{	return rating;		}
	public double   getRatingStar() 	{return ratingStar;		}
	
	public void setItemno(int itemno) 				{	this.itemno = itemno;			}
	public void setIuserno(String iuserno) 			{	this.iuserno = iuserno;			}
	public void setCategory(String category) 		{	this.category = category;		}
	public void setIcode(String icode) 				{	this.icode = icode;				}
	public void setIname(String iname) 				{	this.iname = iname;				}
	public void setMaker(String maker) 				{	this.maker = maker;				}
	public void setPrice(int price) 				{	this.price = price;				}
	public void setShippingfee(int shippingfee) 	{	this.shippingfee = shippingfee;	}
	public void setStockSet(String stockSet) 		{	this.stockSet = stockSet;		}
	public void setStock(int stock) 				{	this.stock = stock;				}
	public void setThumbnailF(String thumbnailF) 	{	this.thumbnailF = thumbnailF;	}
	public void setThumbnailP(String thumbnailP) 	{	this.thumbnailP = thumbnailP;	}
	public void setIfname(String ifname)			{	this.ifname = ifname;			}
	public void setIpname(String ipname) 			{	this.ipname = ipname;			}
	public void setIcontent(String icontent) 		{	this.icontent = icontent;		}
	public void setEntityid(int entityid) 			{	this.entityid = entityid;		}
	public void setRating(double rating) {
		this.rating = rating;
		if(rating < 0.25) ratingStar = 0;
		else if(rating < 0.75) ratingStar = 0.5;
		else if(rating < 1.25) ratingStar = 1.0;
		else if(rating < 1.75) ratingStar = 1.5;
		else if(rating < 2.25) ratingStar = 2.0;
		else if(rating < 2.75) ratingStar = 2.5;
		else if(rating < 3.25) ratingStar = 3.0;
		else if(rating < 3.75) ratingStar = 3.5;
		else if(rating < 4.25) ratingStar = 4.0;
		else if(rating < 4.75) ratingStar = 4.5;
		else ratingStar = 5.0;
	}
	
	
	


	
	public void printinfo() {
		System.out.println(itemno);
		System.out.println(iuserno);
		System.out.println(category);
		System.out.println(icode);
		System.out.println(iname);
		System.out.println(maker);
		System.out.println(price);
		System.out.println(shippingfee);
		System.out.println(stockSet);
		System.out.println(stock);
		System.out.println(thumbnailF);
		System.out.println(thumbnailP);
		System.out.println(ifname);
		System.out.println(ipname);
		System.out.println(icontent);
		System.out.println(rating);
		System.out.println(ratingStar);
		System.out.println("-----------------------");
	}


}
