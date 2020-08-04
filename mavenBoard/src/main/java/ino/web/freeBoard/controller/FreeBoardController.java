package ino.web.freeBoard.controller;



import ino.web.commonCode.service.CommCodeService;

import ino.web.freeBoard.service.IFreeBoardService;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {
	
//	@Autowired
//	private FreeBoardService freeBoardService;
	
	@Autowired
	private IFreeBoardService service;
	
	@Autowired
	private CommCodeService commCodeService;
	
	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request
			                , @RequestParam(value="curPage",defaultValue="1") int curPage
			                , @RequestParam(value="beginDate",defaultValue="") String beginDate
			                , @RequestParam(value="endDate",defaultValue="") String endDate
			                , @RequestParam(value="searchType",defaultValue="") String searchType
			                , @RequestParam(value="searchTxt",defaultValue="") String searchTxt) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchTxt", searchTxt);
		map.put("beginDate", beginDate.replaceAll("-", ""));
		map.put("endDate", endDate.replaceAll("-", ""));
		
		int count = service.freeBoardCount(map);
		
		map.put("count", count);
		map.put("curPage", curPage);
		
		map.put("code", "COM001");
		map.put("mUseYn", "Y");
		map.put("dUseYn", "Y");
		List<HashMap<String, Object>> codeList = commCodeService.selectOneCommCodeList(map);
		
		map.put("code", "COM004");
		map.put("mUseYn", "Y");
		map.put("dUseYn", "Y");
		List<HashMap<String, Object>> codeList1 = commCodeService.selectOneCommCodeList(map);
		
		map = service.freeBoardList(map);
		
		mav.setViewName("boardMain");
		mav.addObject("codeMap",codeList);
		mav.addObject("codeMap1",codeList1);
		mav.addObject("map",map);
		System.out.println(map);
		
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert() throws Exception{
		return "freeBoardInsert";
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardInsertPro.ino")
	public String freeBoardInsertPro(HttpServletRequest request
																,@RequestParam("name") String name
																,@RequestParam("title") String title
																,@RequestParam("content") String content) throws Exception{	
		HashMap<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("title", title);
		map.put("content", content);
		
		return service.freeBoardInsertPro(map);
	}
	
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num) throws Exception{
		HashMap<String, Object> map  = service.getDetailByNum(num);
		return new ModelAndView("freeBoardDetail", "freeBoardDto", map);
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModify.ino")
	public String freeBoardModify(HttpServletRequest request) throws Exception{
		HashMap<String, Object> map	= new HashMap<>();
		String num = request.getParameter("num");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		map.put("num", num);
		map.put("title", title);
		map.put("content", content);
		String result = service.freeBoardModify(map);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(int num) throws Exception{
		return service.FreeBoardDelete(num);
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardSearch.ino")
	public HashMap<String, Object> FreeBoardSearch(HttpServletRequest request
												, @RequestParam(value="curPage",defaultValue="1") int curPage
												, @RequestParam(value="beginDate",defaultValue="") String beginDate
								                , @RequestParam(value="endDate",defaultValue="") String endDate
									            , @RequestParam(value="searchType",defaultValue="") String searchType
									            , @RequestParam(value="searchTxt",defaultValue="") String searchTxt) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("searchType", searchType);
		paramMap.put("searchTxt", searchTxt);
		paramMap.put("beginDate", beginDate.replaceAll("-", ""));
		paramMap.put("endDate", endDate.replaceAll("-", ""));
		int count = service.freeBoardCount(paramMap);
		paramMap.put("count", count);
		paramMap.put("curPage", curPage);
		return service.freeBoardList(paramMap);
	}
}