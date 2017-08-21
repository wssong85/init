package pantheon.sdb.f01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBF01DAO")
public class SDBF01DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectQcResultReportList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectQcResultReportList", param);
	}
	
	public Map<String, String> selectQcReportInfo(Map<String, String> param) throws Exception{
		return (Map<String, String>) select("SDBF01.selectQcReportInfo", param);
	}
	
	public List<Map<String, String>> selectQcSopItemCheckList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectQcSopItemCheckList", param);
	}
	
	public void insertQcResultReportInfo(Map<String, String> param) throws Exception{
		insert("SDBF01.insertQcResultReportInfo", param);
	}
	
	public void updateQcResultReportInfo(Map<String, String> param) throws Exception{
		update("SDBF01.updateQcResultReportInfo", param);
	}
	
	public void insertQcSopItemCheckInfo(Map<String, String> param) throws Exception{
		insert("SDBF01.insertQcSopItemCheckInfo", param);
	}
	
	public void updateQcSopItemCheckInfo(Map<String, String> param) throws Exception{
		update("SDBF01.updateQcSopItemCheckInfo", param);
	}
	
	public void insertAboveCaseInfo(Map<String, String> param) throws Exception{
		insert("SDBF01.insertAboveCaseInfo", param);
	}
	
	public void deleteAboveCaseInfo(Map<String, String> param) throws Exception{
		update("SDBF01.deleteAboveCaseInfo", param);
	}
	
	public String selectQcReportNo(Map<String, String> param) throws Exception{
		return (String)select("SDBF01.selectQcReportNo", param);
	}
	
	public int selectSopItemCheckNo(Map<String, String> param) throws Exception{
		return (int)select("SDBF01.selectSopItemCheckNo", param);
	}
	
	public List<Map<String, String>> selectUserInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectUserInfo", param);
	}
	
	public List<Map<String, String>> selectCaseInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectCaseInfo", param);
	}
	
	public List<Map<String, String>> selectProductCaseInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectProductCaseInfo", param);
	}
	
	public void updateApprovalQcInfo(Map<String, String> param) throws Exception{
		update("SDBF01.updateApprovalQcInfo", param);
	}
	
	public List<Map<String, String>> selectCapaListInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF01.selectCapaListInfo", param);
	}
	
	public void insertCapaListInfo(Map<String, String> param) throws Exception{
		insert("SDBF01.insertCapaListInfo", param);
	}
	
	public void updateCapaListInfo(Map<String, String> param) throws Exception{
		update("SDBF01.updateCapaListInfo", param);
	}
	
	public String selectFllwmanagtSn(Map<String, String> param) throws Exception{
		return (String) select("SDBF01.selectFllwmanagtSn", param);
	}
}
