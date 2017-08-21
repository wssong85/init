package pantheon.edc.c01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * Data import 목록을 위한 데이터 접근 클래스
 * 
 * @author 오동근
 * @since 2016.05.03
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.03 오동근 최초 생성
 */
@Repository("EDCC01DAO")
public class EDCC01DAO extends EgovComAbstractDAO {

	/**
	 * Subject 목록
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcSubjectList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCC01DAO.selectEdcSubjectList", param);
	}

	/**
	 * Subject 목록 Count
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectEdcSubjectListCount(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectEdcSubjectListCount", param);
	}

	/**
	 * 피험자 등록 전 기관양식 테이블에 로그인한 사용자의 기관정보가 있는지 유무판단 후 기관 순번 return
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectLoginInsttFormSn(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectLoginInsttFormSn", param);
	}

	/**
	 * 로그인한 사용자의 기관코드를 return
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectInsttCode(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectInsttCode", param);
	}

	/**
	 * 현재 활성화되어있는 EDC Version을 return
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectEdcVer(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectEdcVer", param);
	}
	
	/**
	 * 현재 활성화되어있는 CRF Version을 return
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectCrfVer(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectCrfVer", param);
	}

	/**
	 * 과제순번과 EDC버전에 맞는 방문순번을 LIST로 return
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInsttCodeList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectInsttCodeList", param);
	}

	/**
	 * 기관양식 테이블에 insert
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void insertInsttForm(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertInsttForm", param);
	}

	/**
	 * 피험자 테이블에 insert
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void insertSubject(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertSubject", param);
	}

	/**
	 * EDC_CF 방문일정 테이블에 insert
	 * 
	 * @param param
	 * @throws Exception
	 */
	/*
	 * public void insertCfVisitSchdul(Map<String, Object> param) throws Exception {
	 * insert("EDCC01DAO.insertCfVisitSchdul", param);
	 * }
	 */
	/**
	 * EDC_CF 방문 테이블에 insert
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void insertCfVisit(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCfVisit", param);
	}

	/**
	 * Subject 메뉴 목록 List
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSubjectMenuList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectSubjectMenuList", param);
	}

	/**
	 * Visit[List] 목록 List
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectVisitList", param);
	}

	/**
	 * Visit[List] 목록 List Count
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectVisitListCount(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectVisitListCount", param);
	}

	/**
	 * Visit[View] 목록 List
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitViewList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectVisitViewList", param);
	}

	/**
	 * Visit[View] 순번 목록 List
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitViewSnList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectVisitViewSnList", param);
	}

	/**
	 * Visit[View] 헤더 목록 List
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitViewHeaderList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectVisitViewHeaderList", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFForm(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFForm", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFVisitList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFVisitList", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFGroupList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFGroupList", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFLayoutList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFLayoutList", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFCommentList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFCommentList", param);
	}

	public void insertCRFComment(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCRFComment", param);
	}

	public void updateCRFComment(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateCRFComment", param);
	}

	/**
	 * VriablRowSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectVriablRowSn(Map<String, Object> map) throws Exception {
		return (Object) select("EDCC01DAO.selectVriablRowSn", map);
	}

	public void insertCRFRow(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCRFRow", param);
	}

	public void updateCRFRow(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateCRFRow", param);
	}

	public void insertCRFValue(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCRFValue", param);
	}

	public void updateCRFValue(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateCRFValue", param);
	}

	public void insertCRFQuery(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCRFQuery", param);
	}

	public void insertMasterQuery(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertMasterQuery", param);
	}

	public void updateMasterQuery(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateMasterQuery", param);
	}

	public Map<String, Object> selectGroupInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("EDCC01DAO.selectGroupInfo", map);
	}

	public void insertCRFGroup(Map<String, Object> param) throws Exception {
		insert("EDCC01DAO.insertCRFGroup", param);
	}

	public void updateCRFGroup(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateCRFGroup", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFQueryList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFQueryList", param);
	}

	public String selectCRFRow(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectCRFRow", param);
	}

	public String selectCRFSDV(Map<String, Object> param) throws Exception {
		return (String) select("EDCC01DAO.selectCRFSDV", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFSDVList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectCRFSDVList", param);
	}

	public void updateCRFSDV(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updateCRFSDV", param);
	}

	/**
	 * AtrailSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectAtrailSn(Map<String, Object> map) throws Exception {
		return (Object) select("EDCC01DAO.selectAtrailSn", map);
	}

	public void updateVisitSign(Map<String, String> param) throws Exception {
		update("EDCC01DAO.updateVisitSign", param);
	}

	public void updateSubjectSign(Map<String, String> param) throws Exception {
		update("EDCC01DAO.updateSubjectSign", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPatientList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCC01DAO.selectPatientList", param);
	}

	public void updatePatient(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updatePatient", param);
	}

	public void updatePatientVariable(Map<String, Object> param) throws Exception {
		update("EDCC01DAO.updatePatientVariable", param);
	}

}
