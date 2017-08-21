package pantheon.edc.g01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("EDCG01DAO")
public class EDCG01DAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public String selectEdcVer(Map<String, Object> param) throws Exception{
		return (String) select("EDCG01DAO.selectEdcVer", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCsList(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCG01DAO.selectCsList", param);
	}
	
	@SuppressWarnings("unchecked")
	public void updateEdcCfVriablByPvCraCnfirmCode(Map<String, Object> param) throws Exception{
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		update ("EDCG01DAO.updateEdcCfVriablByPvCraCnfirmCode", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTableInfo(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list ("EDCG01DAO.selectTableInfo", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDicaryInfo(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)list("EDCG01DAO.selectDicaryInfo", param);
	}
	
	@SuppressWarnings("unchecked")
	public void insertEdcCfQueryByCra(Map<String, Object> param) throws Exception{
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		insert("EDCG01DAO.insertEdcCfQueryByCra", param);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCmQueryByCra(Map<String, Object> param) throws Exception{
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		insert("EDCG01DAO.insertCmQueryByCra", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDistinctAbnRctList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)list("EDCG01DAO.selectDistinctAbnRctList", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDistinctDAbnRct(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCG01DAO.selectDistinctDAbnRct", param);
	}
}
