package pantheon.ctms.j02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.j02.dao.DMCJ02DAO;
import pantheon.ctms.j02.service.DMCJ02Service;


@Service("DMCJ02Service")
public class DMCJ02ServiceImpl implements DMCJ02Service{

	@Resource(name = "DMCJ02DAO")
	private DMCJ02DAO dmcj02DAO;

	@Override
	public List<Map<String, Object>> selectAllNoticeList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj02DAO.selectAllNoticeList(map);
	}

	@Override
	public List<Map<String, Object>> selectNoticeByPopup(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj02DAO.selectNoticeByPopup(map);
	}
	
	
	@Override
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj02DAO.selectCommonCodeList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectRoleId(Map<String, String> map) throws Exception{
		return dmcj02DAO.selectRoleId(map);
	}
	
	
	@Override
	public void insertNoticeManageData(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {	
				dmcj02DAO.insertNoticeManageData(iMap);
		}
		
	}

	@Override
	public void insertNoticeAuthor(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("C")) {
				
				dmcj02DAO.insertNoticeAuthor(iMap); 
			}else if(iMap.get("CRUD").equals("D")){
				
			}
	}
		
	}
	
	

	


	
	
	

}

	



















