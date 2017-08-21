package pantheon.ctms.j11.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * Popup 관리를 위한 데이터 접근 클래스
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
@Repository("DMCJ11DAO")
public class DMCJ11DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ11DAO.class);

    //기관 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectInsttList", map);
	}
	
	//To Do List 기관 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTodoListInsttInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectTodoListInsttInfo", map);
	}
	
    //사용자 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskUserList(Map<String, String> map) {
		
		List<Map<String, Object>> list = null;
		
		String userType = map.get("USER_TYPE");
		System.out.println("userType : "+userType);
		
		if(userType.compareTo("") == 0){
			list = (List<Map<String, Object>>)list("DMCJ11DAO.selectTaskUserList", map);
		}
		else{
			list = (List<Map<String, Object>>)list("DMCJ11DAO.selectUserList", map);
		}
		
		return list;
	}
	
    //반려사유 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReturnReasonInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectReturnReasonInfo", map);
	}
	
    //반려사유 생성
	public void insertReturnReasonInfo(Map<String, String> map) {
		update("DMCJ11DAO.insertReturnReasonInfo", map);
	}

    //반려사유 수정
	public void updateReturnReasonInfo(Map<String, String> map) {
		update("DMCJ11DAO.updateReturnReasonInfo", map);
	}
	
    //반려사유 삭제
	public void deleteReturnReasonInfo(Map<String, String> map) {
		update("DMCJ11DAO.deleteReturnReasonInfo", map);
	}
	/*---------------------------------------------------------------------------------------------------*/
	/**
	 * 
	 * @param map
	 */
	public void insertDmFileMstr(Map<String, String> map) {
		insert("DMCJ11DAO.insertDmFileMastr", map);
	}
	
	/**
	 * 
	 * @param map
	 */
	public void insertDmFileDetail(Map<String, String> map) {
		insert("DMCJ11DAO.insertDmFileDetail", map);
	}
	
	/**
	 * 
	 * @param deleteDmFIleDetailByDmFileMstrSn
	 * @return
	 */
	public int deleteDmFIleDetailByDmFileMstrSn(String FILE_MASTR_SN) {
		return delete("DMCJ11DAO.deleteDmFIleDetailByDmFileMstrSn", FILE_MASTR_SN);
	}
	
	/**
	 * 
	 * @param selectDmFileDetailForDmDetailDelete
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectDmFileDetailForDmDetailDelete(String FILE_MASTR_SN) {
		return (List<Map<String, String>>) list("DMCJ11DAO.selectDmFileDetailForDmDetailDelete", FILE_MASTR_SN);
	}
	
    //파일 상세정보 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDmFileDetailInfo(Map<String, String> map) {
		return (Map<String, Object>) select("DMCJ11DAO.selectDmFileDetailInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDmFileMasterForSN(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectDmFileMasterForSN", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectTaskList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserRoleInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectUserRoleInfoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ11DAO.selectCommonCodeList", map);
	}
	
	/**
	 * 승인된 연구자 정보 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map){
		return (List<Map<String,Object>>) list("DMCJ11DAO.selectRsrchUserInfo" , map);
	}
	

}
