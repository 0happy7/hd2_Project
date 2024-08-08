package com.hd.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hd.vo.AddrVO;
import com.hd.vo.ItemVO;
import com.hd.vo.OrderVO;
import com.hd.vo.PayVO;
import com.hd.vo.ReviewVO;
import com.hd.vo.SearchVO;
import com.hd.vo.UserVO;

@Repository
public class ItemDTO {
	@Autowired
	private SqlSession session;

	public void writeItem(ItemVO vo) {
		session.insert("writeitem", vo);
	}

	public ItemVO getItem(String itemno) {
		return session.selectOne("getitem", itemno);
	}

	public int getTotal(SearchVO vo) {

		return session.selectOne("itemtotal", vo);
	}

	public List<ItemVO> getItemList(SearchVO vo) {
		return session.selectList("itemlist",vo);
	}
	
	public List<ItemVO> getIndexItemList(SearchVO vo) {
		return session.selectList("indexitemlist",vo);
	}
	

	public void updateItem(ItemVO vo) {
		session.update("updateitem", vo);
		
	}

	public void itemDrop(String itemno) {
		session.delete("itemdrop", itemno);
		
	}

	public void writeReview(ReviewVO vo) {
		session.insert("writereview",vo);
	}

	public ReviewVO getReview(int no) {
		return session.selectOne("getreview", no);
	}

	public List<ReviewVO> getReviewList(String itemno) {
		return session.selectList("reviewlist",itemno);
	}

	public void updateRating(int no) {
		session.update("updaterating", no);
		
	}

	public void deleteReview(String no) {
		session.delete("deletereview", no);
	}

	public void addrsave(AddrVO vo) {
		session.insert("addrsave", vo);
	}

	public void addrDefSet() {
		session.update("addrdefset");
	}

	public List<AddrVO> getAddrList(String no) {
		return session.selectList("getaddrlist", no);
	}

	public void orderWrite(OrderVO vo) {
		session.insert("orderwrite", vo);
	}

	public void payWrite(PayVO vo) {
		session.insert("paywrite", vo);
		
	}

	public OrderVO getOrder(String orderno) {
		return session.selectOne("getorder", orderno);
	}

	public int getOrderTotal(SearchVO sv) {
		return session.selectOne("getordertotal", sv);
	}

	public List<OrderVO> getOrderList(SearchVO sv) {
		return session.selectList("getorderlist", sv);
	}

	public PayVO getPay(String orderno) {
		return session.selectOne("getpay", orderno);
	}

	public List<OrderVO> getOrderListA(SearchVO sv) {
		return session.selectList("getorderlista", sv);
	}

	public int getOrderTotalA(SearchVO sv) {
		return session.selectOne("getordertotala", sv);
	}

	public void updateItemCnt(OrderVO ordervo) {
		session.update("updateitemcnt", ordervo);
		
	}

	public int getItemCnt(int oitemno) {
		return session.selectOne("getitemcnt", oitemno);
	}

	public void updateStockSet(int oitemno) {
		session.update("updatestockset", oitemno);
	}

	public List<ItemVO> getItemListShop(SearchVO sv) {
		return session.selectList("getitemlistshop", sv);
	}

	public List<ItemVO> getItemListShopAll(SearchVO sv) {
		return session.selectList("getitemlistshopall", sv);
	}




	
	
}
