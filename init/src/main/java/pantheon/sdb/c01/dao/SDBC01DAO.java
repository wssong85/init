package pantheon.sdb.c01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBC01DAO")
public class SDBC01DAO extends EgovComAbstractDAO{

	/**
	 * Study List 조회
	 * 
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTrialList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("SDBC01DAO.selectTrialList", map);
	}
	
	/**
	 * Study 상세 조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectStudyInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC01DAO.selectStudyInfo", param);
	}
	
	/**
	 * EDC Study List 조회
	 * 
	 * @param map
	 * @return list
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectStudyList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC01DAO.selectStudyList", map);
	}
	
	/**
	 * 자발보고 List 조회
	 * 
	 * @param map
	 * @return list
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSpontaneousList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC01DAO.selectSpontaneousList",map);
	}
	
	/**
	 * Literature List 조회
	 * 
	 * @param map
	 * @return list
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLiteratureList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC01DAO.selectLiteratureList",map);
	}
	
	/**
	 * Literature 등록
	 * 
	 * @param map
	 * @return 
	 */
	
	public void insertLiteratureInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBC01DAO.insertLiteratureInfo",param);
		
	}
	
	/**
	 * Literature 수정
	 * 
	 * @param map
	 * @return 
	 */
	
	public void updateLiteratureInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.updateLiteratureInfo",param);
	}
	
	/**
	 * Literature 삭제
	 * 
	 * @param map
	 * @return 
	 */
	public void deleteLiteratureInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.deleteLiteratureInfo",param);		
		
	}
	
	
	/**
	 * Etc 조회
	 * 
	 * @param map
	 * @return list
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEtcList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC01DAO.selectEtcList",map);
	}
	
	/**
	 * ICSR 조회
	 * 
	 * @param map
	 * @return list
	 */

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectICSRList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBC01DAO.selectICSRList",map);
	}


	/**
	 * Etc 등록
	 * 
	 * @param map
	 * @return 
	 */
	public void insertEtcInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBC01DAO.insertEtcInfo",param);
		
	}
	/**
	 * Etc 수정
	 * 
	 * @param map
	 * @return 
	 */
	public void updateEtcInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.updateEtcInfo",param);
	}
	/**
	 * Etc 삭제
	 * 
	 * @param map
	 * @return 
	 */
	public void deleteEtcInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.deleteEtcInfo",param);		
		
	}
	/**
	 * Etc 상세조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEtcInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC01DAO.selectEtcInfo", param);
	}
	/**
	 * Literature 상세조회
	 * 
	 * @param map
	 * @return map
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLiteratureInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBC01DAO.selectLiteratureInfo", map);
	}

	/**
	 * Study 등록
	 * 
	 * @param map
	 * @return 
	 */
	public void insertStudyInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBC01DAO.insertStudyInfo",param);
		
	}
	/**
	 * Study 수정
	 * 
	 * @param map
	 * @return 
	 */
	public void updateStudyInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.updateStudyInfo",param);
	}
	/**
	 * Study 삭제
	 * 
	 * @param map
	 * @return 
	 */
	public void deleteStudyInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBC01DAO.deleteStudyInfo",param);		
		
	}

	public String selectStudyListCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (String)select("SDBC01DAO.selectStudyListCount", map);
	}

	





	
}
