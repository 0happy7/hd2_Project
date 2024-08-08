package com.hd.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hd.dto.BoardDTO;
import com.hd.dto.FileDTO;
import com.hd.dto.ItemDTO;
import com.hd.dto.UserDTO;
import com.hd.mail.SendMail;
import com.hd.vo.BSearchVO;
import com.hd.vo.BoardVO;
import com.hd.vo.FileVO;
import com.hd.vo.ItemVO;
import com.hd.vo.OrderVO;
import com.hd.vo.PayVO;
import com.hd.vo.SearchVO;
import com.hd.vo.UserVO;
/**
 * Handles requests for the application home page.
 */
@Controller
public class UserController {
	@Autowired
	UserDTO userDTO;
	@Autowired
	ItemDTO itemDTO;
	@Autowired
	FileDTO fileDTO;
	
	@Autowired
	BoardDTO boardDTO;
	
	String adminpage = "N";
	
	//파일 저장 경로를 설정
	//final static String uploadPath = "D:\\skm\\Spring\\Spring_hd_06\\src\\main\\webapp\\resources\\upload\\";
	String uploadPath;
	// index
	@RequestMapping(value = "index.do", method = RequestMethod.GET)
	public String Index(Model model) {
		SearchVO sv = new SearchVO();
		sv.setCategory("F");
		List<ItemVO> flist = itemDTO.getIndexItemList(sv);
		sv.setCategory("I");
		List<ItemVO> ilist = itemDTO.getIndexItemList(sv);
		sv.setCategory("C");
		List<ItemVO> clist = itemDTO.getIndexItemList(sv);

		model.addAttribute("flist", flist);
		model.addAttribute("ilist", ilist);
		model.addAttribute("clist", clist);
		return "index/index";
	}
	
	// 회원가입 페이지
	@RequestMapping(value = "join.do")
	public String Join() {
		return "user/join";
	}
	
	// 아이디 중복 검사
	// 중복된 아이디 : DUPLICATE
	// 중복 안된 경우 : NOT_DUPLICATE
	// 아이디가 입력 안된 경우 : ERROR
	@RequestMapping(value = "idcheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String IdCheck(@RequestParam(required = true, defaultValue = "")String id) {
		if(id.equals(""))
		{
			return "ERROR";
		}
		return userDTO.CheckID(id);
	}
	// 이메일 중복 검사
	@RequestMapping(value = "emailcheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String EmailCheck(@RequestParam(required = true, defaultValue = "")String email) {
		if(email.equals(""))
		{
			return "ERROR";
		}
		return userDTO.CheckEmail(email);
	}
	
	// 인증메일 보내기
	@RequestMapping(value = "sendmail.do", method = RequestMethod.GET, produces = "text/html; charset=utf8")
	@ResponseBody
	public String SendMail(HttpServletRequest request,@RequestParam(required = true, defaultValue = "")String email) {
		if(email.equals(""))
		{
			return "올바른 메일주소가 아닙니다.";
		}
		SendMail sender = new SendMail();	
		//인증코드를 얻는다.
		String code = sender.AuthCode(5);

		sender.setFrom("thrudals7@naver.com");
		sender.setTo(email);
		sender.setAccount("thrudals7", "test1234");

		sender.setMail("회원가입 인증코드입니다.", "인증코드 : " + code);
		if( sender.sendMail() == true )
		{
			request.getSession().setAttribute("code",code);	
			return "메일을 발송하였습니다.";
		}else
		{
			return "메일 발송에 실패하였습니다.";
		}
	}
	
	// 이메일 코드 값 가져오기
	@RequestMapping(value = "getcode.do")
	@ResponseBody
	public String GetCode(HttpServletRequest request) {
		String code = (String) request.getSession().getAttribute("code");
		System.out.println(code);
		return code;
	}
	
	// 회원가입 완료
	@RequestMapping(value = "/joinok.do", method = RequestMethod.POST)
	public String JoinOK(UserVO vo,HttpServletRequest request) {
		vo.printinfo();
		userDTO.Join(vo);
		request.getSession().setAttribute("code", null);	
		return "redirect:login.do";
	}
	
	
	// 로그인 화면
	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String Login() {
		return "user/login";
	}
	
