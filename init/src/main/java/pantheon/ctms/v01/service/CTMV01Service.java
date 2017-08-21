package pantheon.ctms.v01.service;

import java.util.List;
import java.util.Map;



/**
 * Milestone 비지니스 인터페이스 클래스
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
public interface CTMV01Service {

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) throws Exception;

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBCttpcList(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBDlbrtctList(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBRsrcctList(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBDlbrtList(Map<String, String> map) throws Exception;

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBSaeList(Map<String, String> map) throws Exception;

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIRBInfoList(Map<String, String> map) throws Exception;
	

	/**
	 * IRB info 기초정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBBasicInfo(List<Map<String, Object>> list) throws Exception;

	/**
	 * IRB 연락처 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBCttpcInfo(List<Map<String, Object>> list) throws Exception;

	/**
	 * IRB 심의비 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBDlbrtctInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * IRB 연구비 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBRsrcctInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * IRB 심의 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBDlbrtInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * e-IRB 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBInfoInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * IRB SAE 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBSaeInfo(List<Map<String, Object>> list) throws Exception;
	/*-------------------------------------------------------------------------------------------------------------*/

	
}
