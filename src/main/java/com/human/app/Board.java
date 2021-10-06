package com.human.app;

import java.util.ArrayList;
import java.util.List;

public interface Board {
	ArrayList<Boardinfo> getBoardList();
	Boardinfo getBoardView(int bbs_id);
	void doWrite(String title, String content,String name);
	void doUpdate(int bbs_id, String title, String content);
	void doDelete(int bbs_id);
	// 게시물 총 갯수
	public int countBoard(Paging vo);

	// 페이징 처리 게시글 조회
	public ArrayList<Boardinfo> selectBoard(Paging vo);
	
}