	// 로그인 구현 loginok.do
	// 로그인 처리 : 성공시 문자열 "true" 아니면 "false"
	@RequestMapping(value = "loginok.do", method = RequestMethod.POST)
	@ResponseBody
	public String LoginOK(HttpServletRequest request,String userid, String userpw) {
		UserVO vo = userDTO.Login(userid,userpw);
		if(vo == null) {
			return "false";
		}else {
			request.getSession().setAttribute("login",vo);	
			return "true";
		}
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout.do")
	public String Logout(HttpServletRequest request) {
		request.getSession().setAttribute("login",null);
		return "redirect:index.do";
	}
	
	// 아이디 찾기 페이지
	@RequestMapping(value = "find_id.do", method = RequestMethod.GET)
	public String FindId() {
		return "user/find_id";
	}
	
	// 아이디 찾기 find_id_ok.do
	@RequestMapping(value = "/find_id_ok.do", method = RequestMethod.POST)
	public String FindIdOK(String uname, String email,Model model) {
		System.out.println("받아온 값 이름: " + uname + " 이메일 : " + email);
		UserVO vo = userDTO.FindId(uname, email);
		model.addAttribute("findid", vo);
		return "user/find_id_ok";
	}
	
	// 비밀번호 찾기 화면
	@RequestMapping(value = "find_pw.do", method = RequestMethod.GET)
	public String FindPw() {
		return "user/find_pw";
	}
	
	// 비밀번호 찾기 페이지 (비밀번호 변경) find_pw_ok.do
	@RequestMapping(value = "find_pw_ok.do", method = RequestMethod.GET)
	public String FindPwOKpage() {
		return "user/find_pw_ok";
	}
	// 비밀번호 찾기 동작 (비밀번호 변경) find_pw_ok.do
	@RequestMapping(value = "find_pwc_ok.do", method = RequestMethod.POST)
	@ResponseBody
	public String FindPwOK(UserVO vo, HttpServletRequest request) {
		vo = userDTO.FindPw(vo);
		if(vo == null) {
			return "false";
		}
		request.getSession().setAttribute("userno",vo.getUserno());
		vo.printinfo();
		return "true";
	}
	
	// 마이페이지 비밀번호 변경
	@RequestMapping(value = "pw_chang.do", method = RequestMethod.GET)
	public String pwChang(HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		return "user/pw_chang";
	}
	
	
	// 비밀번호 변경 pw_update.do
	@RequestMapping(value = "pw_update.do", method = RequestMethod.POST)
	public String FindPwcOK(String userno, String npw, HttpServletRequest request) {
		System.out.println(userno + " " + npw);
		userDTO.PwUpdate(userno, npw);
		request.getSession().invalidate();
		return "user/pwc_ok";
	}
	
	/*
	   관리자 페이지
	 			 */
	
	// 관리자 페이지 pw 확인 페이지
	@RequestMapping(value = "admin_check.do", method = RequestMethod.GET)
	public String adminCheck(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		return "admin/admin_check";
	}
	// 관리자 페이지 pw확인 동작
	@RequestMapping(value = "admin_check_ok.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminCheckOK(String pw, String userno, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		System.out.println(pw + " " + userno);
		int count = userDTO.pwCheck(pw, userno);
		if(count == 0) {
			return "false";
		}else {
			return "true";
		}
	}
	
	
	// 관리자 공지
	@RequestMapping(value = "admin_notice.do", method = RequestMethod.GET)
	public String adminNotice(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "N")String adminpage,
			@RequestParam(defaultValue = "N")String searchname,@RequestParam(defaultValue = "")String keyword
			) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "N";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		
		//전체 게시물
		sv.setTotal(userDTO.getNoticeTotal(sv));
		
		List<BoardVO> list = userDTO.getNoticeList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("noticelist", list);
		
