package pantheon.edc.k02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EDCK02DAO")
public class EDCK02DAO extends EgovComAbstractDAO {

	/**
	 * CRF 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRFList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectCRFList", map);
	}

	/**
	 * CRF 버전 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCRFVersion(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectCRFVersion", map);
	}

	/**
	 * Group 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectGroupList", map);
	}

	/**
	 * GroupSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectGroupSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectGroupSn", map);
	}

	/**
	 * 그룹정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertGroup(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertGroup", map);
	}

	/**
	 * 그룹정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateGroup(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateGroup", map);
	}

	/**
	 * Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectVariableList", map);
	}

	/**
	 * Group 내 Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupInsideList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectGroupInsideList", map);
	}

	/**
	 * VRIABL_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectVriablSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectVriablSn", map);
	}

	/**
	 * 그룹 내 Variable 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertGroupInside(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertGroupInside", map);
	}

	/**
	 * 그룹 내 Variable 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateGroupInside(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateGroupInside", map);
	}

	/**
	 * Visit 설정 Group 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupListForVisit(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectGroupListForVisit", map);
	}

	/**
	 * Visit 내 Group 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInsideList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectVisitInsideList", map);
	}

	/**
	 * VISIT_GROUP_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectVisitGroupSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectVisitGroupSn", map);
	}

	/**
	 * Visit 내 Group 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertVisitInside(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertVisitInside", map);
	}

	/**
	 * Visit 내 Group 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateVisitInside(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateVisitInside", map);
	}

	/**
	 * Dictionary 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDictionary(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectDictionary", map);
	}

	/**
	 * CRF 버전 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertCRF(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertCRF", map);
	}

	/**
	 * 이전 EDC VER 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectOldEDCVer(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectOldEDCVer", map);
	}

	/**
	 * 사용자 Variable 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectUserVariableList", map);
	}

	/**
	 * 사용자 Variable 옵션 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserVariableOptionList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectUserVariableOptionList", map);
	}

	/**
	 * VRIABL_OPTN_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectOptnSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectOptnSn", map);
	}

	/**
	 * UserVariableOption등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertUserVariableOption(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertUserVariableOption", map);
	}

	/**
	 * UserVariableOption수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateUserVariableOption(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateUserVariableOption", map);
	}

	/**
	 * User Variable Detail 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUserVariableDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectUserVariableDetail", map);
	}

	/**
	 * User Domain 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertUserDomain(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertUserDomain", map);
	}

	/**
	 * User Domain 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateUserDomain(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateUserDomain", map);
	}

	/**
	 * User Variable 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertUserVariable(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertUserVariable", map);
	}

	/**
	 * User Variable 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateUserVariable(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateUserVariable", map);
	}

	/**
	 * 동일 Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSameVariable(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectSameVariable", map);
	}

	/**
	 * Visit 정보 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectVisitInfoList", map);
	}

	/**
	 * VISIT_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectVisitSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectVisitSn", map);
	}

	/**
	 * Visit 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertVisitInfo(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertVisitInfo", map);
	}

	/**
	 * Visit 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateVisitInfo(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateVisitInfo", map);
	}

	/**
	 * Element목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectElementList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectElementList", map);
	}

	/**
	 * TE_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectTeSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectTeSn", map);
	}

	/**
	 * Element목록 등록
	 * 
	 * @param map
	 */
	public void insertElement(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertElement", map);
	}

	/**
	 * Element목록 수정
	 * 
	 * @param map
	 */
	public int updateElement(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateElement", map);
	}

	/**
	 * Arm목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectArmList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectArmList", map);
	}

	/**
	 * TA_DETAIL_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectTaDetailSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectTaDetailSn", map);
	}

	/**
	 * Arm목록 등록
	 * 
	 * @param map
	 */
	public void insertArm(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertArm", map);
	}

	/**
	 * Arm목록 수정
	 * 
	 * @param map
	 */
	public int updateArm(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateArm", map);
	}

	/**
	 * Inclusion/Exclusion목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInclusionList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectInclusionList", map);
	}

	/**
	 * Inclusion/Exclusion 상세 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectInclusionDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectInclusionDetail", map);
	}

	/**
	 * TI_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectTiSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectTiSn", map);
	}

	/**
	 * Inclusion/Exclusion 등록
	 * 
	 * @param map
	 */
	public void insertInclusion(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertInclusion", map);
	}

	/**
	 * Inclusion/Exclusion 수정
	 * 
	 * @param map
	 */
	public int updateInclusion(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateInclusion", map);
	}

	/**
	 * selectNewInclusionVersion 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewInclusionVersion(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectNewInclusionVersion", map);
	}

	/**
	 * Inclusion/Exclusion 버전 등록
	 * 
	 * @param map
	 */
	public void insertInclusionVersion(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertInclusionVersion", map);
	}

	/**
	 * TrialSummary목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTrialSummaryList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectTrialSummaryList", map);
	}

	/**
	 * TS_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectTsSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectTsSn", map);
	}

	/**
	 * TrialSummary 등록
	 * 
	 * @param map
	 */
	public void insertTrialSummary(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertTrialSummary", map);
	}

	/**
	 * TrialSummary 수정
	 * 
	 * @param map
	 */
	public int updateTrialSummary(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateTrialSummary", map);
	}

