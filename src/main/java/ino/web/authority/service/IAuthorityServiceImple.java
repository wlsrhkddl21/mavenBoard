package ino.web.authority.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class IAuthorityServiceImple implements IAuthorityService {
	
	@Autowired
	private DataSourceTransactionManager txManager;
	
	@Autowired
	AuthorityDao dao;
	
	@Override
	public List<HashMap<String, Object>> groupList() throws Exception {
		// TODO Auto-generated method stub
		return dao.groupList();
	}

	@Override
	public List<HashMap<String, Object>> objectList() throws Exception {
		// TODO Auto-generated method stub
		return dao.objectList();
	}

	@Override
	public List<HashMap<String, Object>> mappingList(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.mappingList(map);
	}

	@Override
	public String saveAuthority (HashMap<String, Object> map) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
		
        String result = "notchange";
        
		List<HashMap<String, Object>> useList = (List<HashMap<String, Object>>) map.get("useData");
		List<HashMap<String, Object>> unUseList = (List<HashMap<String, Object>>) map.get("unUseData");
		List<HashMap<String, Object>> mappingIns = new ArrayList<>();
		try {
			if(unUseList.size()>0){
				for(int i = unUseList.size()-1; i > -1;i--){
					HashMap<String, Object> unUseMap = new HashMap<>();
					unUseMap.put("groupId", unUseList.get(i).get("groupId"));
					unUseMap.put("objId", unUseList.get(i).get("objId"));
					int delCheck = dao.checkDeMapping(unUseMap);
					if(delCheck!=0){
						txManager.rollback(status);
						return "higi_obj";
					}
					dao.mappingDelete(unUseMap);
					result = "success";
				}
			}
			if(useList.size()>0){
				for(int i = 0; i < useList.size();i++){
					HashMap<String, Object> useMap = new HashMap<>();
					HashMap<String, Object> higi_check = new HashMap<>();
					useMap.put("groupId", useList.get(i).get("groupId"));
					useMap.put("objId", useList.get(i).get("objId"));
					String dept = (String) dao.groupAndObject(useMap).get("DEPT");
					if(!dept.equals("1")){
						higi_check.put("groupId", useList.get(i).get("groupId"));
						higi_check.put("objId",dao.groupAndObject(useMap).get("HIGI_OBJ"));
						int check = dao.checkInMapping(higi_check);
						if(check!=1){
							txManager.rollback(status);
							return "higi_obj";
						}
					}
						dao.mappingInsert(dao.groupAndObject(useMap));
						result = "success";
					}
			}
			
			
//			for(int i = 0; i < useList.size();i++){
//				HashMap<String, Object> useMap = new HashMap<>();
//				useMap.put("groupId", useList.get(i).get("groupId"));
//				useMap.put("objId", useList.get(i).get("objId"));
//				dao.mappingInsert(dao.groupAndObject(useMap));
//			}
			
			
			
//			for(int i = 0; i <unUseList.size();i++){
//				HashMap<String, Object> unUseMap = new HashMap<>();
//				unUseMap.put("groupId", unUseList.get(i).get("groupId"));
//				unUseMap.put("objId", unUseList.get(i).get("objId"));
//				dao.mappingDelete(unUseMap);
//			}
			
			txManager.commit(status);
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
			txManager.rollback(status);
		}
		return result;
	}
	
	@Override
	public String checkLogin(HttpServletRequest req ,HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> result = dao.checkLogin(map);
		String msg = "fail";
		HttpSession session = req.getSession();
		
		if(result!=null){
			session.setAttribute("userId", result.get("USERID"));
			session.setAttribute("userGroup", result.get("GROUPID"));
			msg="success";
		}
		return msg;
	}

}
