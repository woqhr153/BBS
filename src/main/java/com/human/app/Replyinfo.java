package com.human.app;

public class Replyinfo {
	private int reply_id;
	private int bbs_id;
	private String writer;
	private String content;
	private String created;
	private String updated;
	
	public Replyinfo() {}
	public Replyinfo(int reply_id, int bbs_id, String writer, String content, String created, String updated) {
		this.reply_id = reply_id;
		this.bbs_id = bbs_id;
		this.writer = writer;
		this.content = content;
		this.created = created;
		this.updated = updated;
	}
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(int bbs_id) {
		this.bbs_id = bbs_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getUpdated() {
		return updated;
	}
	public void setUpdated(String updated) {
		this.updated = updated;
	}
	
}
