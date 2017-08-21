package pantheon.com.z02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 업로드 관리를 위한 데이터 접근 클래스
 * @author 송원석
 * @since 2016.03.02
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.02  송원석          최초 생성
 *  
 */
@Repository("COMZ02DAO")
public class COMZ02DAO extends EgovComAbstractDAO{

	/**
	 * 
	 * @param map
	 */
	public void insertDmFileMstr(Map<String, String> map) {
		insert("COMZ02DAO.insertDmFileMastr", map);
	}
	
	/**
	 * 
	 * @param map
	 */
	public void insertDmFileDetail(Map<String, String> map) {
		insert("COMZ02DAO.insertDmFileDetail", map);
	}
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) {
		return (Map<String, String>) select("COMZ02DAO.selectDmFileDetailByPk", map);
	}
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMZ02DAO.selectDmFileDetailListByPk", map);
	}
	
	/**
	 * 
	 * @param FILE_MASTR_SN
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectDmFileDetailForDmDetailDelete(String FILE_MASTR_SN) {
		return (List<Map<String, String>>) list("COMZ02DAO.selectDmFileDetailForDmDetailDelete", FILE_MASTR_SN);
	}
	
	/**
	 * 
	 * @param FILE_MASTR_SN
	 * @return
	 */
	public int deleteDmFileDetailByDmFileMstrSn(String str) {
		return delete("COMZ02DAO.deleteDmFileDetailByDmFileMstrSn", str);
	}
	
	/**
	 * 파일상세 삭제
	 * @param str
	 * @return
	 */
	public int deleteDmFileDetailByDetailSn(String str) {
		return delete("COMZ02DAO.deleteDmFileDetailByDetailSn", str);
	}
	
	/**
	 * EDC_CR_TASK 의 TASK_NO 기준으로  WORD 파일 검색
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectEdcCrTaskForWord(Map<String, String> map) {
		return (Map<String, String>) select("COMZ02DAO.selectEdcCrTaskForWord", map);
	}
	
	/**
	 * CTMS_CO_CNTRCT_MANAGE 의 USER_ID 로 조회(계약 후 계약서 보기 위함)
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmCntrctManageForWord(Map<String, String> map) throws Exception {
		return (Map<String, String>) select("COMZ02DAO.selectCmCntrctManageForWord", map);
	}
	
	/**
	 * CM_RSRCHUSER 조회 (계약서 미리보기 위함)
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmRsrchuserForWord(Map<String, String> map) throws Exception {
		return (Map<String, String>) select("COMZ02DAO.selectCmRsrchuserForWord", map);
	}
	
}
