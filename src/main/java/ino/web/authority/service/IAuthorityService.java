package ino.web.authority.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface IAuthorityService {
	public List<HashMap<String, Object>> groupList() throws Exception;
	public List<HashMap<String, Object>> objectList() throws Exception;
	public List<HashMap<String, Object>> mappingList(HashMap<String, Object> map) throws Exception;
	public String saveAuthority(HashMap<String, Object> map) throws Exception;
	public String checkLogin(HttpServletRequest req, HashMap<String, Object> map) throws Exception;
}
