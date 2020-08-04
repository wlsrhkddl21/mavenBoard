package ino.web.authority.controller;

import java.util.HashMap;



import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import ino.web.authority.service.IAuthorityService;

@Controller
public class AuthorityController {
	
	@Autowired
	IAuthorityService authorityService;
	
	@RequestMapping("/authorityMain.ino")
	public ModelAndView authorityMain(HttpServletRequest req,@RequestParam(value="groupId",defaultValue="") String groupId
            , @RequestParam(value="barData",defaultValue="{'0','0','0'}") String[] barData) throws Exception{
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<>();
		map.put("groupId", groupId);
		List<HashMap<String, Object>> objList = authorityService.objectList();
		List<HashMap<String, Object>> groupList = authorityService.groupList();
		List<HashMap<String, Object>> mappingList = authorityService.mappingList(map);
		if(!groupId.equals("")){
			mav.addObject("objList",objList);
		}
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(barData);
		mav.addObject("objJson",JSONArray.toJSONString(objList));
		mav.setViewName("authorityMain");
		mav.addObject("groupList",groupList);
		mav.addObject("mappingJson",JSONArray.toJSONString(mappingList));
		mav.addObject("mappingList",mappingList);
		mav.addObject("groupId",groupId);
		mav.addObject("barData" ,json);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/authoritySave.ino")
	public String objectList(@RequestBody HashMap<String, Object> sData
							,@RequestParam(value="barData",defaultValue="") String[] barData) throws Exception{
		return authorityService.saveAuthority(sData);
	}
	
	@ResponseBody
	@RequestMapping("/loginCheck.ino")
	public String loginCheck(HttpServletRequest req,
							@RequestParam(value="userId",defaultValue="") String userId
							,@RequestParam(value="userPw")String userPw) throws Exception{
		
		HashMap<String, Object> loginMap = new HashMap<>();
		loginMap.put("userId", userId);
		loginMap.put("userPw", userPw);
		return authorityService.checkLogin(req,loginMap);
	}
	
	@RequestMapping("/logout.ino")
	public String logout(HttpServletRequest req) throws Exception{
		req.getSession().invalidate();
		
		return "redirect:";
	}
}
