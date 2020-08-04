package ino.web.freeBoard.service;

import java.util.HashMap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeBoard.common.util.PagingUtil;

@Service
public class IFreeBoardServiceImpl implements IFreeBoardService {

	@Autowired
	private FreeBoardDao dao ; 
	
	@Override
	public HashMap<String, Object> freeBoardList(HashMap<String, Object> map) throws Exception{
		int curPage = (int) map.get("curPage");
		int count = (int) map.get("count");
		PagingUtil pagingUt = new PagingUtil(curPage, count);
		map.put("pageBegin", pagingUt.getPageBegin());
		map.put("pageEnd", pagingUt.getPageEnd());
		List<HashMap<String, Object>> list = dao.freeBoardList(map);
		map.put("list", list);
		map.put("pagingUt", pagingUt);
		return map;
	}

	@Override
	public String freeBoardInsertPro(HashMap<String, Object> map) {
		String result = "";
		
		try {
			map.put("num", 0);
			
			result = dao.freeBoardInsertPro(map);
			//String userId = (String) map.get("userId");
			//dao.historyUserUpdate(userId);
			
		} catch (Exception e) {
			e.printStackTrace();
			result="fail";
		}
		return result;
	}

	@Override
	public HashMap<String, Object> getDetailByNum(int num) {
		return dao.getDetailByNum(num);
	}

	@Override
	public int getNewNum() {
		return dao.getNewNum();
	}

	@Override
	public String freeBoardModify(HashMap<String, Object> map) {
		map.put("name", "name");
		String result = dao.freeBoardModify(map);
		return result;
	}

	@Override
	public String FreeBoardDelete(HashMap<String , Object> map) {
		String result = "";
		
		result = dao.FreeBoardDelete(map);
		//dao.historyUserUpdate(userId);
		return result;
		
	}

	@Override
	public int freeBoardCount(HashMap<String, Object> map) {
		return dao.freeBoardCount(map);
	}

	@Override
	public List<HashMap<String, Object>> addBar(HashMap<String, Object> map) {
		
		return dao.addBar(map);
	}

	
}
