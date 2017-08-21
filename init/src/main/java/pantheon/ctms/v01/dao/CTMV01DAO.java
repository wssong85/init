package pantheon.ctms.v01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 공통코드 관리를 위한 데이터 접근 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
@Repository("CTMV01DAO")
public class CTMV01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMV01DAO.class);

    //IRB 기초 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBBasicInfoList", map);
	}
	
    //IRB 연락처 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBCttpcList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBCttpcList", map);
	}

    //IRB 심의비 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBDlbrtctList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBDlbrtctList", map);
	}

    //IRB 연구비 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBRsrcctList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBRsrcctList", map);
	}

    //IRB 심의 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBDlbrtList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBDlbrtList", map);
	}

    //SAE 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBSaeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBSaeList", map);
	}

    //e-IRB 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMV01DAO.selectIRBInfoList", map);
	}
	
	//IRB 기초 정보 입력
	public void insertIRBBasicInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBBasicInfo", map);
	}
	//IRB 기초 정보 수정
	public void updateIRBBasicInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBBasicInfo", map);
	}
	//IRB 기초 정보 삭제
	public void deleteIRBBasicInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBBasicInfo", map);
	}
	
	//IRB 연락처 입력
	public void insertIRBCttpcInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBCttpcInfo", map);
	}
	//IRB 연락처 수정
	public void updateIRBCttpcInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBCttpcInfo", map);
	}
	//IRB 연락처 삭제
	public void deleteIRBCttpcInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBCttpcInfo", map);
	}	

	
	//IRB 심의비 입력
	public void insertIRBDlbrtctInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBDlbrtctInfo", map);
	}
	//IRB 심의비 수정
	public void updateIRBDlbrtctInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBDlbrtctInfo", map);
	}
	//IRB 심의비 삭제
	public void deleteIRBDlbrtctInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBDlbrtctInfo", map);
	}

	
	//IRB 연구비 입력
	public void insertIRBRsrcctInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBRsrcctInfo", map);
	}
	//IRB 연구비 수정
	public void updateIRBRsrcctInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBRsrcctInfo", map);
	}
	//IRB 연구비 삭제
	public void deleteIRBRsrcctInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBRsrcctInfo", map);
	}


	//IRB 심의 입력
	public void insertIRBDlbrtInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBDlbrtInfo", map);
	}
	//IRB 심의 수정
	public void updateIRBDlbrtInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBDlbrtInfo", map);
	}
	//IRB 심의 삭제
	public void deleteIRBDlbrtInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBDlbrtInfo", map);
	}


	//IRB e-IRB 입력
	public void insertIRBInfoInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBInfoInfo", map);
	}
	//IRB e-IRB 수정
	public void updateIRBInfoInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBInfoInfo", map);
	}
	//IRB e-IRB 삭제
	public void deleteIRBInfoInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBInfoInfo", map);
	}

	//IRB SAE 입력
	public void insertIRBSaeInfo(Map<String, Object> map) {
		insert("CTMV01DAO.insertIRBSaeInfo", map);
	}
	//IRB SAE 수정
	public void updateIRBSaeInfo(Map<String, Object> map) {
		update("CTMV01DAO.updateIRBSaeInfo", map);
	}
	//IRB SAE 삭제
	public void deleteIRBSaeInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteIRBSaeInfo", map);
	}

	//IRB 연락처 삭제
	public void deleteMasterIRBCttpcInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBCttpcInfo", map);
	}	
	//IRB 심의비 삭제
	public void deleteMasterIRBDlbrtctInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBDlbrtctInfo", map);
	}
	//IRB 연구비 삭제
	public void deleteMasterIRBRsrcctInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBRsrcctInfo", map);
	}
    //IRB 심의 삭제
	public void deleteMasterIRBDlbrtInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBDlbrtInfo", map);
	}
	//IRB e-IRB 삭제
	public void deleteMasterIRBInfoInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBInfoInfo", map);
	}
	//IRB SAE 삭제
	public void deleteMasterIRBSaeInfo(Map<String, Object> map) {
		update("CTMV01DAO.deleteMasterIRBSaeInfo", map);
	}

}
