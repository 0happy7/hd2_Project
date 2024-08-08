package com.hd.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hd.vo.FileVO;

@Repository
public class FileDTO {
	@Autowired
	private SqlSession session;

	public void upload(FileVO filevo) {
		session.insert("upload", filevo);
	}

	public List<FileVO> getFileList(String itemno) {
		return session.selectList("getfilelist", itemno);
	}

	public void itemUpdateFile(FileVO filevo) {
		session.insert("upload", filevo);
	}

	public void fileDelete(int fitemno) {
		session.delete("itemupdatefiledel", fitemno);
		
	}

	public void NoticesFileDelete(String no) {
		session.delete("noticesfiledelete", no);
	}

	public void BoardsFileDelete(String no) {
		session.delete("boardsfiledelete", no);
		
	}
	
	
}
