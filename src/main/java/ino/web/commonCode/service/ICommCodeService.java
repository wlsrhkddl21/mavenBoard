package ino.web.commonCode.service;

import java.util.HashMap;

import java.util.List;



public interface ICommCodeService {
	public List<HashMap<String, Object>> selectCommonCodeList() throws Exception;
	public List<HashMap<String, Object>> selectOneCommCodeList(HashMap<String, Object> code) throws Exception;
	public List<HashMap<String, Object>> commCodeDetail(String code) throws Exception;
	public String commCodeInsert(HashMap<String, Object> map) throws Exception;
	public int checkCode(String[] dCode) throws Exception;
}
