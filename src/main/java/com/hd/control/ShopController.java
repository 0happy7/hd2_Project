package com.hd.control;


import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hd.dto.FileDTO;
import com.hd.dto.ItemDTO;
import com.hd.dto.UserDTO;
import com.hd.vo.AddrVO;
import com.hd.vo.FileVO;
import com.hd.vo.ItemVO;
import com.hd.vo.OrderVO;
import com.hd.vo.PayVO;
import com.hd.vo.ReviewVO;
import com.hd.vo.SearchVO;
import com.hd.vo.UserVO;

@Controller
public class ShopController {
	@Autowired
	UserDTO userDTO;
	@Autowired
	ItemDTO itemDTO;
	@Autowired
	FileDTO fileDTO;

	// pay
	@RequestMapping(value = "payment.do")
	public String Food(String oitemno,int pprice, int oitemcnt, int tprice,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:login.do";
		}
		List<AddrVO> addrlist = itemDTO.getAddrList(login.getUserno());
		ItemVO itemvo = itemDTO.getItem(oitemno);
		System.out.println(addrlist);
		model.addAttribute("itemvo", itemvo);
		model.addAttribute("oitemno", oitemno);
		model.addAttribute("oitemcnt", oitemcnt);
		model.addAttribute("tprice", tprice);
		model.addAttribute("pprice", pprice);
		model.addAttribute("addrlist", addrlist);
		return "payment/payment";
	}
	
	// 배송지 등록 
	@RequestMapping(value = "addrsave.do", method = RequestMethod.POST)
	@ResponseBody
	public String addrsave(AddrVO vo, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "false";
		}
		vo.printinfo();
		vo.setAuserno(Integer.parseInt(login.getUserno()));
		
		if(vo.getDef().equals("Y")) {
			itemDTO.addrDefSet();
		}
		
		itemDTO.addrsave(vo);
		return "true";
	}
	// 주문정보 저장 order_write.do
	@RequestMapping(value = "order_write.do", method = RequestMethod.POST)
	@ResponseBody
	public String orderWrite(OrderVO ordervo, PayVO payvo, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "false";
		}
		int count = ordervo.getOitemcnt();
		System.out.println("구매한 갯수 : " + count);
		ordervo.printinfo();
		payvo.printinfo();
		ordervo.setStatus("결제완료");
		itemDTO.orderWrite(ordervo);
		System.out.println("결제 후 ordervo");
		ordervo.printinfo();
		payvo.setPorderno(ordervo.getOrderno());
		payvo.setPuserno(ordervo.getOuserno());
		payvo.setPayprice(ordervo.getTprice());
		itemDTO.payWrite(payvo);
		itemDTO.updateItemCnt(ordervo);
		int itemcnt = itemDTO.getItemCnt(ordervo.getOitemno());
		if(itemcnt == 0) {
			itemDTO.updateStockSet(ordervo.getOitemno());
		}
		
		return ""+ordervo.getOrderno();
	}
	/*
	// 결제정보 저장 pay_write.do
	@RequestMapping(value = "pay_write.do", method = RequestMethod.POST)
	@ResponseBody
	public String payWrite(PayVO vo, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "false";
		}
		vo.printinfo();
		itemDTO.payWrite(vo);
		return "true";
	}
	*/
	// 주문 완료 창 completed
	@RequestMapping(value = "completed.do")
	public String completed(String orderno, Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		System.out.println(orderno);
		OrderVO orderVO = itemDTO.getOrder(orderno);
		orderVO.printinfo();
		model.addAttribute("order", orderVO);
		return "payment/completed";
	}
	// shop
	@RequestMapping(value = "shop_clothes.do", method = RequestMethod.GET)
	public String ShopClothes(Model model,@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("C");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		List<ItemVO> listall = itemDTO.getItemListShopAll(sv);
		model.addAttribute("listall", listall);
		
		model.addAttribute("search", sv);
		model.addAttribute("itemlist", list);
		
		return "shop/shop_clothes";
	}
	
	// shop
	@RequestMapping(value = "shop_clothes_view.do", method = RequestMethod.GET)
	public String shopClothesView(@RequestParam(defaultValue = "1")String itemno,Model model) {
		ItemVO itemvo = itemDTO.getItem(itemno);
		
		List<FileVO> filelist = fileDTO.getFileList(itemno);
		
		List<ReviewVO> reviewlist = itemDTO.getReviewList(itemno);
	
		itemvo.printinfo();
		model.addAttribute("item", itemvo);
		model.addAttribute("filelist", filelist);
		model.addAttribute("reviewlist", reviewlist);
		
		return "shop/shop_clothes_view";
	}
	
	@ResponseBody
	@RequestMapping(value = "shop_clothes_scroll.do", method = RequestMethod.GET)
	public Object[] shopClothesScroll(@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		System.out.println("makeList :: call");
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("C");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		
		
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		System.out.println("조회 완료");
		System.out.println(list.size());
		
	    // 마지막 페이지 여부 확인
	    boolean isLastPage = (page >= sv.getSmaxpage());
	    
	    // 응답 데이터 배열
	    return new Object[]{list, isLastPage};
	}
	
	// shop
	@RequestMapping(value = "shop_food.do", method = RequestMethod.GET)
	public String ShopFood(Model model,@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword){
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("F");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		List<ItemVO> listall = itemDTO.getItemListShopAll(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("itemlist", list);
		model.addAttribute("listall", listall);
		
		return "shop/shop_food";
	}
	
	@ResponseBody
	@RequestMapping(value = "shop_food_scroll.do", method = RequestMethod.GET)
	public Object[] shopFoodScroll(@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		System.out.println("makeList :: call");
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("F");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		
		
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		System.out.println("조회 완료");
		System.out.println(list.size());
		
	    // 마지막 페이지 여부 확인
	    boolean isLastPage = (page >= sv.getSmaxpage());
	    
	    // 응답 데이터 배열
	    return new Object[]{list, isLastPage};
	}
	
	
	// shop
	@RequestMapping(value = "shop_food_view.do", method = RequestMethod.GET)
	public String ShopFoodView(@RequestParam(defaultValue = "1")String itemno,Model model) {
		ItemVO itemvo = itemDTO.getItem(itemno);
		
		List<FileVO> filelist = fileDTO.getFileList(itemno);
		
		List<ReviewVO> reviewlist = itemDTO.getReviewList(itemno);
	
		itemvo.printinfo();
		model.addAttribute("item", itemvo);
		model.addAttribute("filelist", filelist);
		model.addAttribute("reviewlist", reviewlist);
		
		return "shop/shop_food_view";
	}
	
	// 리뷰 등록 review_write
	@RequestMapping(value = "review_write.do", method = RequestMethod.POST)
	@ResponseBody
	public String reviewWrite(ReviewVO vo, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "false";
		}
		
		vo.printinfo();
		itemDTO.writeReview(vo);
		itemDTO.updateRating(vo.getReitemno());
		
		vo = itemDTO.getReview(vo.getReviewno());
		System.out.println("작성 성공 후");
		vo.printinfo();
		return "true";
	}
	
	// 리뷰 삭제 review_delete
	@RequestMapping(value = "review_delete.do", method = RequestMethod.POST)
	@ResponseBody
	public String reviewDelete(String reviewno, int reitemno, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "false";
		}	
		itemDTO.deleteReview(reviewno);
		itemDTO.updateRating(reitemno);
		return "true";
	}
	
	// shop
	@RequestMapping(value = "shop_things.do", method = RequestMethod.GET)
	public String ShopThings(Model model,@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("I");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));

		List<ItemVO> list = itemDTO.getItemListShop(sv);
		List<ItemVO> listall = itemDTO.getItemListShopAll(sv);
		model.addAttribute("listall", listall);
		
		model.addAttribute("search", sv);
		model.addAttribute("itemlist", list);
		
		return "shop/shop_things";
	}
	// shop
	@ResponseBody
	@RequestMapping(value = "shop_things_scroll.do", method = RequestMethod.GET)
	public Object[] shopThingsScroll(@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		System.out.println("makeList :: call");
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("I");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		
		
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		System.out.println("조회 완료");
		System.out.println(list.size());
		
	    // 마지막 페이지 여부 확인
	    boolean isLastPage = (page >= sv.getSmaxpage());
	    
	    // 응답 데이터 배열
	    return new Object[]{list, isLastPage};
	}
	
	
	// shop
	@ResponseBody
	@RequestMapping(value = "/api.do", method = RequestMethod.GET)
	public List<ItemVO> makeList(@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "N")String searchname,
			@RequestParam(defaultValue = "")String keyword) {
		System.out.println("makeList :: call");
		
		SearchVO sv = new SearchVO();
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setCategory("I");
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));
		
		
		List<ItemVO> list = itemDTO.getItemListShop(sv);
		System.out.println("조회 완료");
		System.out.println(list.size());
		
		return list;
	}

	
	
	// shop
	@RequestMapping(value = "shop_things_view.do", method = RequestMethod.GET)
	public String ShopThingsView(@RequestParam(defaultValue = "1")String itemno,Model model) {
		ItemVO itemvo = itemDTO.getItem(itemno);
		
		List<FileVO> filelist = fileDTO.getFileList(itemno);
		
		List<ReviewVO> reviewlist = itemDTO.getReviewList(itemno);
	
		itemvo.printinfo();
		model.addAttribute("item", itemvo);
		model.addAttribute("filelist", filelist);
		model.addAttribute("reviewlist", reviewlist);
		
		
		return "shop/shop_things_view";
	}
	
}
