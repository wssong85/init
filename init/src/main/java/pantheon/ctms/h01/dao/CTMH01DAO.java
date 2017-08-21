package pantheon.ctms.h01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;







import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMH01DAO")
public class CTMH01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMH01DAO.class);
    //request form 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRequestList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMH01DAO.selectRequestList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRequestFileNm(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMH01DAO.selectRequestFileNm", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMH01DAO.selectCommonCodeList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMH01DAO.selectUserInfo", map);
	}	
	
	
	public int selectRequestListByCount(Map<String, String> map) {
		return (int) select("CTMH01DAO.selectRequestListByCount", map);
	}
	
	//requestForm 저장
	public void insertRequestForm(Map<String, Object> map) {
		insert("CTMH01DAO.insertRequestForm", map);
	}
	
	//requestForm 수정
	public void updateRequestForm(Map<String, Object> map) {
		update("CTMH01DAO.updateRequestForm", map);
	}
	
	//requestForm 삭제
	public void deleteRequestForm(Map<String, Object> map) {
		update("CTMH01DAO.deleteRequestForm", map);
	}
	//requestForm 요청
	public void updateRequestFormBySttus(Map<String, Object> map) {
		update("CTMH01DAO.updateRequestFormBySttus", map);
	}
		
	//Upload File 삭제
	public void deleteUploadFile(Map<String, Object> map) {
		update("CTMH01DAO.deleteUploadFile", map);
	}
	
	
	
	
	
}

