package pantheon.sdb.e03.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SDBE03Service {
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception;
	public int selectQueryCnt(Map<String, String> param) throws Exception;
	public void updateEndQueryInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectVerificationInfo(Map<String, String> param) throws Exception;
	public String insertExcelInfo(HttpServletRequest req) throws Exception;
	public List<Map<String, String>> selectVerificationForExcel(Map<String, String> param) throws Exception;
	public void updateVerificationInfo(Map<String, String> param) throws Exception;
	public void deleteTempVerificationInfo(Map<String, String> param) throws Exception;
	public List<Map<String, Object>> selectChargeListPop(Map<String, String> map) throws Exception;
	public void insertSendMail(Map<String, String> map)throws Exception;
}