		return "admin/admin_notice";
	}
	
	// 관리자 공지 삭제 admin_notices_drop.do
	@RequestMapping(value = "admin_notices_drop.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminNoticesDrop(@RequestParam(value = "bno", required = false)List<String> bno) {
		if(bno == null) {
			return "false";
		}
		
		for (String no : bno) {
			System.out.println(no);
			fileDTO.NoticesFileDelete(no);
			userDTO.NoticeDelete(no);
		}
		
		return "true";
	}
	
	// 관리자 정보 페이지 admin_info.do
	@RequestMapping(value = "admin_info.do", method = RequestMethod.GET)
	public String AdminInfo(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "A";
		model.addAttribute("adminpage", adminpage);
		return "admin/admin_info";
	}
	
	
	// 이름 변경 ajax
	@RequestMapping(value = "name_change.do", method = RequestMethod.POST)
	public void nameChange(String userno, String uname, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		userDTO.nameUpdate(userno, uname);
		login = userDTO.noSelect(userno);
		request.getSession().setAttribute("login",login);	
	}
	
	
	// 관리자 이름 변경  submit
	@RequestMapping(value = "name_chok.do", method = RequestMethod.POST)
	public String nameChok(String userno, String uname, HttpServletRequest request, Model model) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "A";
		userDTO.nameUpdate(userno, uname);
		login = userDTO.noSelect(userno);
		model.addAttribute("adminpage", adminpage);
		request.getSession().setAttribute("login",login);
		return "admin/admin_info";
	}
	
	// 관리자 유저 관리 
	@RequestMapping(value = "admin_user.do", method = RequestMethod.GET)
	public String adminUser(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "U1")String adminpage,
			@RequestParam(defaultValue = "")String searchname,@RequestParam(defaultValue = "")String keyword) {
		
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "U1";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setIsretire("N");
		//전체 게시물
		sv.setTotal(userDTO.getTotal(sv));
		
		List<UserVO> list = userDTO.getUserList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("userlist", list);
		
		return "admin/admin_user";
	}
	
	// 관리자 유저 다중 삭제 admin_user_del
	@RequestMapping(value = "admin_users_del.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminUsersDel(@RequestParam(value = "userno", required = false)List<String> userno, String reason) {
		if(userno == null) {
			return "false";
		}
		
		for (String no : userno) {
			System.out.println(no);
			System.out.println(reason);
			userDTO.userDelete(no, reason);
		}
		
		return "true";
	}
	
	// 관리자 탈퇴사유 입력 창 ReasonInput.do
	@RequestMapping(value = "ReasonInput.do", method = RequestMethod.GET)
	public String reasonInput(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "index/index";
		}
		adminpage = "U1";
		model.addAttribute("adminpage", adminpage);
		
		return "admin/ReasonInput";
	}
	// 관리자 유저 정보 페이지 admin_userpage
	@RequestMapping(value = "admin_userpage.do", method = RequestMethod.GET)
	public String adminUserpage(@RequestParam(defaultValue = "1")String userno,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "index/index";
		}
		adminpage = "U1";
		model.addAttribute("adminpage", adminpage);
		UserVO uservo = userDTO.noSelect(userno);
		model.addAttribute("user", uservo);
		
		return "admin/admin_userpage";
	}
	
	// 관리자 유저 정보 페이지 수정 admin_userpage_update
	@RequestMapping(value = "admin_userpage_update.do", method = RequestMethod.GET)
	public String adminUserpageUpdate(@RequestParam(defaultValue = "1")String userno,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "admin/admin_userpage";
		}
		adminpage = "U1";
		model.addAttribute("adminpage", adminpage);
		UserVO uservo = userDTO.noSelect(userno);
		model.addAttribute("user", uservo);
		
		return "admin/admin_userpage_update";
	}
	// 관리자 유저 정보 수정 
	@RequestMapping(value = "admin_update_user.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminUpdateUser(String userno, String adminmemo) {
		System.out.println(userno + " " + adminmemo);
		userDTO.adminUpdateUser(userno, adminmemo);
		return "true";
	}
	// 관리자 탈퇴 유저 관리 
	@RequestMapping(value = "admin_userX.do", method = RequestMethod.GET)
	public String adminUserX(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "U2")String adminpage,
			@RequestParam(defaultValue = "")String searchname,@RequestParam(defaultValue = "")String keyword) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "U2";
		model.addAttribute("adminpage", adminpage);
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setIsretire("Y");
		//전체 게시물
		sv.setTotal(userDTO.getTotal(sv));
		
		List<UserVO> list = userDTO.getUserList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("userlist", list);
		return "admin/admin_userX";
	}
	
	// 관리자 유저 완전삭제 
	@RequestMapping(value = "admin_users_drop.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminUsersDrop(@RequestParam(value = "userno", required = false)List<String> userno) {
		if(userno == null) {
			return "false";
		}
		
		for (String no : userno) {
			System.out.println(no);
			userDTO.userDrop(no);
		}
		
		return "true";
	}
	
	// 관리자 유저 복원 
	@RequestMapping(value = "admin_users_restore.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminUsersRestore(@RequestParam(value = "userno", required = false)List<String> userno) {
		if(userno == null) {
			return "false";
		}
		
		for (String no : userno) {
			System.out.println(no);
			userDTO.userRestore(no);
		}
		
		return "true";
	}
	
	// 관리자 주문 관리 admin_order.do
	@RequestMapping(value = "admin_order.do", method = RequestMethod.GET)
	public String adminOrder(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "O")String adminpage,
			@RequestParam(defaultValue = "N")String searchname,@RequestParam(defaultValue = "")String keyword
			) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "O";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		
		//전체 게시물
		sv.printinfo();
		sv.setTotal(itemDTO.getOrderTotalA(sv));
		System.out.println(sv.getTotal());
		List<OrderVO> list = itemDTO.getOrderListA(sv);
		
		for (OrderVO orderVO : list) {
			orderVO.printinfo();
		}
		
		model.addAttribute("search", sv);
		model.addAttribute("orderlist", list);
		
		return "admin/admin_order";
	}
	
	// 관리자 주문 상세페이지
	@RequestMapping(value = "admin_orderpage.do", method = RequestMethod.GET)
	public String adminOrderPage(String orderno, Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "O";
		model.addAttribute("adminpage", adminpage);
		
		OrderVO orderVO =  itemDTO.getOrder(orderno);
		PayVO payVO = itemDTO.getPay(orderno);
		ItemVO itemVO = itemDTO.getItem(""+orderVO.getOitemno());
		UserVO userVO = userDTO.getUserInfo(orderVO.getOuserno());
		
		System.out.println("주문상세페이지 목록");
		orderVO.printinfo();
		payVO.printinfo();
		itemVO.printinfo();
		System.out.println("주문상세페이지 목록 끝");
		
		model.addAttribute("order", orderVO);
		model.addAttribute("pay", payVO);
		model.addAttribute("item", itemVO);
		model.addAttribute("user", userVO);
		return "admin/admin_orderpage";
	}
	
	// 관리자 주문 수정 페이지 admin_orderpage_update
	@RequestMapping(value = "admin_orderpage_update.do", method = RequestMethod.GET)
	public String adminOrderPageUpdate(String orderno, Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "O";
		model.addAttribute("adminpage", adminpage);
		
		OrderVO orderVO =  itemDTO.getOrder(orderno);
		PayVO payVO = itemDTO.getPay(orderno);
		ItemVO itemVO = itemDTO.getItem(""+orderVO.getOitemno());
		
		System.out.println("주문상세페이지 목록");
		orderVO.printinfo();
		payVO.printinfo();
		itemVO.printinfo();
		System.out.println("주문상세페이지 목록 끝");
		
		model.addAttribute("order", orderVO);
		model.addAttribute("pay", payVO);
		model.addAttribute("item", itemVO);
		return "admin/admin_orderpage_update";
	}
	
	// 관리자 주문 수정 동작 admin_update_order.do
	@RequestMapping(value = "admin_update_order.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminUpdateOrder(OrderVO vo,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		vo.printinfo();
		userDTO.adminUpdateOrder(vo);
		return "true";
	}
	
	
	// 관리자 상품 목록 
	@RequestMapping(value = "admin_productAll.do", method = RequestMethod.GET)
	public String AdminProductAll(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "P1")String adminpage,
			@RequestParam(defaultValue = "N")String searchname,@RequestParam(defaultValue = "")String keyword
			) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P1";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		
		//전체 게시물
		sv.setTotal(itemDTO.getTotal(sv));

		List<ItemVO> list = itemDTO.getItemList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("itemlist", list);
		
		
		return "admin/admin_productAll";
	}
	// 관리자 상품 상세 페이지 admin_product_view.do
	@RequestMapping(value = "admin_product_view.do", method = RequestMethod.GET)
	public String adminProductView(@RequestParam(defaultValue = "1")String itemno,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P1";
		model.addAttribute("adminpage", adminpage);
		
		ItemVO itemvo = itemDTO.getItem(itemno);
		
		List<FileVO> filelist = fileDTO.getFileList(itemno);
		
		itemvo.printinfo();
		model.addAttribute("item", itemvo);
		model.addAttribute("filelist", filelist);
		return "admin/admin_product_view";
	}
	// 다운
	@RequestMapping(value = "/down.do", method = RequestMethod.GET)
	public void displayImage(@RequestParam("name") String fileName, @RequestParam("file") String saveName, HttpServletResponse response, HttpServletRequest request) throws Exception {
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		System.out.println("파일경로 : " + uploadPath);

		File file = new File(uploadPath, saveName);

	    // 파일명 인코딩 (한글 파일명을 정상적으로 동작하도록 해준다)
	    String encodedFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");

	    // 이미지의 MIME 타입 설정
	    String contentType = Files.probeContentType(file.toPath()); // Java 7 이상에서 사용 가능
	    if (contentType == null) {
	        contentType = "application/octet-stream";
	    }
	    response.setContentType(contentType);

	    // 파일 다운로드 설정
	    response.setContentLength((int) file.length());
	    response.setHeader("Content-Disposition", "inline;filename=\"" + encodedFileName + "\"");

	    // 파일 내용을 OutputStream으로 전송
	    OutputStream os = response.getOutputStream();
	    FileInputStream fis = new FileInputStream(file);
	    FileCopyUtils.copy(fis, os);

	    fis.close();
	    os.close();
	}

	
	
	
	// 관리자 상품 등록 
	@RequestMapping(value = "admin_product_write.do", method = RequestMethod.GET)
	public String AdminProductWrite(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P2";
		model.addAttribute("adminpage", adminpage);
		return "admin/admin_product_write";
	}
	
	// 관리자 상품 등록 동작
	@RequestMapping(value = "admin_product_write_ok.do", method = RequestMethod.POST)
	public String AdminProductWriteOK(ItemVO vo,@RequestParam("thumbnail") MultipartFile thumbnail,@RequestParam("files") MultipartFile[] files,Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P2";
		model.addAttribute("adminpage", adminpage);
		
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		System.out.println("파일경로 : " + uploadPath);
		
		// 썸네일 이미지 (단일)파일처리
		// 원본 파일 이름 알아오기
		String originalFileName = thumbnail.getOriginalFilename();
		System.out.println("originalFileName : " + originalFileName);
		
		// 동일한 파일이 저장 되면 문제가 생기므로, UUID로 파일명 변경
		UUID uuid = UUID.randomUUID();
		String savedFileName = uuid.toString();
		System.out.println("savedFileName : " + savedFileName);
		
		//파일 이름을 생성
		File newFile = new File(uploadPath + savedFileName);
		
		//파일을 업로드 디렉토리에 저장한다.
		thumbnail.transferTo(newFile);
		
		vo.setThumbnailF(originalFileName);
		vo.setThumbnailP(savedFileName);
		
		vo.setIuserno(login.getUserno());
		vo.setEntityid(2);
		vo.printinfo();
		
		itemDTO.writeItem(vo);
		
		System.out.println("no값"+vo.getItemno());
		
		// 상품 이미지 (다중)파일처리
		List<FileVO> list = new ArrayList<FileVO>();
		for(MultipartFile file : files) {
			// 원본 파일 이름 알아오기
			originalFileName = file.getOriginalFilename();
			System.out.println("originalFileName" + originalFileName);
			
			// 동일한 파일이 저장 되면 문제가 생기므로, UUID로 파일명 변경
			uuid = UUID.randomUUID();
			savedFileName = uuid.toString();
			System.out.println("savedFileName" + savedFileName);
			
			//파일 이름을 생성
			newFile = new File(uploadPath + savedFileName);
			
			//파일을 업로드 디렉토리에 저장한다.
			file.transferTo(newFile);
			
			FileVO filevo = new FileVO();
			filevo.setBfname(originalFileName);
			filevo.setBpname(savedFileName);
			filevo.setEntityid(2);
			filevo.setFitemno(vo.getItemno());
			filevo.printinfo();
			list.add(filevo);
			fileDTO.upload(filevo);
			
		}
		return "redirect:admin_product_view.do?itemno=" + vo.getItemno();
	}
	
	// 관리자 상품 정보 수정
	@RequestMapping(value = "admin_product_update.do", method = RequestMethod.GET)
	public String adminProductUpdate(@RequestParam(defaultValue = "1")String itemno,Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P1";
		model.addAttribute("adminpage", adminpage);
		
		ItemVO itemvo = itemDTO.getItem(itemno);
		
		List<FileVO> filelist = fileDTO.getFileList(itemno);
		
		itemvo.printinfo();
		model.addAttribute("item", itemvo);
		model.addAttribute("filelist", filelist);
		return "admin/admin_product_update";
	}
	
	// 관리자 상품 정보 수정 동작 admin_product_update_ok.do
	@RequestMapping(value = "admin_product_update_ok.do", method = RequestMethod.POST)
	public String AdminProductUpdateOK(ItemVO vo,@RequestParam("thumbnail") MultipartFile thumbnail,@RequestParam("files") MultipartFile[] files,Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "P1";
		model.addAttribute("adminpage", adminpage);
		
		 if (!thumbnail.isEmpty()) {
			// 썸네일 이미지 (단일)파일처리
			// 원본 파일 이름 알아오기
			String originalFileName = thumbnail.getOriginalFilename();
			System.out.println("originalFileName : " + originalFileName);
			
			// 동일한 파일이 저장 되면 문제가 생기므로, UUID로 파일명 변경
			UUID uuid = UUID.randomUUID();
			String savedFileName = uuid.toString();
			System.out.println("savedFileName : " + savedFileName);
			
			//파일 이름을 생성
			File newFile = new File(uploadPath + savedFileName);
			
			//파일을 업로드 디렉토리에 저장한다.
			thumbnail.transferTo(newFile);
			
			vo.setThumbnailF(originalFileName);
			vo.setThumbnailP(savedFileName);
		 }
			vo.setIuserno(login.getUserno());
			vo.setEntityid(2);
			vo.printinfo();
			
			itemDTO.updateItem(vo);
			System.out.println("no값"+vo.getItemno());
		
			if(!files[0].isEmpty()) {
				fileDTO.fileDelete(vo.getItemno());
			}
	    for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	        	// 원본 파일 이름 알아오기
				String originalFileName = file.getOriginalFilename();
				System.out.println("originalFileName" + originalFileName);
				
				// 동일한 파일이 저장 되면 문제가 생기므로, UUID로 파일명 변경
				UUID uuid = UUID.randomUUID();
				String savedFileName = uuid.toString();
				System.out.println("savedFileName" + savedFileName);
				
				//파일 이름을 생성
				File newFile = new File(uploadPath + savedFileName);
				
				//파일을 업로드 디렉토리에 저장한다.
				file.transferTo(newFile);
				
				FileVO filevo = new FileVO();
				filevo.setBfname(originalFileName);
				filevo.setBpname(savedFileName);
				filevo.setEntityid(2);
				filevo.setFitemno(vo.getItemno());
				filevo.printinfo();
				fileDTO.itemUpdateFile(filevo);
	        }
	    }
		
		return "redirect:admin_product_view.do?itemno=" + vo.getItemno();
	}
	
	// 관리자 상품 삭제
	@RequestMapping(value = "admin_items_drop.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminItemsDrop(@RequestParam(value = "itemno", required = false)List<String> itemno) {
		if(itemno == null) {
			return "false";
		}
		
		for (String no : itemno) {
			System.out.println(no);
			fileDTO.fileDelete(Integer.parseInt(no));
			itemDTO.itemDrop(no);
		}
		
		return "true";
	}
	
	// 관리자 게시판 글 목록 admin_board.do
	@RequestMapping(value = "admin_board.do", method = RequestMethod.GET)
	public String adminBoard(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "B")String adminpage,
			@RequestParam(defaultValue = "N")String searchname,@RequestParam(defaultValue = "")String keyword
			) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "B";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		
		//전체 게시물
		sv.setTotal(userDTO.getBoardTotal(sv));
		
		List<BoardVO> list = userDTO.getBoardList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("boardlist", list);
		
		return "admin/admin_board";
	}
	
	// 관리자 게시글 삭제 admin_boards_drop
	@RequestMapping(value = "admin_boards_drop.do", method = RequestMethod.POST)
	@ResponseBody
	public String adminBoardsDrop(@RequestParam(value = "bno", required = false)List<String> bno) {
		if(bno == null) {
			return "false";
		}
		
		for (String no : bno) {
			System.out.println(no);
			fileDTO.BoardsFileDelete(no);
			userDTO.BoardsDelete(no);
		}
		
		return "true";
	}
	
	
	
	/*
	 마이페이지
	        */
	
	// 유저 마이페이지 글 목록 user_write_list.do
	@RequestMapping(value = "user_write_list.do", method = RequestMethod.GET)
	public String userWriteList(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "")String searchname,@RequestParam(defaultValue = "")String keyword) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "W";
		model.addAttribute("adminpage", adminpage);
		
		BSearchVO sv = new BSearchVO();
		sv.setBuserno(Integer.parseInt(login.getUserno()));
		sv.nsetPageno(page);
		sv.setSena(searchname);
		sv.setKeyword(keyword);
		
		// 유저 전체 게시글
		int total = boardDTO.uNameGetTotal(sv);
		sv.setTotal(total);
		//전체 게시글
		List<BoardVO> list = boardDTO.uNameGetList(sv);
		for(BoardVO a : list)
		{
			System.out.println("list의 값 : " + a);
		}
		
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		
		return "user/user_write_list";
	}
	
	// 유저 마이페이지 주문목록 
	@RequestMapping(value = "user_order_list.do", method = RequestMethod.GET)
	public String userOrderList(Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1")int page,@RequestParam(defaultValue = "O")String adminpage,
			@RequestParam(defaultValue = "O")String searchname,@RequestParam(defaultValue = "")String keyword
			) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "O";
		model.addAttribute("adminpage", adminpage);
		
		SearchVO sv = new SearchVO();
		sv.setAdminpage(adminpage); // 페이지 종류
		sv.setPageno(page); // 페이지번호
		sv.setSearchname(searchname); // 검색 종류
		sv.setKeyword(keyword);
		sv.setSuserno(Integer.parseInt(login.getUserno()));
		
		//전체 게시물
		sv.printinfo();
		sv.setTotal(itemDTO.getOrderTotal(sv));
		System.out.println(sv.getTotal());
		List<OrderVO> list = itemDTO.getOrderList(sv);
		
		for (OrderVO orderVO : list) {
			orderVO.printinfo();
		}
		
		model.addAttribute("search", sv);
		model.addAttribute("orderlist", list);

		
		
		return "user/user_order_list";
	}
	// 유저 마이페이지 주문상세페이지 user_orderpage.do
	@RequestMapping(value = "user_orderpage.do", method = RequestMethod.GET)
	public String userOrderpage(String orderno, Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "O";
		model.addAttribute("adminpage", adminpage);
		
		OrderVO orderVO =  itemDTO.getOrder(orderno);
		PayVO payVO = itemDTO.getPay(orderno);
		ItemVO itemVO = itemDTO.getItem(""+orderVO.getOitemno());
		UserVO userVO = userDTO.getUserInfo(orderVO.getOuserno());
		
		System.out.println("주문상세페이지 목록");
		orderVO.printinfo();
		payVO.printinfo();
		itemVO.printinfo();
		System.out.println("주문상세페이지 목록 끝");
		
		model.addAttribute("order", orderVO);
		model.addAttribute("pay", payVO);
		model.addAttribute("item", itemVO);
		model.addAttribute("user", userVO);
		return "user/user_orderpage";
	}
	
	// 유저 마이페이지 패스워드 확인(정보수정시) 
	@RequestMapping(value = "user_check.do", method = RequestMethod.GET)
	public String userCheck(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "M";
		model.addAttribute("adminpage", adminpage);
		return "user/user_check";
	}
	
	// 유저 마이페이지 내정보 
	@RequestMapping(value = "user_info.do", method = RequestMethod.GET)
	public String userInfo(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "M";
		model.addAttribute("adminpage", adminpage);
		return "user/user_info";
	}
	
	// 유저 이름 변경
	@RequestMapping(value = "name_choku.do", method = RequestMethod.POST)
	public String nameChokU(String userno, String uname, HttpServletRequest request, Model model) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		adminpage = "M";
		userDTO.nameUpdate(userno, uname);
		login = userDTO.noSelect(userno);
		model.addAttribute("adminpage", adminpage);
		request.getSession().setAttribute("login",login);
		return "user/user_info";
	}
	
	// 유저 이메일 변경 
	@RequestMapping(value = "email_chang.do", method = RequestMethod.GET)
	public String emailChang(HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		return "user/email_chang";
	}
	
	// 현재 이메일 확인 
	@RequestMapping(value = "use_mail_check.do", method = RequestMethod.POST)
	@ResponseBody
	public String useMailCheck(String email, String userno, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		int count = userDTO.useMailCheck(email, userno);
		if(count == 0) {
			return "false";
		}else {
			return "true";
		}
	}
	
	// 이메일 변경 동작 email_change_ok.do
	@RequestMapping(value = "email_change_ok.do", method = RequestMethod.POST)
	public String emailChangeOK(String userno, String nemail, HttpServletRequest request, Model model) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		if(login == null) {
			return "redirect:index.do";
		}
		userDTO.mailUpdate(userno, nemail);
		login = userDTO.noSelect(userno);
		request.getSession().setAttribute("login",login);
		adminpage = "M";
		model.addAttribute("adminpage", adminpage);
		return "user/user_info";
	}
	
	
	// 비밀번호 변경 
	@RequestMapping(value = "email_update.do", method = RequestMethod.POST)
	public String emailUpdate(String userno, String npw, HttpServletRequest request) {
		System.out.println(userno + " " + npw);
		userDTO.PwUpdate(userno, npw);
		request.getSession().invalidate();
		return "user/pwc_ok";
	}
	
	// 회원탈퇴 팝업 창 
	@RequestMapping(value = "user_delete.do", method = RequestMethod.GET)
	public String userDelete() {
		return "user/user_delete";
	}
	
	// 회원탈퇴 동작 delete_user
	@RequestMapping(value = "user_deleteOK.do")
	public String userDelete(String userno, HttpServletRequest request) {
		String reason = "직접탈퇴";
		userDTO.userDelete(userno,reason);
		request.getSession().invalidate();
		return "user/user_deleteOK";
	}
	
	// 스마트에디터 업로드
	@RequestMapping(value = "/smarteditorMultiImageUpload", method = RequestMethod.POST)
	public void smarteditorMultiImageUpload(HttpServletRequest request, HttpServletResponse response) {
	    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/smartupload/");
	    System.out.println("Upload Path: " + uploadPath);

	    try {
	        // 파일 정보
	        String sFileInfo = "";
	        String sFilename = request.getHeader("file-name");

	        if (sFilename == null) {
	            response.getWriter().print("File name is missing.");
	            return;
	        }

	        // 파일 확장자 검증
	        String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".") + 1).toLowerCase();
	        String[] allowFileArr = {"jpg", "png", "bmp", "gif", "jpeg"};
	        boolean isAllowed = Arrays.asList(allowFileArr).contains(sFilenameExt);

	        if (!isAllowed) {
	            response.getWriter().print("NOTALLOW_" + sFilename);
	            return;
	        }

	        // 디렉토리 설정 및 파일 저장
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }

	        String sRealFileNm = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()) 
	                             + UUID.randomUUID().toString() 
	                             + sFilename.substring(sFilename.lastIndexOf("."));
	        File file = new File(uploadDir, sRealFileNm);

	        // 서버에 파일 쓰기
	        InputStream inputStream = null;
	        OutputStream outputStream = null;
	        try {
	            inputStream = request.getInputStream();
	            outputStream = new FileOutputStream(file);
	            byte[] buffer = new byte[1024];
	            int bytesRead;
	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	            response.getWriter().print("ERROR: " + e.getMessage());
	            return;
	        } finally {
	            // 리소스 닫기
	            try {
	                if (inputStream != null) {
	                    inputStream.close();
	                }
	                if (outputStream != null) {
	                    outputStream.close();
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }

	        // 이미지 정보 출력
	        String sFileURL = request.getContextPath() + "/resources/smartupload/" + sRealFileNm;
	        sFileInfo += "&bNewLine=true";
	        sFileInfo += "&sFileName=" + sFilename;
	        sFileInfo += "&sFileURL=" + sFileURL;

	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter printWriter = response.getWriter();
	        printWriter.print(sFileInfo);
	        printWriter.flush();
	        printWriter.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	        try {
	            response.getWriter().print("ERROR: " + e.getMessage());
	        } catch (IOException ioException) {
	            ioException.printStackTrace();
	        }
	    }
	}


	

}
