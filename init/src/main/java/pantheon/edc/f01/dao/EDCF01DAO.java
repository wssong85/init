package pantheon.edc.f01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("EDCF01DAO")
public class EDCF01DAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGetEdcVer(Map<String, Object> param) throws Exception{
		return (Map<String, Object>) select("EDCF01DAO.selectGetEdcVer", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrInsttForm(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCF01DAO.selectEdcCrInsttForm", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrSubject(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCF01DAO.selectEdcCrSubject", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCfVisit(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCF01DAO.selectEdcCfVisit", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCfGroup(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCF01DAO.selectEdcCfGroup", param);
	}
	
	@SuppressWarnings("unchecked")
	public void updateSdvSttusBySite(Map<String, Object> param) throws Exception{
		update("EDCF01DAO.updateSdvSttusBySite", param);
	}
	
	@SuppressWarnings("unchecked")
	public void updateSdvCmplSttusBySite(Map<String, Object> param) throws Exception{
		update("EDCF01DAO.updateSdvCmplSttusBySite", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCfGroupOldList(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCF01DAO.selectEdcCfGroupOldList", param);
	}
}
