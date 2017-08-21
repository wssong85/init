package pantheon.ctms.z03.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMZ03DAO")
public class CTMZ03DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMZ03DAO.class);
	
	/**
	 * 연구기관 방문 보고서 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSiteVisitList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ03DAO.selectSiteVisitList", map);
	}

	/**
	 * 보고서 신규 여부 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportCrudInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ03DAO.selectReportCrudInfo", map);
	}

	/**
	 * 보고서 상단 Title정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportTitleInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ03DAO.selectReportTitleInfo", map);
	}
	
	/**
	 * 보고서 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportMainInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ03DAO.selectReportMainInfo", map);
	}
	
	/**
	 * 보고서 항록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReportItemList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ03DAO.selectReportItemList", map);
	}
	
	/**
	 * 보고서 visit 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ03DAO.selectVisitInfoGrid", map);
	}

	/**
	 * 보고서 Main 저장
	 * @param map
	 */
	public void insertReportMain(Map<String, Object> map) {
		insert("CTMZ03DAO.insertReportMain", map);
	}

	/**
	 * 보고서 Main 수정
	 * @param map
	 */
	public void updateReportMain(Map<String, Object> map) {
		insert("CTMZ03DAO.updateReportMain", map);
	}

	/**
	 * 보고서 결제요청번호 수정
	 * @param map
	 */
	public void updateReportApprovalSn(Map<String, Object> map) {
		insert("CTMZ03DAO.updateReportApprovalSn", map);
	}
	
	/**
	 * 보고서 Item 저장
	 * @param map
	 */
	public void insertReportItem(Map<String, Object> map) {
		insert("CTMZ03DAO.insertReportItem", map);
	}

	/**
	 * 보고서 Item 수정
	 * @param map
	 */
	public void updateReportItem(Map<String, Object> map) {
		insert("CTMZ03DAO.updateReportItem", map);
	}

	/**
	 * 방문자 저장
	 * @param map
	 */
	public void insertReportVisit(Map<String, Object> map) {
		insert("CTMZ03DAO.insertReportVisit", map);
	}

	/**
	 * 방문자 수정
	 * @param map
	 */
	public void updateReportVisit(Map<String, Object> map) {
		insert("CTMZ03DAO.updateReportVisit", map);
	}
	
	/**
	 * 방문자 삭제
	 * @param map
	 */
	public void deleteReportVisit(Map<String, Object> map) {
		insert("CTMZ03DAO.deleteReportVisit", map);
	}
}

