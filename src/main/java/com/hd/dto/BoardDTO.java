package com.hd.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hd.vo.BoardVO;
import com.hd.vo.FileVO;
import com.hd.vo.BSearchVO;
import com.hd.vo.ItemVO;


@Repository
public class BoardDTO
{
	@Autowired
	private SqlSession session;
	
	public void Insert(BoardVO vo)
	{
		session.insert("insert", vo);
	}
	
	public void InsertFiles(List<FileVO> fileVOs)
	{
		session.insert("insertFiles", fileVOs);
	}
	
	// 게시물 조회
	public BoardVO Read(String bno, boolean IsHit)
	{
		System.out.println("no의 값은...? " + bno);
		BoardVO result = session.selectOne("view", bno);
		if( result != null )
		{
			// 게시물 조회수를 증가시킨다.
			if(IsHit == true)
			{
				session.update("hit", bno);
			}
			
			// bno를 참조한 파일이 있는지 확인 -> 있으면 selectlist로 맵퍼 작성해서 fileVo의 List를 반환받아
			List<FileVO> list = session.selectList("viewfile", bno);
			result.setFiles(list);
			
			return result;
		}
		return null;
	}
	
	// 게시물 삭제
	public void Delete(String no)
	{
		// 댓글 삭제해야함.
		session.delete("delete", no);
	}
	
	public void DeleteFilesByBoardNo(String bno)
	{
	    session.delete("deleteFilesByBoardNo", bno);
	}
	
	public void Update(BoardVO vo)
	{
		session.update("update", vo);
	}
	public void UpdateFiles(List<FileVO> fileVOs)
	{
		session.update("InsertFile", fileVOs);
	}
	
	// 전체 게시물 갯수
	public int GetTotal(BSearchVO sv)
	{
		int total = session.selectOne("total", sv);
		return total;
	}
	
	public int NGetTotal(BSearchVO sv)
	{
		int ntotal = session.selectOne("ntotal", sv);
		return ntotal;
	}
	
	// 게시물 목록 조회
	public List<BoardVO> GetList(BSearchVO sv)
	{
		
		List<BoardVO> list = session.selectList("list", sv);
		return list;
	}
	
	// 게시물 목록 조회
	public List<BoardVO> NGetList(BSearchVO sv)
	{
		
		List<BoardVO> nlist = session.selectList("nlist", sv);
		return nlist;
	}
	
	// 게시물 목록 조회
	public List<BoardVO> IGetList(BSearchVO sv)
	{
		
		List<BoardVO> ilist = session.selectList("ilist", sv);
		return ilist;
	}
	
	//게시물 목록 조회
	public List<BoardVO> IfGetList(ItemVO ifg)
	{
		System.out.println("ifg의 종류 : " + ifg.getCategory());
		List<BoardVO> iflist = session.selectList("iflist", ifg);
		return iflist;
	}
	
	public List<FileVO> getFilesByBoardNo(String bno) {
        List<FileVO> list = session.selectList("getFileListByBoardNo", bno);
        return list;
    }

	public List<BoardVO> uNameGetList(BSearchVO sv) {
		return session.selectList("unamegetlist", sv);
	}

	public int uNameGetTotal(BSearchVO sv) {
		return session.selectOne("unamegettotal", sv);
	}
}