package ino.web.freeBoard.service;


import java.util.HashMap;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> paramMap){
		return sqlSessionTemplate.selectList("freeBoardGetList",paramMap);
	}
	
	
	public String freeBoardInsertPro(HashMap<String, Object> map){
		String result = "success";
		try {
			sqlSessionTemplate.insert("freeBoardInsertPro",map);
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}
		return result;
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

	public void FreeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);
	}

	public int freeBoardCount(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("freeBoardCount",paramMap);
	}
	
	

}
