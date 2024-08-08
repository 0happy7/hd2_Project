package com.hd.vo;

public class SearchVO {
	private int 	pageno;		// 페이지 번호
	private int 	startno;	// limit 시작번호
	private String  adminpage;	// 게시물 종류
	
	private int 	total;		// 게시물 전체 번호
	private int 	maxpage;	// 최대 페이지 번호
	private int 	startBk;	// 시작블럭 번호
	private int 	endBk;		// 끝블럭 번호
	
	private int 	sstartno;		// 페이지 번호
	private int 	pagesize = 3; // 페이지당 아이템 수
	private int 	smaxpage;
	// 탈퇴유저 구분
	private String  isretire;
	
	// 유저 번호 : 유저별 주문내역 확인용
	private int suserno;
	
	// 검색
	private String  searchname; // 검색종류
	private String  keyword;	// 키워드
	
	// 카테코리 (상품 구분)
	private String category;
	
	
	public int 		getPageno() 	{	return pageno;		}
	public int 		getStartno() 	{	return startno;		}
	public String   getAdminpage() 	{	return adminpage;	}
	public int 		getTotal() 		{	return total;		}
	public int 		getMaxpage() 	{	return maxpage;		}
	public int 		getStartBk() 	{	return startBk;		}
	public int 		getEndBk() 		{	return endBk;		}
	public String   getSearchname() {	return searchname;	}
	public String   getKeyword() 	{	return keyword;		}
	public String   getIsretire()   {	return isretire;	}
	public int		getSuserno()	{	return suserno;		}
	public String   getCategory() 	{	return category;	}
	public int 		getSmaxpage() 	{	return smaxpage;	}
	
	public void setPageno(int pageno) {
		this.pageno = pageno;
		
		// limit 시작
		this.startno = (pageno - 1) * 10;
		this.sstartno = (pageno - 1) * pagesize;
	}

	public void setAdminpage(String adminpage) {
		this.adminpage = adminpage;
	}
	public void setTotal(int total) {
		this.total = total;
		//전체 게시물 페이지 갯수
		this.maxpage = total/10 + 1 ;
		if(total % 10 == 0) maxpage--;
		
		this.smaxpage = total/pagesize + 1 ;
		if(total % pagesize == 0) smaxpage--;
		
		//시작블럭 번호 계산
		startBk = (pageno - 1) - ((pageno - 1) % 10) + 1;
		endBk = startBk + 10 - 1;
		if(endBk > maxpage) {
			endBk = maxpage;
		}
		
	}
	public void setSearchname(String searchname) 	{	this.searchname = searchname;	}
	public void setKeyword(String keyword) 			{	this.keyword = keyword;			}
	public void setIsretire(String isretire) 		{	this.isretire = isretire;		}
	public void setSuserno(int suserno)				{	this.suserno = suserno;			}
	public void setCategory(String category) 		{	this.category = category;		}
	

	
	public void printinfo() {
		System.out.println("---------------------");
		System.out.println(pageno);
		System.out.println(startno);
		System.out.println(adminpage);
		System.out.println(total);
		System.out.println(maxpage);
		System.out.println(startBk);
		System.out.println(endBk);
		System.out.println(isretire);
		System.out.println(searchname);
		System.out.println(keyword);
		System.out.println("유저번호" + suserno);
		System.out.println("카테고리 : " + category);
	}
	
}
