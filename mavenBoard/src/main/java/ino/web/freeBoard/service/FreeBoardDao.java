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
			sqlSessionTemplate.update("freeBoardModify", map);
			
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}
		return result;
	}

	public String FreeBoardDelete (int num) {
		
		String result = "success";
		try {
			sqlSessionTemplate.delete("freeBoardDelete", num);			
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
	
}
