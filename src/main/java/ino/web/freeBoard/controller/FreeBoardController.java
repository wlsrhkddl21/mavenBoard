package ino.web.freeBoard.controller;


import ino.web.commonCode.service.ICommCodeService;

import ino.web.freeBoard.service.IFreeBoardService;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FreeBoardController {
	
	@Autowired
	private IFreeBoardService iFreeBoardService;
	
	@Autowired
	private ICommCodeService iCommCodeService; 
	
	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request
			                , @RequestParam(value="curPage",defaultValue="1") int curPage
			                , @RequestParam(value="beginDate",defaultValue="") String beginDate
			                , @RequestParam(value="endDate",defaultValue="") String endDate
			                , @RequestParam(value="searchType",defaultValue="") String searchType
			                , @RequestParam(value="searchTxt",defaultValue="") String searchTxt
			                , @RequestParam (defaultValue="")String[] barData) throws Exception{
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchTxt", searchTxt);
		map.put("beginDate", beginDate.replaceAll("-", ""));
		map.put("endDate", endDate.replaceAll("-", ""));
		
		int count = iFreeBoardService.freeBoardCount(map);
		
		map.put("count", count);
		map.put("curPage", curPage);
		map.put("code", "COM001");
		map.put("mUseYn", "Y");
		map.put("dUseYn", "Y");
		List<HashMap<String, Object>> codeList = iCommCodeService.selectOneCommCodeList(map);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		map.put("code", "COM004");
		map.put("mUseYn", "Y");
		map.put("dUseYn", "Y");
		List<HashMap<String, Object>> codeList1 = iCommCodeService.selectOneCommCodeList(map);
		map = iFreeBoardService.freeBoardList(map);
		mav.setViewName("boardMain");
		mav.addObject("codeMap",codeList);
		mav.addObject("codeMap1",codeList1);
		mav.addObject("map",map);
		mav.addObject("barData",json);
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert(@RequestParam (defaultValue="")String[] barData) throws Exception{
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("freeBoardInsert");
		mav.addObject("barData",json);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardInsertPro.ino")
	public String freeBoardInsertPro(HttpServletRequest req
																,@RequestParam("name") String name
																,@RequestParam("title") String title
																,@RequestParam("content") String content
												                ,@RequestParam (defaultValue="")String[] barData) throws Exception{	
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session =  req.getSession();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		map.put("reg_user", session.getAttribute("userId"));
		map.put("name", name);
		map.put("title", title);
		map.put("content", content);
		map.put("barData", json);
		
		return iFreeBoardService.freeBoardInsertPro(map);
	}
	
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num
										,@RequestParam (defaultValue="")String[] barData) throws Exception{
		HashMap<String, Object> map  = iFreeBoardService.getDetailByNum(num);
		ModelAndView mav = new ModelAndView();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		mav.setViewName("freeBoardDetail");
		mav.addObject("freeBoardDto",map);
		mav.addObject("barData",json);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModify.ino")
	public String freeBoardModify(HttpServletRequest req
			,@RequestParam (defaultValue="")String[] barData) throws Exception{
		HashMap<String, Object> map	= new HashMap<>();
		int num = Integer.parseInt(req.getParameter("num"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String userId = (String) req.getSession().getAttribute("userId");
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		map.put("barData", json);
		map.put("reg_user", userId);		
		map.put("num", num);
		map.put("title", title);
		map.put("content", content);
		String result = iFreeBoardService.freeBoardModify(map);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(HttpServletRequest req,int num
								,@RequestParam (defaultValue="")String[] barData) throws Exception{
		HashMap<String,Object> map = new HashMap<>();
		String userId = (String) req.getSession().getAttribute("userId");
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		map.put("barData", json);
		map.put("userId", userId);
		map.put("num", num);
		return iFreeBoardService.FreeBoardDelete(map);
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardSearch.ino")
	public HashMap<String, Object> FreeBoardSearch(HttpServletRequest request
												, @RequestParam(value="curPage",defaultValue="1") int curPage
												, @RequestParam(value="beginDate",defaultValue="") String beginDate
								                , @RequestParam(value="endDate",defaultValue="") String endDate
									            , @RequestParam(value="searchType",defaultValue="") String searchType
									            , @RequestParam(value="searchTxt",defaultValue="") String searchTxt
									            , @RequestParam (defaultValue="")String[] barData) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		paramMap.put("barData", json);
		paramMap.put("searchType", searchType);
		paramMap.put("searchTxt", searchTxt);
		paramMap.put("beginDate", beginDate.replaceAll("-", ""));
		paramMap.put("endDate", endDate.replaceAll("-", ""));
		int count = iFreeBoardService.freeBoardCount(paramMap);
		paramMap.put("count", count);
		paramMap.put("curPage", curPage);
		return iFreeBoardService.freeBoardList(paramMap);
	}
	
	@RequestMapping("/viewMenu.ino")
	public ModelAndView viewMenu() throws Exception{
//		HashMap<String, Object> barData = new HashMap<>();
//		barData.put("main", "0");
//		barData.put("comm", "0");
//		barData.put("author", "0");
		String[] barData = {"0","0","0"};
		System.out.println(barData[0]);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("viewMenu");
		mav.addObject("barData",json);
		return mav;		
	}
	
	@ResponseBody
	@RequestMapping("/addBar.ino")
	public List<HashMap<String, Object>> addBar(@RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map);
		return iFreeBoardService.addBar(map);
	}
}