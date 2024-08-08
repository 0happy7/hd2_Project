package com.hd.control;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hd.dto.BoardDTO;
import com.hd.dto.ReplyDTO;
import com.hd.dto.UserDTO;
import com.hd.vo.BoardVO;
import com.hd.vo.BSearchVO;
import com.hd.vo.UserVO;
import com.hd.vo.*;


@Controller
public class BoardController {
	
	private static final String uploadPath = "D:\\skm\\Spring\\Spring_hd_08\\src\\main\\webapp\\resources\\upload\\";
	
	@Autowired
	BoardDTO boardDTO;
	
	@Autowired
	ReplyDTO replyDTO;
	@Autowired
	UserDTO userDTO;
	
	@Autowired
    private BoardService boardService;
	
	// food
	@RequestMapping(value = "food.do", method = RequestMethod.GET)
	public String Food(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "F")String kind, @RequestParam(defaultValue = "전체") String area, @RequestParam(defaultValue = "")String searchname, @RequestParam(defaultValue = "") String keyword, Model model)
	{
		BSearchVO sv = new BSearchVO();
		
		// 페이지 번호
		sv.setPageno(page);
		
		// 게시물 종류
		sv.setKind(kind);
		
		// 지역 설정
		sv.setArea(area);
		sv.setSena(searchname);
		sv.setKeyword(keyword);
		
		// 전체 게시물 갯수
		int total = boardDTO.GetTotal(sv);
		
		sv.setTotal(total);
		
		//전체 게시글
		List<BoardVO> list = boardDTO.GetList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		
		return "food/food";
	}
	
	// food
	@RequestMapping(value = "food_update.do", method = RequestMethod.GET)
	public String FoodUpdate(String no, Model model)
	{
		BoardVO vo = boardDTO.Read(no, false);
		System.out.println("food update 값 확인 : " + vo.toString());
		model.addAttribute("item", vo);
		
		return "food/food_update";
	}
	
	// food
	@RequestMapping(value = "food_updateok.do", method = RequestMethod.POST)
	public String FoodUpdateOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		
		vo.setUserno(login.getUserno());
		
		String abc = vo.getAddr();
        String[] abc1 = abc.split(" ");
        vo.setArea(abc1[1]);
        
        boardService.updateBoard(vo, files);

        return "redirect:food_view.do?no=" + vo.getBno();
	}
	
	// food
	@RequestMapping(value = "food_write.do", method = RequestMethod.GET)
	public String FoodWrite()
	{
		return "food/food_write";
	}
	
	// 음식 글쓰기 완료
		@RequestMapping(value = "/food_writeok.do", method = RequestMethod.POST)
		public String Food_WriteOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException
		{
			UserVO login = (UserVO) request.getSession().getAttribute("login");
	        if (login == null)
	        {
	            return "redirect:food.do";
	        }

	        vo.setUserno(login.getUserno());
	        vo.setName(login.getUname());   
	        
	        String abc = vo.getAddr();
	        String[] abc1 = abc.split(" ");
	        vo.setArea(abc1[1]);
	        
	        System.out.println("vo의 내용은 : " + vo.getUserno());
	        System.out.println("vo의 내용은 : " + vo);
	        boardService.insertBoard(vo, files);
	        System.out.println("vo의 2번내용은 : " + vo.getBcontent());

	        return "redirect:food_view.do?no=" + vo.getBno();
			
		}
	
	// food
	@RequestMapping(value = "food_view.do", method = RequestMethod.GET)
	public String FoodView(String no, Model model)
	{
		/*if(no == null)
		{
			return "redirect:index.do";
		}*/
		
		BoardVO vo = boardDTO.Read(no, true);
		List<ReplyVO> rvo = replyDTO.GetList(no);
		
		model.addAttribute("item", vo);		
		model.addAttribute("reply", rvo);
		
		return "food/food_view";
	}
	
	// food
	@RequestMapping(value = "food_delete.do")
	public String Food_Delete(String no, HttpServletResponse response)
	{
		if(no == null)
		{	
			return "redirect:food.do";
		} 
		// + 나머지도 포함
		
		boardDTO.Delete(no);
		return "redirect:food.do";
	}
	
	// notice
	@RequestMapping(value = "notice.do", method = RequestMethod.GET)
	public String Notice(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "N")String kind, @RequestParam(defaultValue = "")String searchname, @RequestParam(defaultValue = "") String keyword, Model model, HttpServletRequest request)
	{
		BSearchVO sv = new BSearchVO();
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		
		if(login != null)
		{
			sv.setUgrade(login.getUgrade());
		}
		
		
		// 페이지 번호
		sv.nsetPageno(page);
		
		// 게시물 종류
		sv.setKind(kind);
		
		sv.setSena(searchname);
		sv.setKeyword(keyword);
		
		System.out.println("sv의 등급 : " + sv.getUgrade());
		
		// 전체 게시물 갯수
		int total = boardDTO.NGetTotal(sv);
		
		sv.nsetTotal(total);
		
		//전체 게시글
		List<BoardVO> list = boardDTO.NGetList(sv);
		
		model.addAttribute("nsearch", sv);
		model.addAttribute("nlist", list);
				
		return "notice/notice";
	}
	
	// notice
	@RequestMapping(value = "notice_view.do", method = RequestMethod.GET)
	public String NoticeView(String no, Model model)
	{
		System.out.println("call : notice_view.do");
		/*if(no == null)
		{
			return "redirect:index.do";
		}*/
		System.out.println("no값 : " + no);
		BoardVO vo = boardDTO.Read(no, true);
		if(vo == null)
		{
			System.out.println("조회된 글 없음");
		}else {
			System.out.println("조회된 글 제목 : " + vo.getBname());
			System.out.println("bno값 : " + vo.getBno());
		}
		
		if(vo.getFiles()!= null)
		{
			for(FileVO item : vo.getFiles() )
			{
				System.out.println(vo.getBno());
				System.out.println(item.toString());
			}
		}else {
			System.out.println("파일 목록 없음");
		}
		model.addAttribute("item", vo);				
		
		return "notice/notice_view";
	}
	
	// notice
	@RequestMapping(value = "notice_write.do", method = RequestMethod.GET)
	public String NoticeWrite()
	{
		return "notice/notice_write";
	}
	
	@RequestMapping(value = "notice_writeok.do", method = RequestMethod.POST)
	public String NoticeWriteOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException
	{
		UserVO login = (UserVO) request.getSession().getAttribute("login");
        if (login == null)
        {
            return "redirect:notice.do";
        }

        vo.setUserno(login.getUserno());
        
        boardService.insertBoard(vo, files);

        return "redirect:notice_view.do?no=" + vo.getBno();
	}
	
	// notice
	@RequestMapping(value = "notice_update.do", method = RequestMethod.GET)
	public String NoticeUpdate(String no, Model model)
	{
		BoardVO vo = boardDTO.Read(no, false);
		model.addAttribute("item", vo);		
		
		return "notice/notice_update";
	}
	
	// notice
	@RequestMapping(value = "notice_updateok.do", method = RequestMethod.POST)
	public String NoticeUpdateOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		
		vo.setUserno(login.getUserno());
        
        boardService.updateBoard(vo, files);

        return "redirect:notice_view.do?no=" + vo.getBno();
	}
	
	@RequestMapping(value = "notice_delete.do")
	public String Notice_Delete(String no, HttpServletResponse response)
	{
		if(no == null)
		{	
			return "redirect:notice.do";
		} 
		// + 나머지도 포함
		
		boardDTO.Delete(no);
		return "redirect:notice.do";
	}
	
	// trip
	@RequestMapping(value = "trip.do", method = RequestMethod.GET)
	public String Trip(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "T")String kind, @RequestParam(defaultValue = "전체") String area, @RequestParam(defaultValue = "")String searchname, @RequestParam(defaultValue = "") String keyword, Model model)
	{
		BSearchVO sv = new BSearchVO();
		
		// 페이지 번호
		sv.setPageno(page);
		
		// 게시물 종류
		sv.setKind(kind);
		
		// 지역 설정
		sv.setArea(area);
		sv.setSena(searchname);
		sv.setKeyword(keyword);
		
		// 전체 게시물 갯수
		int total = boardDTO.GetTotal(sv);
		
		sv.setTotal(total);
		
		//전체 게시글
		List<BoardVO> list = boardDTO.GetList(sv);
		
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		
		return "trip/trip";
		
		
	}
	
	// trip
	@RequestMapping(value = "trip_view.do", method = RequestMethod.GET)
	public String TripView(String no, Model model)
	{
		/*if(no == null)
		{
			return "redirect:index.do";
		}*/
		BoardVO vo = boardDTO.Read(no, true);
		List<ReplyVO> rvo = replyDTO.GetList(no);
		System.out.println(vo.toString());
		
		model.addAttribute("item", vo);	
		model.addAttribute("reply", rvo);	
		
		return "trip/trip_view";
	}
	
	// trip
	@RequestMapping(value = "trip_write.do", method = RequestMethod.GET)
	public String TripWrite()
	{
		return "trip/trip_write";
	}
	
	// 여행 글쓰기 완료
	@RequestMapping(value = "/trip_writeok.do", method = RequestMethod.POST)
	public String Trip_WriteOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException
	{
		UserVO login = (UserVO) request.getSession().getAttribute("login");
        if (login == null)
        {        	
            return "redirect:trip.do";
        }
        
        vo.setUserno(login.getUserno());
        vo.setName(login.getUname());
        
        String abc = vo.getAddr();
        String[] abc1 = abc.split(" ");
        vo.setArea(abc1[1]);
        
        System.out.println("vo의 내용은 : " + vo.getUserno());
        System.out.println("vo의 내용은 : " + vo);
        boardService.insertBoard(vo, files);
        System.out.println("vo의 2번내용은 : " + vo.getBcontent());

        return "redirect:trip_view.do?no=" + vo.getBno();
		
	}
	
	// trip
	@RequestMapping(value = "trip_update.do", method = RequestMethod.GET)
	public String TripUpdate(String no, Model model)
	{
		BoardVO vo = boardDTO.Read(no, false);
		System.out.println("trip update 값 확인 : " + vo.toString());
		model.addAttribute("item", vo);	
		
		return "trip/trip_update";
	}
	
	// trip
		@RequestMapping(value = "trip_updateok.do", method = RequestMethod.POST)
		public String TripUpdateOK(BoardVO vo, @RequestParam("attach") List<MultipartFile> files, HttpServletRequest request) throws IllegalStateException, IOException {
			UserVO login = (UserVO) request.getSession().getAttribute("login");
			
			vo.setUserno(login.getUserno());
	        
			String abc = vo.getAddr();
	        String[] abc1 = abc.split(" ");
	        vo.setArea(abc1[1]);
			
	        boardService.updateBoard(vo, files);

	        return "redirect:trip_view.do?no=" + vo.getBno();
		}
	
	// food
	@RequestMapping(value = "trip_delete.do")
	public String Trip_Delete(String no, HttpServletResponse response)
	{
		if(no == null)
		{	
			return "redirect:trip.do";
		} 
		// + 나머지도 포함
		
		boardDTO.Delete(no);
		return "redirect:trip.do";
	}
		
	// 댓글 등록
	@RequestMapping(value = "trip_replyok.do", method = RequestMethod.POST, produces = "text/html; charset=utf8")
	@ResponseBody()
	public String Trip_ReplyOK(ReplyVO vo, HttpServletRequest request)
	{
		UserVO login = (UserVO)request.getSession().getAttribute("login");
		vo.setRuserno(login.getUserno());
		replyDTO.AddReply(vo);
		return "댓글이 등록되었습니다.";
	}
	
	// 댓글 등록
		@RequestMapping(value = "food_replyok.do", method = RequestMethod.POST, produces = "text/html; charset=utf8")
		@ResponseBody()
		public String Food_ReplyOK(ReplyVO vo, HttpServletRequest request)
		{
			UserVO login = (UserVO)request.getSession().getAttribute("login");
			vo.setRuserno(login.getUserno());
			replyDTO.AddReply(vo);
			return "댓글이 등록되었습니다.";
		}

	// 댓글 삭제
	@RequestMapping(value = "trip_replydeleteok.do", produces = "text/html; charset=utf8")
	@ResponseBody()
	public String trip_ReplyDelete(String rno, HttpServletResponse response)
	{
		if(rno == null)
		{	
			return "trip_view";
		} 
		// + 나머지도 포함
		
		replyDTO.Delete(rno);
		return "댓글이 삭제되었습니다.";
	}
	
	// 댓글 삭제
	@RequestMapping(value = "food_replydeleteok.do", produces = "text/html; charset=utf8")
	@ResponseBody()
	public String food_ReplyDelete(String rno, HttpServletResponse response)
	{
		if(rno == null)
		{	
			return "food_view";
		} 
		// + 나머지도 포함
		
		replyDTO.Delete(rno);
		return "댓글이 삭제되었습니다.";
	}
	
	// 인덱스 리스트 보여주기
	@RequestMapping(value = "index_list.do")
	public String Index_List(String no, @RequestParam String kind, @RequestParam String area, HttpServletResponse response, Model model)
	{
		BSearchVO sv = new BSearchVO();
		// 게시물 종류
		sv.setKind(kind);
		// 지역
		sv.setArea(area);
		
		System.out.println("종류 : " + kind);
		System.out.println("지역 : " + area);
		
		//전체 게시글
		List<BoardVO> list = boardDTO.IGetList(sv);
		for(BoardVO a : list)
		{
			System.out.println("list의 값 : " + a);
		}
						
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		return "index/item";
	}
	
	// 인덱스 리스트 보여주기
	@RequestMapping(value = "index_shop_list.do")
	public String Index_Food_List(String no, @RequestParam(defaultValue = "SC") String kind, HttpServletResponse response, Model model)
	{
		ItemVO sv = new ItemVO();
		// 게시물 종류
		sv.setCategory(kind);
		
		System.out.println("종류 : " + kind);
		
		//전체 게시글
		List<BoardVO> list = boardDTO.IfGetList(sv);
		for(BoardVO a : list)
		{
			System.out.println("list의 값 : " + a);
		}
						
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		return "index/index";
	}
	
	// 유저 글 목록
	@RequestMapping(value = "username_write_list.do", method = RequestMethod.GET)
	public String usernameWriteList(int userno,
			@RequestParam(defaultValue = "1")int page,
			@RequestParam(defaultValue = "")String searchname,
			String keyword, Model model, HttpServletRequest request)
	{
		BSearchVO sv = new BSearchVO();
		sv.setBuserno(userno);
		sv.nsetPageno(page);
		sv.setSena(searchname);
		sv.setKeyword(keyword);
		
		// 유저 이름가져오기
		String username = userDTO.getUserName(userno);
		
		// 유저 전체 게시글
		int total = boardDTO.uNameGetTotal(sv);
		sv.setTotal(total);
		//전체 게시글
		List<BoardVO> list = boardDTO.uNameGetList(sv);
		for(BoardVO a : list)
		{
			System.out.println("list의 값 : " + a);
		}
		
		model.addAttribute("userno", userno);
		model.addAttribute("username", username);
		model.addAttribute("search", sv);
		model.addAttribute("list", list);
		
		return "user/username_write_list";
	}
		
}
