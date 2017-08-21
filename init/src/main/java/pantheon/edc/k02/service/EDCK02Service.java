package pantheon.edc.k02.service;

import java.util.List;
import java.util.Map;

public interface EDCK02Service {
	public List<Map<String, Object>> selectCRFList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectCRFVersion(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectGroupList(Map<String, Object> param) throws Exception;

	public void insertGroupList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectVariableList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectGroupInsideList(Map<String, Object> param) throws Exception;

	public void insertGroupInsideList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectVisitInsideList(Map<String, Object> param) throws Exception;

	public void insertVisitInsideList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectDictionary(Map<String, Object> param) throws Exception;

	public void insertDictionary(List<Map<String, Object>> list) throws Exception;

	public void insertEDCVersion(Map<String, Object> param) throws Exception;

	public void copyEDCVersion(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectUserVariableList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectUserVariableOptionList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectUserVariableDetail(Map<String, Object> param) throws Exception;

	public void insertUserVariable(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectSameVariable(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisitInfoList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectGroupListForVisit(Map<String, Object> param) throws Exception;

	public void insertVisitInfoList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectElementList(Map<String, Object> param) throws Exception;

	public void insertElementList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectArmList(Map<String, Object> param) throws Exception;

	public void insertArmList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectInclusionList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectInclusionDetail(Map<String, Object> param) throws Exception;

	public void insertInclusionList(List<Map<String, Object>> list) throws Exception;

	public void insertInclusionVersion(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectTrialSummaryList(Map<String, Object> param) throws Exception;

	public void insertTrialSummary(List<Map<String, Object>> list) throws Exception;

	public Map<String, Object> selectChangeReason(Map<String, Object> param) throws Exception;

	public void updateChangeReason(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectArmCodeList(Map<String, Object> param) throws Exception;

	public void insertArmCodeList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectGroupListForLayout(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectLayoutList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCDISCCodeList(Map<String, Object> param) throws Exception;

	public void insertLayoutList(List<Map<String, Object>> list) throws Exception;

	public Map<String, Object> selectDescription(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectAllEditCheckList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectEditCheckDetail(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectDisableList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectTaskBlindPk(Map<String, Object> param) throws Exception;

	public void updateTaskBlindPk(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectEditVariableList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectEditSeqList(Map<String, Object> param) throws Exception;

	public Object insertEditCheck(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectCodingList(Map<String, Object> param) throws Exception;

	public void insertCodingList(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectCodingVariableList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectDictionaryVersionList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectTaskType(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectAllVariableList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVariableSECodeList(Map<String, Object> param) throws Exception;

}
