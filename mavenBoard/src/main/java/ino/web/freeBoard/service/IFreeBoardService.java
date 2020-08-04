package ino.web.freeBoard.service;

import java.util.HashMap;


public interface IFreeBoardService {
	public HashMap<String, Object> freeBoardList(HashMap<String, Object> map) throws Exception;
	public String freeBoardInsertPro(HashMap<String, Object> map);
	public HashMap<String, Object> getDetailByNum(int num);
	public int getNewNum();
	public String freeBoardModify(HashMap<String, Object> map);
	public String FreeBoardDelete (int num);
	public int freeBoardCount(HashMap<String, Object> paramMap);
	
}
