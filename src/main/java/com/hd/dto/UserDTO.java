package com.hd.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hd.vo.BoardVO;
import com.hd.vo.OrderVO;
import com.hd.vo.SearchVO;
import com.hd.vo.UserVO;

@Repository
public class UserDTO {
	@Autowired
	private SqlSession session;
	
	// 아이디 중복 검사
	public String CheckID(String id) {
		if(id == null || id.equals("")) return "ERROR";
		int total = session.selectOne("checkid", id);
		if(total > 0) return "DUPLICATE";
		return "NOT_DUPLICATE";
	}
	
	// 이메일 중복 검사
	public String CheckEmail(String email) {
		if(email == null || email.equals("")) return "ERROR";
		int total = session.selectOne("emailcheck", email);
		if(total > 0) return "DUPLICATE";
		return "NOT_DUPLICATE";
	}
	
	// 회원가입
	public void Join(UserVO vo) {
		vo.printinfo();
		session.insert("join", vo);
		
	}

	//로그인
	public UserVO Login(String userid, String userpw) {
		UserVO vo = new UserVO();
		vo.setUserid(userid);
		vo.setUserpw(userpw);
		vo.printinfo();
		return session.selectOne("login", vo);
	}
	
	// 아이디 찾기 : 이름, 이메일 일치하는 회원정보 담기
	public UserVO FindId(String uname, String email) {
		UserVO vo = new UserVO();
		vo.setUname(uname);
		vo.setEmail(email);
		vo.printinfo();
		return session.selectOne("findId", vo);
	}
	// 비밀번호 찾기
	public UserVO FindPw(UserVO vo) {
		vo.printinfo();
		return session.selectOne("findPw", vo);
	}
	// 비밀번호 변경
	public void PwUpdate(String userno, String npw) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setUserpw(npw);
		session.update("pwupdate", vo);
	}
	// 비밀번호 확인
	public int pwCheck(String pw, String userno) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setUserpw(pw);
		return session.selectOne("checkpw", vo);
	}
	
	// 이름 변경
	public void nameUpdate(String userno, String uname) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setUname(uname);
		session.update("nameupdate", vo);
	}
	// 유저번호로 유저정보가져오기
	public UserVO noSelect(String userno) {
		return session.selectOne("noselect", userno);
	}
	// 사용중인 메일 체크
	public int useMailCheck(String email, String userno) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setEmail(email);
		return session.selectOne("usemailcheck", vo);
	}
	// 유저 메일 수정
	public void mailUpdate(String userno, String nemail) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setEmail(nemail);
		session.update("mailupdate", vo);
	}
	// 유저 탈퇴
	public void userDelete(String userno, String reason) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setReason(reason);
		session.update("userdelete",vo);
	}
	
	
	// 유저 목록 불러오기
	public List<UserVO> getUserList(SearchVO vo) {
		return session.selectList("userlist",vo);
	}
	
	// 유저 카운트
	public int getTotal(SearchVO vo) {
		return session.selectOne("usertotal", vo);
	}
	
	// 관리자 유저 메모 추가
	public void adminUpdateUser(String userno, String adminmemo) {
		UserVO vo = new UserVO();
		vo.setUserno(userno);
		vo.setAdminmemo(adminmemo);
		session.update("adminupdateuser", vo);
	}
	// 유저 완전 삭제
	public void userDrop(String no) {
		session.delete("userdrop", no);
	}
	// 유저 복구
	public void userRestore(String no) {
		session.update("userrestore", no);
	}
	// 공지사항 갯수
	public int getNoticeTotal(SearchVO sv) {
		return session.selectOne("getnoticetotal", sv);
	}
	// 공지사항 리스트
	public List<BoardVO> getNoticeList(SearchVO sv) {
		return session.selectList("getnoticelist",sv);
	}
	// 관리자 게시판 전체 글 갯수
	public int getBoardTotal(SearchVO sv) {
		return session.selectOne("getboardtotal", sv);
	}
	// 관리자 게시판 전체 글 리스트
	public List<BoardVO> getBoardList(SearchVO sv) {
		return session.selectList("getboardlist",sv);
	}
	
	//공지사항 삭제
	public void NoticeDelete(String no) {
		session.delete("noticedelete", no);
		
	}
	// 게시글 삭제
	public void BoardsDelete(String no) {
		session.delete("boardsdelete", no);
		
	}
	
	// 유저이름 가져오기
	public String getUserName(int userno) {
		return session.selectOne("getusername", userno);
	}

	public void adminUpdateOrder(OrderVO vo) {
		session.update("adminupdateorder", vo);
	}

	public UserVO getUserInfo(int no) {
		return session.selectOne("getuserinfo", no);
	}



}
