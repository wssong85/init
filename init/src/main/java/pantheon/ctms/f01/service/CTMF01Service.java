package pantheon.ctms.f01.service;

import java.util.List;
import java.util.Map;



/**
 * 계약관리 비지니스 인터페이스 클래스
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
public interface CTMF01Service {
	/**
	 * Paper 계약 계약정보 조회
	 * @param map
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectPaperContractList(Map<String, String> map) throws Exception;
	/**
	 * Paper 계약 계약정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertPaperContractByCNT(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 과제별 롤 저장전 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteTaskUserRoleInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 계약서 POPUP조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectContractPopUpList(Map<String, String> map) throws Exception;
	
	/**
	 * 계약서 IRB공통코드 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeListByIRB_AT(Map<String, String> map) throws Exception;
	
	/**
	 * 계약서 상태 공통코드 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(Map<String, String> map) throws Exception;
	
	/**
	 * 중복체크 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchUserOverlap(Map<String, String> map) throws Exception;
	/*-------------------------------------------------------------------------------------------------------------*/
	/**
	 * 전체 계약 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTotalContractList(Map<String, String> map) throws Exception;
	
	/**
	 * 전자계약 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectElectContractList(Map<String, String> map) throws Exception;
	
	/**
	 * 전자계약 상태 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateElectContractStatus(List<Map<String, Object>> list) throws Exception;
	
}
