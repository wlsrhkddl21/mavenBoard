package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) throws Exception{
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}
	
	public String freeBoardInsertPro(HashMap<String, Object> map){
		sqlSessionTemplate.insert("freeBoardInsertPro",map);
		return "success";
	}
	
	public HashMap<String, Object> getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public String freeBoardModify(HashMap<String, Object> map){
		String result = "success";
		try {
			sqlSessionTemplate.update("freeBoardInsertPro", map);
			
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}
		return result;
	}

	public String FreeBoardDelete (HashMap<String, Object> map) {
		
		String result = "success";
		try {
			sqlSessionTemplate.delete("freeBoardDelete", map);			
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}
		return result;
	}

	public int freeBoardCount(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("freeBoardCount",paramMap);
	}
	
	public List<HashMap<String, Object>> addBar(HashMap<String, Object> map){
		return sqlSessionTemplate.selectList("addBar",map);
	}
	
	public int getHistoryMaxNum() {
		return sqlSessionTemplate.selectOne("getHistoryMaxNum");
	}
	public void historyUserUpdate(String userId){
		HashMap<String, Object> hisMap = new HashMap<>();
		int num = getHistoryMaxNum();
		hisMap.put("userId", userId);
		hisMap.put("num", num);
		sqlSessionTemplate.update("historyUserUpdate",hisMap);
	}
}