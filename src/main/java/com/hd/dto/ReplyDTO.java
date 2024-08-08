package com.hd.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hd.vo.ReplyVO;

@Repository
public class ReplyDTO
{
	@Autowired
	private SqlSession session;
	
	// 댓글 등록
	public void AddReply(ReplyVO vo)
	{
		session.insert("reply_insert", vo);
	}
	
	// 댓글 가져오기
	public List<ReplyVO> GetList(String no)
	{
		List<ReplyVO> list = session.selectList("reply_list", no);
		return list;
	}
	
	// 게시물 삭제
	public void Delete(String rno)
	{
		session.delete("reply_delete", rno);
	}
}