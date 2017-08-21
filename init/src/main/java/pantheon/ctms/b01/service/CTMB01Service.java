package pantheon.ctms.b01.service;

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
public interface CTMB01Service {
	/**
	 * Paper 계약 계약정보 조회
	 * @param map
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectClinicalAssignmentList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectclinicalbyGrid(Map<String, String> map) throws Exception;
	/*public void insertAnnualReport(List<Map<String, Object>> list) throws Exception;*/

	
	
	
}
