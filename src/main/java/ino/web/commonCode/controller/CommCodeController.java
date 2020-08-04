package ino.web.commonCode.controller;

import java.util.HashMap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import ino.web.commonCode.service.ICommCodeService;

@Controller
public class CommCodeController {
	
	@Autowired 
	private ICommCodeService commCodeService;
	
	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req,
             @RequestParam(value="barData",defaultValue="") String[] barData) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		List<HashMap<String,Object>> list = commCodeService.selectCommonCodeList();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		mav.addObject("list" , list);
		mav.addObject("barData" , json);
		mav.setViewName("commonCodeMain");
		
		return mav;
	}
	
	@RequestMapping("/commonCodeInsert.ino")
	public ModelAndView commonCodeInsert(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commonCodeInsert");
		return mav;
	}
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView commCodeDetail(HttpServletRequest request, String code) throws Exception{
		List<HashMap<String, Object>> list  = commCodeService.commCodeDetail(code);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commCodeDetail");
		mav.addObject("list",list);
		mav.addObject("code",code);
		return mav;
	}

	@ResponseBody
	@RequestMapping("/insertCode.ino")
	public String insertCode(HttpServletRequest request
								   , @RequestParam(value="dCode",defaultValue="") String[] dCode
								   , @RequestParam(value="mCode",defaultValue="") String[] mCode
								   , @RequestParam(value="codeName",defaultValue="") String[] codeName
								   , @RequestParam(value="userYn",defaultValue="") String[] userYn 
								   , @RequestParam(value="listDcode",defaultValue="") String[] listDcode
								   , @RequestParam(value="radioYnN",defaultValue="")String[] radioYnN
								   , @RequestParam(value="listDcode_Name",defaultValue="")String[] listDcode_Name
								   , @RequestParam(value="delCode",defaultValue="")String[] delCode) throws Exception{
//		System.out.println("dCode:"+dCode+" mCode:"+mCode+" codeName:"+codeName+" userYn:"+userYn);
		HashMap<String, Object> map = new HashMap<>();
		map.put("dCode", dCode);
		map.put("mCode", mCode);
		map.put("codeName", codeName);
		map.put("userYn", userYn);
		map.put("listDcode", listDcode);
		map.put("radioYnN", radioYnN);
		map.put("listDcode_Name",listDcode_Name);
		map.put("delCode", delCode);
		return commCodeService.commCodeInsert(map);
	}
	
	@ResponseBody
	@RequestMapping("/checkCode.ino")
	public int checkCode(HttpServletRequest request
			, @RequestParam(value="dCode") String[] dCode) throws Exception{
		return commCodeService.checkCode(dCode);
	}
	
}
