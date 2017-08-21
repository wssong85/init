package pantheon.edc.a01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EDCA01DAO")
public class EDCA01DAO extends EgovComAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskList(Map<String, Object> map) throws Exception{
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCA01DAO.selectTaskList", map);
	}
	
	public String selectTaskCount(Map<String, Object> map){
		return (String) select("EDCA01DAO.selectTaskCount", map); 
	}
	
	public String selectCmProgrmForHomeMenu(Map<String, Object> map) {
		return (String) select("EDCA01DAO.selectCmProgrmForHomeMenu", map);
	}
	
	public int selectCtmsDmcTaskRoleForDupCheck(Map<String, String> map) {
		return (Integer) select("EDCA01DAO.selectCtmsDmcTaskRoleForDupCheck", map);
	}
	
}