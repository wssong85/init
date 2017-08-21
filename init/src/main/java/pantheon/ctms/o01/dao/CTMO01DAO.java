package pantheon.ctms.o01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMO01DAO")
public class CTMO01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMO01DAO.class);
	
    //연구자 정보 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectRsrchUserInfo", map);
	}
	
    //연구자 정보 입력
	public void updateRsrchUserInfo(Map<String, Object> map) {
		update("CTMO01DAO.updateRsrchUserInfo", map);
	}
	
	//연구자 중단여부 입력
	public void updateActive(Map<String, Object> map) {
		update("CTMO01DAO.updateActive", map);
	}
	
	//조사연구기관 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchInstt(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectRsrchInstt", map);
	}
	
	//조사연구기관 저장
	public void insertRsrchInstt(Map<String, Object> map) {
		insert("CTMO01DAO.insertRsrchInstt", map);		
	}
	
	//계약관리 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCntrctManage(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectCntrctManage", map);
	}
	
	//계약관리 저장
	public void updateCntrctManage(Map<String, Object> map) {
		insert("CTMO01DAO.updateCntrctManage", map);		
	}
	
	//연구비 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResearchFunds(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectResearchFunds", map);
	}
	
	//연구비 insert
	public void insertResearchFunds(Map<String, Object> map) {
		insert("CTMO01DAO.insertResearchFunds", map);		
	}
	
	//연구비 update
	public void updateResearchFunds(Map<String, Object> map) {
		update("CTMO01DAO.updateResearchFunds", map);		
	}
	
	//연구비 delete
	public void deleteResearchFunds(Map<String, Object> map) {
		update("CTMO01DAO.deleteResearchFunds", map);		
	}
	
	//계약관리 연구비 지급 횟수
	public void updatePymntCnt(Map<String, Object> map) {
		update("CTMO01DAO.updatePymntCnt", map);		
	}
	
	//IRB심의 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchDlbrt(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectRsrchDlbrt", map);
	}
	
	//IRB심의 insert
	public void insertRsrchDlbrt(Map<String, Object> map) {
		insert("CTMO01DAO.insertRsrchDlbrt", map);		
	}
	
	//IRB심의 update
	public void updateRsrchDlbrt(Map<String, Object> map) {
		update("CTMO01DAO.updateRsrchDlbrt", map);		
	}
		
	//IRB심의 delete
	public void deleteRsrchDlbrt(Map<String, Object> map) {
		update("CTMO01DAO.deleteRsrchDlbrt", map);		
	}
	
	//동의서 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchWrtcns(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectRsrchWrtcns", map);
	}
	
	//동의서 insert
	public void insertRsrchWrtcns(Map<String, Object> map) {
		insert("CTMO01DAO.insertRsrchWrtcns", map);		
	}
	
	//동의서 update
	public void updateRsrchWrtcns(Map<String, Object> map) {
		update("CTMO01DAO.updateRsrchWrtcns", map);		
	}
	
	//동의서 delete
	public void deleteRsrchWrtcns(Map<String, Object> map) {
		update("CTMO01DAO.deleteRsrchWrtcns", map);		
	}
	
	//버전관리 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchVer(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMO01DAO.selectRsrchVer", map);
	}
	
	//동의서 insert
	public void insertRsrchVer(Map<String, Object> map) {
		insert("CTMO01DAO.insertRsrchVer", map);		
	}
	
	//동의서 update
	public void updateRsrchVer(Map<String, Object> map) {
		insert("CTMO01DAO.updateRsrchVer", map);		
	}
	
	//동의서 delete
	public void deleteRsrchVer(Map<String, Object> map) {
		insert("CTMO01DAO.deleteRsrchVer", map);		
	}

}

