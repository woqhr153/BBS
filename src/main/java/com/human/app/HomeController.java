package com.human.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public String home(@ModelAttribute("paging") Paging paging, Model model) {
			
		if(paging.getPage() == null) {
			paging.setPage(1);
		}
		Board board = sqlSession.getMapper(Board.class);
		//pageVO의 2개변수값을 필수로 입력해야지만 페이징처리가 가능
		paging.setQueryPerPageNum(10);
		paging.setPerPageNum(5);
		int totalCount = board.countBoard(paging);
		paging.setTotalCount(totalCount);//여기에서 startPage,endPage,prev,next변수값이 발생됨
		ArrayList<Boardinfo> boardList = board.selectBoard(paging);
		model.addAttribute("boardList", boardList);

		
		
		return "home";
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam("bbs_id") int bbs_id,HttpServletRequest hsr,Model model
			, @RequestParam(value="page", required=false)String page
			
			, @RequestParam(value="search_type",required = false) String search_type
			, @RequestParam(value="search_keyword",required = false) String search_keyword
			) {
		model.addAttribute("bbs_id", bbs_id);
		Reply reply =sqlSession.getMapper(Reply.class);
		ArrayList<Replyinfo> replyList = reply.getReplyList(bbs_id);
		model.addAttribute("replyList", replyList);
		Board board = sqlSession.getMapper(Board.class);
		Boardinfo boardinfo = board.getBoardView(bbs_id);
		model.addAttribute("board", boardinfo);
		model.addAttribute("page", page);
		model.addAttribute("search_type", search_type);
		model.addAttribute("search_keyword", search_keyword);
		return "view";
	}
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write(HttpServletRequest hsr, Model model
			, @RequestParam(value="page", required=false)String page
			, @RequestParam(value="search_type",required = false) String search_type
			, @RequestParam(value="search_keyword",required = false) String search_keyword
			) {
		session = hsr.getSession();
		
		model.addAttribute("page", page);
		model.addAttribute("search_type", search_type);
		model.addAttribute("search_keyword", search_keyword);
		String loginid = (String)session.getAttribute("loginid");
		if(loginid==null) {
			return "redirect:/";
		}
		return "write";
	}
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(@RequestParam("bbs_id") int bbs_id, HttpServletRequest hsr
			, Model model
			, @RequestParam(value="page", required=false)String page
			, @RequestParam(value="search_type",required = false) String search_type
			, @RequestParam(value="search_keyword",required = false) String search_keyword
			) {
		
		model.addAttribute("bbs_id", bbs_id);
		model.addAttribute("page", page);
		model.addAttribute("search_type", search_type);
		model.addAttribute("search_keyword", search_keyword);
		Board board = sqlSession.getMapper(Board.class);
		Boardinfo boardinfo = board.getBoardView(bbs_id);
		model.addAttribute("board", boardinfo);
		session = hsr.getSession();
		String loginid = (String)session.getAttribute("loginid");
		if(loginid==null) {
			return "redirect:/";
		}
		return "update";
	}
	@RequestMapping(value = "newbie", method = RequestMethod.GET)
	public String newbie(HttpServletRequest hsr) {
		session = hsr.getSession();
		String referer = hsr.getHeader("Referer");
		hsr.getSession().setAttribute("redirectURI", referer);
		
		return "newbie";
	}
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest hsr) {
		session = hsr.getSession();
		session.invalidate();
		String referer = hsr.getHeader("Referer");
		hsr.getSession().setAttribute("redirectURI", referer);
		return "redirect:"+referer;
	}
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpServletRequest hsr) {
		session = hsr.getSession();
		session.invalidate();
		String referer = hsr.getHeader("Referer");
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
			return "redirect:"+referer;
		}
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
		String referer = (String)session.getAttribute("redirectURI");
		return "redirect:"+referer;
	}
	
	@RequestMapping(value="/doWrite", method=RequestMethod.POST)
	public  String doWrite(HttpServletRequest hsr) {
		
		String name = (String)session.getAttribute("loginid");
		String content = hsr.getParameter("content");
		String title = hsr.getParameter("title");
		Board board = sqlSession.getMapper(Board.class);
		board.doWrite(title,content,name);
		return "redirect:/";
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
	@RequestMapping(value="/insertReply", method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public  String insertReply(HttpServletRequest hsr) {
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		String writer = (String)session.getAttribute("loginid");		
		String content = hsr.getParameter("content");
		Reply reply = sqlSession.getMapper(Reply.class);
		reply.insertReply(bbs_id, writer, content);
		return "ok";
	}
	@RequestMapping(value="/updateReply", method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public  String updateReply(HttpServletRequest hsr) {
		int reply_id = Integer.parseInt(hsr.getParameter("reply_id"));		
		String content = hsr.getParameter("content");
		Reply reply = sqlSession.getMapper(Reply.class);
		reply.updateReply(reply_id, content);
		return "ok";
	}
	@RequestMapping(value="/deleteReply", method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public  String deleteReply(HttpServletRequest hsr) {
		int reply_id = Integer.parseInt(hsr.getParameter("reply_id"));		
		
		Reply reply = sqlSession.getMapper(Reply.class);
		reply.deleteReply(reply_id);
		return "ok";
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
