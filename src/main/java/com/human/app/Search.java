package com.human.app;

public class Search extends Paging{
	private String search_type;
	private String search_keyword;
	
	public Search() {}
	
	public Search(String search_type, String search_keyword) {
		this.search_type = search_type;
		this.search_keyword = search_keyword;
	}
	
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_keyword() {
		return search_keyword;
	}
	public void setSearch_keyword(String search_keyword) {
		this.search_keyword = search_keyword;
	}
}
