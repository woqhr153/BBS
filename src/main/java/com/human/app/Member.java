package com.human.app;

public interface Member {
	void doSignin(String user_name, String user_id, String passcode, String mobile);
	int doLogin(String loginid, String passcode);
}
