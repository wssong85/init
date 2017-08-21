package pantheon.sdb.e03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBE03DAO")
public class SDBE03DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBE03DAO.selectQueryList", param);
	}
	
	public int selectQueryCnt(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (int) select("SDBE03DAO.selectQueryCnt", param);
	}
	
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBE03DAO.selectQueryInfo", param);
	}
	
	public String selectQuerySeq() throws Exception{
		return (String) select("SDBE03DAO.selectQuerySeq");
	}
	
	public void insertQueryInfo(Map<String, String> param) throws Exception{
		insert("SDBE03DAO.insertQueryInfo", param);
	}
	
	public void insertPhaseInfo(Map<String, String> param) throws Exception{
		insert("SDBE03DAO.insertPhaseInfo", param);
	}
	
	public void updateEndQueryInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateEndQueryInfo", param);
	}
	
	public List<Map<String, String>> selectVerificationInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBE03DAO.selectVerificationInfo", param);
	}
	
	public void insertExcelInfo(Map<String, String> param) throws Exception{
		insert("SDBE03DAO.insertExcelInfo", param);
	}
	
	public List<Map<String, String>> selectVerificationForExcel(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBE03DAO.selectVerificationForExcel", param);
	}
	
	public void deleteVerificationForTemp(Map<String, String> param) throws Exception{
		delete("SDBE03DAO.deleteVerificationForTemp", param);
	}
	
	public void updateVerificationInfoForCase(Map<String, String> param) throws Exception{
		update("SDBE03DAO.updateVerificationInfoForCase", param);
	}
	
	public void updateVerificationInfoForAe(Map<String, String> param) throws Exception{
		update("SDBE03DAO.updateVerificationInfoForAe", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectChargeListPop(Map<String, String> map) throws Exception{
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBE03DAO.selectChargeListPop", map);
	}

	public void insertEmailHistory(Map<String, String> map) throws Exception{
		// TODO Auto-generated method stub
		insert("SDBE03DAO.insertEmailHistory", map);
	}
}
