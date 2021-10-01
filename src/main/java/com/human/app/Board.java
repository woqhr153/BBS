package com.human.app;

import java.util.ArrayList;

public interface Board {
	ArrayList<Boardinfo> getBoardList();
	Boardinfo getBoardView(int bbs_id);
	void doWrite(String title, String content,String name);
	void doUpdate(int bbs_id, String title, String content);
	void doDelete(int bbs_id);
}
