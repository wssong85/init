package pantheon.ctms.l02.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.ctms.l02.dao.CTML02DAO;
import pantheon.ctms.l02.service.CTML02Service;


@Service("CTML02Service")
public class CTML02ServiceImpl implements CTML02Service{

	@Resource(name = "CTML02DAO")
	private CTML02DAO ctml02DAO;

	@Override
	public List<Map<String, Object>> selectGridByTodoList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		return ctml02DAO.selectGridByTodoList(map);
	}

	@Override
	public void updateGridByTodoList(List<Map<String, Object>> list)
			throws Exception {		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("U")) {
				ctml02DAO.updateGridByTodoList(iMap); 
			}else if(iMap.get("CRUD").equals("C")){
				ctml02DAO.insertGridByTodoList(iMap); 
			}else{
				ctml02DAO.deleteGridByTodoList(iMap); 
			}
			
		}		
		
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctml02DAO.selectCommonCodeList(map);
	}
	
	

}

	



















