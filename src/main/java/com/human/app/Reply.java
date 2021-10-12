package com.human.app;

import java.util.ArrayList;

public interface Reply {
	ArrayList<Replyinfo>  getReplyList(int bbs_id);
	void insertReply(int bbs_id,String writer, String content);
	void updateReply(int reply_id, String content);
	void deleteReply(int reply_id);
}
