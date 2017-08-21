package pantheon.sdb.f01.service;

import java.util.List;
import java.util.Map;

public interface SDBF01Service {
	public List<Map<String, String>> selectQcResultReportList(Map<String, String> param) throws Exception;
	public Map<String, String> selectQcReportInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectQcSopItemCheckList(Map<String, String> param) throws Exception;
	public void insertQcResultReportInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectUserInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectCaseInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectProductCaseInfo(Map<String, String> param) throws Exception;
	public void updateApprovalQcInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectCapaListInfo(Map<String, String> param) throws Exception;
}
