package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class ICommCodeServiceImpl implements ICommCodeService {
	
	@Autowired
	private DataSourceTransactionManager txManager;
	
	@Autowired
	CommCodeDao commDao;
	
	@Override
	public List<HashMap<String, Object>> selectCommonCodeList() throws Exception {
		return commDao.selectCommonCodeList();
	}

	@Override
	public List<HashMap<String, Object>> selectOneCommCodeList(HashMap<String, Object> code) throws Exception {
		return commDao.selectOneCommCodeList(code);
	}

	@Override
	public List<HashMap<String, Object>> commCodeDetail(String code) throws Exception {
		
		return commDao.commCodeDetail(code);
	}
	
	@Override
	public String commCodeInsert(HashMap<String, Object> map) throws Exception{
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
		String result = "fail";
		String[] dCode = (String[]) map.get("dCode");
		String[] mCode = (String[]) map.get("mCode");
		String[] codeName = (String[]) map.get("codeName");
		String[] userYn = (String[]) map.get("userYn");
		String[] listDcode = (String[]) map.get("listDcode");
		String[] radioYnN = (String[]) map.get("radioYnN");
		String[] listDcode_Name = (String[]) map.get("listDcode_Name");
		String[] delCode = (String[]) map.get("delCode");
		try {
			for(int i = 0 ; i < dCode.length; i ++){
				HashMap<String, Object> insertMap = new HashMap<>();
				insertMap.put("dCode", dCode[i]);
				insertMap.put("mCode", mCode[i]);
				insertMap.put("codeName", codeName[i]);
				insertMap.put("userYn", userYn[i]);
				if(dCode[i].equals("")){
					break;
				}
				System.out.println("insert");
				commDao.commCodeInsert(insertMap);
			}
			for(int i = 0; i < listDcode.length; i++){
				HashMap<String, Object> updateMap = new HashMap<>();
				updateMap.put("listDcode", listDcode[i]);
				updateMap.put("radioYnN", radioYnN[i]);
				updateMap.put("listDcode_Name", listDcode_Name[i]);
				if(listDcode[i].equals("")){
					break;
				}
				commDao.commCodeUpdate(updateMap);
			}
			System.out.println("update");
			for(int i=0;i<delCode.length;i++){
				HashMap<String, Object> deleteMap = new HashMap<>();
				deleteMap.put("delCode", delCode[i]);
				System.out.println(deleteMap);
				commDao.commCodeDelete(deleteMap);
			}
			result="success";
			txManager.commit(status);
		} catch (Exception e) {
			System.out.println("실패");
			txManager.rollback(status);
		}
		return result;
	}
	
	@Override
	public int checkCode(String[] dCodes) throws Exception {
		int result =0;
		for (int i = 0; i < dCodes.length; i++) {
	        String str1 = dCodes[i];
	        for (int j = 0; j < dCodes.length; j++) {
	            if (i == j) continue;
	            String str2 = dCodes[j];
	            if (str1.equals(str2)) {
	                return 1;
	            }
	        }
	    }
		if(commDao.checkCode(dCodes)>0){
			result = 1;
		}
		return result;
	}

}
