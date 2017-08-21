package pantheon.ctms.f01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 공통코드 관리를 위한 데이터 접근 클래스
 * @author 김복민
 * @since 2016.02.26
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.26  김복민          최초 생성
 *  
 */
@Repository("CTMF01DAO")
public class CTMF01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMF01DAO.class);
    //paper 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPaperContractList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectPaperContractList", map);
	}
	//계약서 popup 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectContractPopUpList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectContractPopUpList", map);
	}	

	//paper 계약서 IRB 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeListByIRB_AT(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectCommonCodeListByIRB_AT", map);
	}	
	
	//계약서 상태 공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectCommonCodeListBySTTUS", map);
	}	
		
	//기관정보 입력
	public void insertCM_INSTT(Map<String, Object> map) {
		insert("CTMF01DAO.insertCM_INSTT", map);
	}
	//paper 계약서 계약정보 입력
	public void insertPaperContractByCNT(Map<String, Object> map) {
		insert("CTMF01DAO.insertPaperContractByCNT", map);
	}
	
	//과제사용자 정보 입력
	public void insertTaskUserInfo(Map<String, Object> map) {
		insert("CTMF01DAO.insertTaskUserInfo", map);
	}
	
	//사용자 롤정보 입력
	public void insertUserRoleInfo(Map<String, Object> map) {
		insert("CTMF01DAO.insertUserRoleInfo", map);
	}
	
	//사용자 과제 롤정보 입력
	public void insertTaskUserRoleInfo(Map<String, Object> map) {
		insert("CTMF01DAO.insertTaskUserRoleInfo", map);
	}
	
	//사용자 과제 롤정보 입력전 삭제
	public void deleteTaskUserRoleInfo(Map<String, Object> map) {
		insert("CTMF01DAO.deleteTaskUserRoleInfo", map);
	}
	
	//중복체크 조회
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectRsrchUserOverlap(Map<String, String> map){
		return (List<Map<String,Object>>) list("CTMF01DAO.selectRsrchUserOverlap", map);
	}
	
	//paper 사용자 정보 입력
	public void insertPaperContractByUSER(Map<String, Object> map) {
		insert("CTMF01DAO.insertPaperContractByUSER", map);
	}
	
	//paper 연구자 정보 입력
	public void insertPaperContractByRSRCHUSER(Map<String, Object> map) {
		insert("CTMF01DAO.insertPaperContractByRSRCHUSER", map);
	}
	
	//paper 계약정보 수정
	public void updatePaperContractByCNT(Map<String, Object> map) {
		update("CTMF01DAO.updatePaperContractByCNT", map);
	}
	
	//paper 사용자정보 수정
	public void updatePaperContractByUSER(Map<String, Object> map) {
		update("CTMF01DAO.updatePaperContractByUSER", map);
	}
	
	//paper 연구자정보 수정
		public void updatePaperContractByRSRCHUSER(Map<String, Object> map) {
			update("CTMF01DAO.updatePaperContractByRSRCHUSER", map);
		}
	
	//CTMF01DAO.insertPaperContractByUSER
	//insertPaperContractByRSRCHUSER
	/*-------------------------------------------------------------------------------------------------------------------*/
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTotalContractList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectTotalContractList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectElectContractList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMF01DAO.selectElectContractList", map);
	}
	
	//paper 계약정보 수정
	public void updateElectContractStatus(Map<String, Object> map) {
		update("CTMF01DAO.updateElectContractStatus", map);
	}

}
