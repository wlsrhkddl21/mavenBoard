package ino.web.authority.service;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AuthorityDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	public List<HashMap<String, Object>> groupList() throws Exception{
		return sqlSession.selectList("groupList");
	}
	
	public List<HashMap<String, Object>> objectList() throws Exception{
		return sqlSession.selectList("objectList");
	}
	
	public List<HashMap<String, Object>> mappingList(HashMap<String, Object> map) throws Exception{
		return sqlSession.selectList("mappingList",map);
	}
	
//	public void mappingDelete(List<HashMap<String, Object>> list) throws Exception{
//		sqlSession.delete("mappingDelete",list);
//	}
	public void mappingDelete(HashMap<String, Object> map) throws Exception{
		sqlSession.delete("mappingDelete",map);
	}
	
//	public void mappingInsert(List<HashMap<String, Object>> map) throws Exception{
//		sqlSession.insert("mappingInsert",map);
//	}
	public void mappingInsert(HashMap<String, Object> map) throws Exception{
		sqlSession.insert("mappingInsert",map);
	}
	
	public HashMap<String, Object> groupAndObject(HashMap<String, Object> map) throws Exception{
		return sqlSession.selectOne("groupAndObject", map);
	}
	
	public int checkInMapping(HashMap<String, Object> map) throws Exception{
		return sqlSession.selectOne("checkInMapping",map);
	}
	
	public int checkDeMapping(HashMap<String, Object> map) throws Exception{
		return sqlSession.selectOne("checkDeMapping",map);
	}
	
	public HashMap<String, Object> checkLogin(HashMap<String , Object> map) throws Exception{
		return sqlSession.selectOne("checkLogin",map);
	}
	
}
