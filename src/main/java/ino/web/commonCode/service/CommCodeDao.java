package ino.web.commonCode.service;

import java.util.HashMap;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommCodeDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCodeList() throws Exception{
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}
	
	public List<HashMap<String, Object>> selectOneCommCodeList(HashMap<String, Object> code) throws Exception{
		return sqlSessionTemplate.selectList("selectOneCommCodeList",code);
	}
	
	public List<HashMap<String, Object>> commCodeDetail(String code) throws Exception{
		return sqlSessionTemplate.selectList("commCodeDetail",code);
	}
	
	public void commCodeInsert(HashMap<String, Object> map) throws Exception{
		sqlSessionTemplate.insert("commCodeInsert",map);
	}
	
	public int checkCode(String[] dCode) throws Exception{
		return sqlSessionTemplate.selectOne("checkCode",dCode);
	}
	
	public void commCodeUpdate(HashMap<String, Object> map) throws Exception{
		sqlSessionTemplate.update("commCodeUpdae",map);
	}
	
	public void commCodeDelete(HashMap<String, Object> map) throws Exception{
		sqlSessionTemplate.delete("commCodeDelete",map);
	}
}
