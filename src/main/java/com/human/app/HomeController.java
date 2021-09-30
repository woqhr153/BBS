package com.human.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private HttpSession session;
	@Autowired
	private SqlSession sqlSession;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		
		return "home";
	}
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam("bbs_id") int bbs_id,Model model) {
		model.addAttribute("bbs_id", bbs_id);
		
		return "view";
	}
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write() {
		
		
		return "write";
	}
	@RequestMapping(value = "newbie", method = RequestMethod.GET)
	public String newbie() {
		
		
		return "newbie";
	}
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest hsr) {
		session = hsr.getSession();
		session.invalidate();
		
		return "home";
	}
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpServletRequest hsr) {
		session = hsr.getSession();
		session.invalidate();
		String referer = hsr.getHeader("Referer");
		System.out.println(referer);
		hsr.getSession().setAttribute("redirectURI", referer);
		
		return "login";
	}
	@RequestMapping(value="/getBoardList", method= RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		Board board = sqlSession.getMapper(Board.class);
		ArrayList<Boardinfo> boardinfo = board.getBoardList();
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<boardinfo.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("bbs_id", boardinfo.get(i).getBbs_id());
			jo.put("title", boardinfo.get(i).getTitle());
			jo.put("content", boardinfo.get(i).getContent());
			jo.put("writer", boardinfo.get(i).getWriter());
			jo.put("passcode", boardinfo.get(i).getPasscode());
			jo.put("created", boardinfo.get(i).getCreated());
			jo.put("updated", boardinfo.get(i).getUpdated());
			ja.add(jo);
		}
		return ja.toString();
	}
	
	@RequestMapping(value="/getBoardView", method= RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String getRoomView(HttpServletRequest hsr) {
		Board board = sqlSession.getMapper(Board.class);
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		ArrayList<Boardinfo> boardinfo = board.getBoardView(bbs_id);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<boardinfo.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("bbs_id", boardinfo.get(i).getBbs_id());
			jo.put("title", boardinfo.get(i).getTitle());
			jo.put("content", boardinfo.get(i).getContent());
			jo.put("writer", boardinfo.get(i).getWriter());
			jo.put("passcode", boardinfo.get(i).getPasscode());
			jo.put("created", boardinfo.get(i).getCreated());
			jo.put("updated", boardinfo.get(i).getUpdated());
			ja.add(jo);
		}
		return ja.toString();
	}
	@RequestMapping(value="/check_user",method= RequestMethod.POST)
	public String check_user(HttpServletRequest hsr, Model model) {
		
		String user_id = hsr.getParameter("user_id");
		String pw = hsr.getParameter("pw");
		Member member = sqlSession.getMapper(Member.class);
		int n = member.doLogin(user_id,pw);
		if(n>0) {
			session = hsr.getSession();
			session.setAttribute("loginid", user_id);
			
			String referer = (String)session.getAttribute("redirectURI");
			System.out.println(referer);
			return "redirect:"+referer;
		}
		session = hsr.getSession();
		session.setAttribute("nonmember", "아이디 또는 비밀번호를 확인해주세요.");
		return "login";
	}
	@RequestMapping(value="/signin", method=RequestMethod.POST)
	public  String doSignin(HttpServletRequest hsr) {
		String name = hsr.getParameter("user_name");
		String loginid = hsr.getParameter("user_id");
		String passcode = hsr.getParameter("pw");
		String mobile = hsr.getParameter("tel");
		Member member = sqlSession.getMapper(Member.class);
		member.doSignin(name, loginid, passcode ,mobile);	
		return "home";
	}
/*iRoom room = sqlSession.getMapper(iRoom.class);
String checkin = hsr.getParameter("checkin");
String checkout = hsr.getParameter("checkout");
int typecode = Integer.parseInt(hsr.getParameter("typecode"));
ArrayList<Roominfo> roominfo = room.getRoomList(checkin,checkout,typecode);


JSONArray ja= new JSONArray();
for(int i=0; i<roominfo.size();i++) {
	JSONObject jo = new JSONObject();
	jo.put("roomcode",roominfo.get(i).getRoomcode());
	jo.put("roomname",roominfo.get(i).getRoomname());			
	jo.put("typename",roominfo.get(i).getTypename());
	jo.put("howmany",roominfo.get(i).getHowmany());
	jo.put("howmuch",roominfo.get(i).getHowmuch());
	ja.add(jo);
		}
		return ja.toString();*/
}
