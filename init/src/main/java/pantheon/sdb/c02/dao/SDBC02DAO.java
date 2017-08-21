package pantheon.sdb.c02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * @author ksm1118
 *
 */
@Repository("SDBC02DAO")
public class SDBC02DAO  extends EgovComAbstractDAO{
	/**
	 * 다국어 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertMul(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		System.out.println(iMap);
		insert("SDBC02DAO.insertMul", iMap);
	}
	
	/**
	 * 다국어 수정
	 * 
	 * @param map
	 * @return
	 */
	public void updateMul(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		System.out.println(iMap);
		update("SDBC02DAO.updateMul", iMap);
	}

	/**
	 * 변경사유등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertReason(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertReason",iMap);
		
	}
	/**
	 * Narrative 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertNarrativeInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertNarrativeInfo",iMap);
	}
	/**
	 * Narrative 수정
	 * 
	 * @param map
	 * @return
	 */
	public void updateNarrativeInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateNarrativeInfo",iMap);
	}
	/**
	 * Narrative 삭제
	 * 
	 * @param map
	 * @return
	 */
	public void deleteNarrativeInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteNarrativeInfo",iMap);
	}
	
	/**
	 * Narrative 상세조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNarrativeInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectNarrativeInfo", iMap);
	}

	/**
	 * 소스 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> slSource_Study(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.slSource_Study", iMap);
	}
	/**
	 * 소스 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> slSource_Spontaneous(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.slSource_Spontaneous", iMap);
	}
	/**
	 * 소스 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> slSource_Literature(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.slSource_Literature", iMap);
	}
	/**
	 * 소스 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> slSource_Etc(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.slSource_Etc", iMap);
	}
	/**
	 * 소스 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> slSource_ICSR(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.slSource_ICSR", iMap);
	}
	/**
	 * Demographics 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertDemographics(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertDemographics",iMap);
		
	}
	/**
	 * Demographics 수정
	 * 
	 * @param map
	 * @return
	 */
	public void updateDemographics(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDemographics",iMap);
	}
	/**
	 * Demographics 삭제
	 * 
	 * @param map
	 * @return
	 */
	public void deleteDemographics(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteDemographics",iMap);
	}
	/**
	 * Manufactorer 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertManufactorer(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertManufactorer",iMap);
	}
	/**
	 * Reporter 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertReporter(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertReporter",iMap);
	}


	public void updateManufactorer(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateManufactorer",iMap);
	}
	
	public void updateReporter(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateReporter",iMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDemographics(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDemographics", iMap);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDemographics_Case(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDemographics_Case", param);
	}

	public void insertParent(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertParent",iMap);
	}

	public void updateParent(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateParent",iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFollow(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectFollow", iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSiteSubject(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectSiteSubject", iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLabList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectLabList", param);
	}

	public void insertLabInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertLabInfo", iMap);
	}

	public void updateLabInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateLabInfo", iMap);
	}

	public void deleteLabInfo(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteLabInfo", iMap);
	}

	public void updateDemographicsLab(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDemographicsLab",iMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLabListInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectLabListInfo", param);
		
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDemographicsLab(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDemographicsLab", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDemographicsMedi(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDemographicsMedi", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMedicalList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectMedicalList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMedicalHistoryInfo(
			Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectMedicalHistoryInfo", param);
	}

	public void insertMedicalHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertMedicalHistory", iMap);
	}

	public void updateDemographicsMedi(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDemographicsMedi",iMap);
	}

	public void updateMedicalHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateMedicalHistory", iMap);	
		
	}

	public void deleteMedicalHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteMedicalHistory", iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDrugHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectDrugHistory", iMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDrugHistoryInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDrugHistoryInfo", param);
	}

	public void insertDrugHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertDrugHistory", iMap);
	}

	public void updateDrugHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDrugHistory",iMap);
	}

	public void deleteDrugHistory(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteDrugHistory", iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCasualityList(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectCasualityList", iMap);
	}

	public void updateCasuality(Map<String, Object> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateCasuality",iMap);
	}

	public void insertDrug(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertDrug", iMap);
	}

	public void updateDrug(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDrug",iMap);
	}

	public void deleteDrug(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteDrug", iMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDrugList(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectDrugList", iMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDrugInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDrugInfo", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAeList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectAeList", param);
	}

	/**
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAeInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectAeInfo", param);
	}

	/**
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDemoAeInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC02DAO.selectDemoAeInfo", param);
	}

	public void updateDemoAe(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateDemoAe", iMap);
	}

	public void insertAe(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertAe", iMap);
	}

	public void updateAe(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateAe", iMap);
	}

	public void deleteAe(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		update("SDBC02DAO.deleteAe", iMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, String> selectMulKorEng(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		return (Map<String, String>) select("SDBC02DAO.selectMulKorEng",iMap);
	}

	public void updateTransfer(Map<String, String> map) {	
		
		// TODO Auto-generated method stub
		update("SDBC02DAO.updateTransfer", map);
		
	}

	public void insertFollowUp(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp", map);
	}

	public void insertFollowUp_Medical_H(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Medical_H", map);
	}

	public void insertFollowUp_Lab(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Lab", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectFollowUpAe(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectFollowUpAe", map);
	}

	public void insertAeRelation(Map<String, String> map_relation) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertAeRelation",map_relation);
	}

	public void insertFollowUp_Ae(Map<String, String> map_ae) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Ae" ,map_ae);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectAeRelation(
			Map<String, String> map_relation) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectAeRelation", map_relation);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectDrug(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectDrug", map);
	}

	public void insertFollowUp_Drug(Map<String, String> map_drug) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Drug" ,map_drug);
	}

	public void insertFollowUp_Drug_H(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Drug_H" ,map);
	}

	public void insertFollowUp_Narative(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertFollowUp_Narative" ,map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCaseListPop(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC02DAO.selectCaseListPop", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectAe_C(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectAe_C", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectDrug_C(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectDrug_C", map);
	}

	public void insertCasuality_T(Map<String, String> map_ae) {
		// TODO Auto-generated method stub
		insert("SDBC02DAO.insertCasuality_T", map_ae);
	}

	/**
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCasuality(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectCasuality", map);
	}

	/**
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectFollowUpMedicalH(
			Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, String>>) list("SDBC02DAO.selectFollowUpMedicalH", map);
	}

	

	



}
