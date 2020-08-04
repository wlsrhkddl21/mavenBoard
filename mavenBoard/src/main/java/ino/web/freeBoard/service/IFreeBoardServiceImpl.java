package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

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
		System.out.println(pagingUt);
		List<HashMap<String, Object>> list = dao.freeBoardList(map);
		map.put("list", list);
		map.put("pagingUt", pagingUt);
		System.out.println(map);
		return map;
	}

	@Override
	public String freeBoardInsertPro(HashMap<String, Object> map) {
		String result = "";
		try {
			result = dao.freeBoardInsertPro(map);
		} catch (Exception e) {
			result="fail";
		}
		System.out.println(result);
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
		return dao.freeBoardModify(map);
	}

	@Override
	public String FreeBoardDelete(int num) {
		return dao.FreeBoardDelete(num);
		
	}

	@Override
	public int freeBoardCount(HashMap<String, Object> map) {
		return dao.freeBoardCount(map);
	}
	
}