	/**
	 * 변경사유 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectChangeReason(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectChangeReason", map);
	}

	/**
	 * 변경사유 수정
	 * 
	 * @param map
	 */
	public int updateChangeReason(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateChangeReason", map);
	}

	/**
	 * CRF 상태 수정
	 * 
	 * @param map
	 */
	public int updateCRFStatus(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateCRFStatus", map);
	}

	/**
	 * 과제정보 Arm목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectArmCodeList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck02DAO.selectArmCodeList", map);
	}

	/**
	 * TA_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectTaSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectTaSn", map);
	}

	/**
	 * Arm정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertArmCode(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertArmCode", map);
	}

	/**
	 * Arm정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateArmCode(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateArmCode", map);
	}

	/**
	 * User 도메인 존재 유무 확인
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUserDomain(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectUserDomain", map);
	}

	/**
	 * Layout 설정할 Group Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupListForLayout(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectGroupListForLayout", map);
	}

	/**
	 * Group Layout 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLayoutList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectLayoutList", map);
	}

	/**
	 * CDISC CodeList 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCDISCCodeList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectCDISCCodeList", map);
	}

	/**
	 * Set_Sn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectSetSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectSetSn", map);
	}

	/**
	 * SET 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertSet(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertSet", map);
	}

	/**
	 * SET 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateSet(Map<String, Object> map) throws Exception {
		return delete("edck02DAO.updateSet", map);
	}

	/**
	 * Set_Row_Sn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectSetRowSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectSetRowSn", map);
	}

	/**
	 * SET Row 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertSetRow(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertSetRow", map);
	}

	/**
	 * SET Row 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateSetRow(Map<String, Object> map) throws Exception {
		return delete("edck02DAO.updateSetRow", map);
	}

	/**
	 * Set_Vriabl_Sn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectSetVriablSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectSetVriablSn", map);
	}

	/**
	 * set_variable 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertSetVariable(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertSetVariable", map);
	}

	/**
	 * set_variable 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateSetVariable(Map<String, Object> map) throws Exception {
		return delete("edck02DAO.updateSetVariable", map);
	}

	/**
	 * Description 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDescription(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectDescription", map);
	}

	/**
	 * Description 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertDescription(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertDescription", map);
	}

	/**
	 * Description 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateDescription(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateDescription", map);
	}

	/**
	 * EditCheck 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllEditCheckList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectAllEditCheckList", map);
	}

	/**
	 * EditCheckDetail 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEditCheckDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectEditCheckDetail", map);
	}

	/**
	 * EditCheck 비활성 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDisableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectDisableList", map);
	}

	/**
	 * SetSnCheck 조회
	 * 
	 * @param map
	 * @return
	 */
	public int selectSetSnCheck(Map<String, Object> map) throws Exception {
		return (int) select("edck02DAO.selectSetSnCheck", map);
	}

	/**
	 * Task BlindPk 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTaskBlindPk(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectTaskBlindPk", map);
	}

	/**
	 * Task BlindPk 저장
	 * 
	 * @param map
	 * @return
	 */
	public int updateTaskBlindPk(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateTaskBlindPk", map);
	}

	/**
	 * EditCheck SEQ 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEditSeqList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectEditSeqList", map);
	}

	/**
	 * EditCheck Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEditVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectEditVariableList", map);
	}

	/**
	 * Set 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSetList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectSetList", map);
	}

	/**
	 * SetRow 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSetRowList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectSetRowList", map);
	}

	/**
	 * SetVariable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSetVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectSetVariableList", map);
	}

	/**
	 * EditCheckSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectEditCheckSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectEditCheckSn", map);
	}

	/**
	 * EditCheck 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertEditCheck(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertEditCheck", map);
	}

	/**
	 * EditCheck 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateEditCheck(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateEditCheck", map);
	}

	/**
	 * InputLmttSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectInputLmttSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectInputLmttSn", map);
	}

	/**
	 * Disable 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertDisable(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertDisable", map);
	}

	/**
	 * Disable 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateDisable(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateDisable", map);
	}

	/**
	 * CRF 복사 edit check 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEditCheckList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectEditCheckList", map);
	}

	/**
	 * Coding 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodingList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectCodingList", map);
	}

	/**
	 * CodingSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectCodingSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectCodingSn", map);
	}

	/**
	 * Coding 정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertCoding(Map<String, Object> map) throws Exception {
		insert("edck02DAO.insertCoding", map);
	}

	/**
	 * Coding 정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateCoding(Map<String, Object> map) throws Exception {
		return update("edck02DAO.updateCoding", map);
	}

	/**
	 * 선택한 코딩의 Variable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodingVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectCodingVariableList", map);
	}

	/**
	 * Dictionary Version 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDictionaryVersionList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectDictionaryVersionList", map);
	}

	/**
	 * Description 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDescriptionList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectDescriptionList", map);
	}

	/**
	 * CISC Vriable Name 으로 DOMN_VRIABL_SN 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectCDISCSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectCDISCSn", map);
	}

	/**
	 * UserDomnVriablSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectUserDomnVriablSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck02DAO.selectUserDomnVriablSn", map);
	}

	/**
	 * 과제 타입 조회
	 * 
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectTaskType(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck02DAO.selectTaskType", map);
	}

	/**
	 * AllVariable 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllVariableList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectAllVariableList", map);
	}

	/**
	 * VariableSECode 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVariableSECodeList(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("edck02DAO.selectVariableSECodeList", map);
	}

}
