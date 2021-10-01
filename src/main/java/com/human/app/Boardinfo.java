package com.human.app;

public class Boardinfo {
	private int bbs_id;
	private String title;
	private String content;
	private String writer;
	private String created;
	private String updated;
	public Boardinfo() {}
	public Boardinfo(int bbs_id, String title, String content, String writer, String created,
			String updated) {
		this.bbs_id = bbs_id;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.created = created;
		this.updated = updated;
	}
	public int getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(int bbs_id) {
		this.bbs_id = bbs_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
