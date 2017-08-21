package pantheon.edc.k04.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("EDCK04DAO")
public class EDCK04DAO extends EgovComAbstractDAO {
	
	/**
	 * DB Freezing selectTaskInfo
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectEdcTaskList(Map<String, Object> param)	throws Exception {	
		// TODO Auto-generated method stub
		param.put("LOCALE", Util.getStrLocale());
		
		return  (List<Map<String, Object>>)list("EDCK04DAO.selectEdcTaskList", param);
	}
	
	/**
	 * DB Freezing selectEdcSiteList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectEdcSiteList(Map<String, Object> param)	throws Exception {	
		// TODO Auto-generated method stub
		param.put("LOCALE", Util.getStrLocale());
		
		return  (List<Map<String, Object>>)list("EDCK04DAO.selectEdcSiteList", param);
	}
	
	/**
	 * DB Freezing selectEdcSubInsttList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectEdcSubInsttList(Map<String, Object> param)	throws Exception {	
		// TODO Auto-generated method stub
		param.put("LOCALE", Util.getStrLocale());
		
		return  (List<Map<String, Object>>)list("EDCK04DAO.selectEdcSubInsttList", param);
	}
	
	/**
	 * DB Freezing selectTaskInfo
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectTaskInfo(Map<String, Object> param)	throws Exception {	
		// TODO Auto-generated method stub
		param.put("LOCALE", Util.getStrLocale());
		
		List<Map<String, Object>> tmp = (List<Map<String, Object>>)list("EDCK04DAO.selectTaskInfo", param);
		
		return tmp;
//		return (Map<String, Object>) select("EDCK04DAO.selectTaskInfo", param);
	}

	/**
	 * DB Freezing updateEdcCrTaskReqNo
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateEdcCrTaskReqNo(Map<String, Object> map) {
		insert("EDCK04DAO.updateEdcCrTaskReqNo", map);
	}
	
	/**
	 * DB Freezing selectSttSanc
	 * @param param
	 * @return
	 * @throw Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSttSanc(Map<String, Object> map){
		return (Map<String, Object>) select("EDCK04DAO.selectSttSanc", map);
	}
	
	/**
	 * DB Freezing updateEdcCrTaskStt
	 * @param param
	 * @return
	 * @throw Exception
	 */
	public void updateEdcCrTaskFrzStt(Map<String, Object> map){
		insert("EDCK04DAO.updateEdcCrTaskFrzStt", map);
	}
	
	/**
	 * DB Freezing insertEdcFreezingHist
	 * @param param
	 * @return
	 * @throw Exception
	 */
	public void insertEdcFreezingHist(Map<String, Object> map){
		insert("EDCK04DAO.insertEdcFreezingHist", map);
	}
	
	/**
	 * DB Freezing selectEdcFrzngHist
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectEdcFrzngHist(Map<String, Object> param)	throws Exception {	

		param.put("LOCALE", Util.getStrLocale());
		
		return (List<Map<String, Object>>)list("EDCK04DAO.selectEdcFrzngHist", param);
	}

	/**
	 * DB Freezing updateFrzEdcCrInsttFrm
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateFrzEdcCrInsttFrm(Map<String, Object> map) {
		insert("EDCK04DAO.updateFrzEdcCrInsttFrm", map);
	}

	/**
	 * DB Freezing updateFrzEdcCfSubject
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateFrzEdcCfSubject(Map<String, Object> map) {
		insert("EDCK04DAO.updateFrzEdcCfSubject", map);
	}
	
	/**
	 * DB Freezing selectCmUserRoleList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public List<Map<String, Object>> selectCmUserRoleList(Map<String, Object> param)	throws Exception {	

		param.put("LOCALE", Util.getStrLocale());
		
		return (List<Map<String, Object>>)list("EDCK04DAO.selectCmUserRoleList", param);
	}

	/**
	 * DB Freezing updateSubFrzEdcCrInsttFrm
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateSubFrzEdcCrInsttFrm(Map<String, Object> map) {
		insert("EDCK04DAO.updateFrzEdcCfSubject", map);
	}
	
	/**
	 * DB Freezing selectChkFrzSubGrp
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
//	public Map<String, Object> selectTaskInfo(Map<String, Object> param)	throws Exception {
	public Map<String, Object> selectChkFrzSubGrp(Map<String, Object> param)	throws Exception {	

		param.put("LOCALE", Util.getStrLocale());
		
		return (Map<String, Object>)select("EDCK04DAO.selectChkFrzSubGrp", param);
	}
}
