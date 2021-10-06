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
	public String home(Paging vo, Model model, HttpServletRequest hsr
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage
			, @RequestParam(value="search_type",required = false) String search_type
			, @RequestParam(value="search_keyword",required = false) String search_keyword) {
			Board board = sqlSession.getMapper(Board.class);
			
			

			int total = board.countBoard(vo);
			
			System.out.println(total);
			if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		vo = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage),search_type,search_keyword);
		model.addAttribute("paging", vo);
		model.addAttribute("viewAll", board.selectBoard(vo));
		System.out.println(vo.getSearch_keyword());

		
		
		return "home";
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam("bbs_id") int bbs_id,HttpServletRequest hsr,Model model) {
		//model.addAttribute("bbs_id", bbs_id);
		Board board = sqlSession.getMapper(Board.class);
		Boardinfo boardinfo = board.getBoardView(bbs_id);
		model.addAttribute("board", boardinfo);
		return "view";
	}
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write() {
		
		
		return "write";
	}
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(@RequestParam("bbs_id") int bbs_id,Model model) {
		//model.addAttribute("bbs_id", bbs_id);
		Board board = sqlSession.getMapper(Board.class);
		Boardinfo boardinfo = board.getBoardView(bbs_id);
		model.addAttribute("board", boardinfo);
		return "update";
	}
	@RequestMapping(value = "newbie", method = RequestMethod.GET)
	public String newbie() {
		
		
		return "newbie";
	}
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest hsr) {
		session = hsr.getSession();
		session.invalidate();
		
		return "redirect:/";
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
	/*
	 * @RequestMapping(value="/getBoardList", method= RequestMethod.POST, produces =
	 * "application/text; charset=utf8")
	 * 
	 * @ResponseBody public String getRoomList(HttpServletRequest hsr) { Board board
	 * = sqlSession.getMapper(Board.class); ArrayList<Boardinfo> boardinfo =
	 * board.getBoardList();
	 * 
	 * JSONArray ja = new JSONArray();
	 * 
	 * for(int i=0; i<boardinfo.size(); i++) { JSONObject jo = new JSONObject();
	 * 
	 * jo.put("bbs_id", boardinfo.get(i).getBbs_id()); jo.put("title",
	 * boardinfo.get(i).getTitle()); jo.put("content",
	 * boardinfo.get(i).getContent()); jo.put("writer",
	 * boardinfo.get(i).getWriter()); jo.put("created",
	 * boardinfo.get(i).getCreated()); jo.put("updated",
	 * boardinfo.get(i).getUpdated()); ja.add(jo);
	 * 
	 * }
	 * 
	 * return ja.toString(); }
	 */
	
	@RequestMapping(value="/getBoardView", method= RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String getRoomView(HttpServletRequest hsr) {
		Board board = sqlSession.getMapper(Board.class);
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		Boardinfo boardinfo = board.getBoardView(bbs_id);
		
		JSONArray ja = new JSONArray();
		
		
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
		session.setAttribute("nonmember", "���̵�� ��й�ȣ�� Ȯ�����ּ���.");
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
	
	@RequestMapping(value="/doWrite", method=RequestMethod.POST)
	public  String doWrite(HttpServletRequest hsr) {
		
		String name = (String)session.getAttribute("loginid");
		String content = hsr.getParameter("content");
		String title = hsr.getParameter("title");
		Board board = sqlSession.getMapper(Board.class);
		board.doWrite(title,content,name);
		return "home";
	}
	@RequestMapping(value="/doUpdate", method=RequestMethod.POST)
	public  String doUpdate(HttpServletRequest hsr) {
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		String content = hsr.getParameter("content");
		String title = hsr.getParameter("title");
		Board board = sqlSession.getMapper(Board.class);
		board.doUpdate(bbs_id,title,content);
		return "home";
	}
	@RequestMapping(value="/doDelete", method=RequestMethod.POST)
	public  String doDelete(HttpServletRequest hsr) {
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		
		Board board = sqlSession.getMapper(Board.class);
		board.doDelete(bbs_id);
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
