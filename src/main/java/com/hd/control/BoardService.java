package com.hd.control;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hd.dto.BoardDTO;
import com.hd.vo.BoardVO;
import com.hd.vo.FileVO;

@Service
public class BoardService
{

	private static final String uploadPath = "D:\\skm\\Spring\\Spring_hd_08\\src\\main\\webapp\\resources\\upload\\";
	
	@Autowired
	BoardDTO boardDTO;

    @Transactional
    public void insertBoard(BoardVO vo, List<MultipartFile> files) throws IOException
    {
        // 게시글 정보 저장
        boardDTO.Insert(vo);

        // 첨부 파일 정보 저장
        List<FileVO> fileVOs = new ArrayList<FileVO>();
        for (MultipartFile file : files)
        {
            if (!file.isEmpty())
            {
                String originalFileName = file.getOriginalFilename();
                UUID uuid = UUID.randomUUID();
                String savedFileName = uuid.toString();

                // 파일 저장
                File newFile = new File(uploadPath + savedFileName);
                file.transferTo(newFile);

                // 파일 정보를 fileVO에 저장하여 리스트에 추가
                FileVO fileVO = new FileVO();
                fileVO.setBno(vo.getBno());
                fileVO.setBfname(originalFileName);
                fileVO.setBpname(savedFileName);
                fileVOs.add(fileVO);
            }
        }

        // 파일 정보를 file 테이블에 저장
        if (!fileVOs.isEmpty())
        {
            boardDTO.InsertFiles(fileVOs);
            
            // BoardVO에 파일 목록 설정
            vo.setFiles(fileVOs);
        }
    }
    @Transactional
    public void updateBoard(BoardVO vo, List<MultipartFile> attachFiles) throws IOException
    {
    	System.out.println("어떤값이 들어올까요? " + attachFiles);
    	// Null 체크
        if (vo == null) {
            throw new IllegalArgumentException("게시글 정보가 null입니다.");
        }
        if (attachFiles == null) {
            throw new IllegalArgumentException("첨부 파일 리스트가 null입니다.");
        }
    	
        // 게시글 정보 저장
        boardDTO.Update(vo);
        System.out.println("attach 파일 값 확인 : " + attachFiles.toString());
     // 기존 파일 정보 가져오기
        List<FileVO> existingFiles = boardDTO.getFilesByBoardNo(vo.getBno());
        System.out.println("existingFiles 값 확인 : " + existingFiles);
        System.out.println("attach empty 확인 : " + attachFiles.isEmpty());
        
     // 새로운 첨부 파일이 있는 경우에만 처리
        if (!attachFiles.isEmpty() && !attachFiles.get(0).isEmpty()) {
        	
        	// 기존 파일 삭제 조건 추가: 새로운 첨부 파일이 있는 경우에만 기존 파일 삭제
        	if (!existingFiles.isEmpty())
        	{
        	    boardDTO.DeleteFilesByBoardNo(vo.getBno());
        	}
            // 새로 추가할 파일 정보 리스트
            List<FileVO> fileVOs = new ArrayList<FileVO>();

            // 새로운 파일 저장 및 처리
            for (MultipartFile file : attachFiles) {
                if (!file.isEmpty()) {
                    String originalFilename = file.getOriginalFilename();
                    String savedFileName = saveFile(file);

                    // 파일 정보를 fileVO에 저장하여 리스트에 추가
                    FileVO fileVO = new FileVO();
                    fileVO.setBno(vo.getBno());
                    fileVO.setBfname(originalFilename);
                    fileVO.setBpname(savedFileName);
                    fileVOs.add(fileVO);
                }
            }

            // 새로 추가된 파일 정보를 DB에 저장
            boardDTO.InsertFiles(fileVOs);

            // 새로운 파일 정보를 BoardVO에 설정
            vo.setFiles(fileVOs);
        } else {
            // 첨부 파일이 없는 경우 기존 파일 정보를 그대로 유지
            vo.setFiles(existingFiles);
        }
    }
    
    private String saveFile(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("저장할 파일이 null이거나 비어 있습니다.");
        }

        String originalFilename = file.getOriginalFilename();
        UUID uuid = UUID.randomUUID();
        String savedFileName = uuid.toString();

        String uploadPath = "D:\\skm\\Spring\\Spring_hd_08\\src\\main\\webapp\\resources\\upload\\";
        
        // 임시 디렉토리에 파일 저장
        Path tempPath = Paths.get(uploadPath + "temp_" + savedFileName);
        Files.copy(file.getInputStream(), tempPath, StandardCopyOption.REPLACE_EXISTING);

        // 실제 저장할 파일 생성
        File newFile = new File(uploadPath + savedFileName);

        // 파일을 이동시켜서 저장
        Files.move(tempPath, newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

        return savedFileName;
    }
}