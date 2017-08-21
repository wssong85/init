package pantheon.edc.k05.service;

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
public interface EDCK05Service {

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
	public List<Map<String, Object>> selectIRBBasicEndInfoList(Map<String, String> map) throws Exception;

	/**
	 * IRB info 기초정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertIRBBasicInfo(List<Map<String, Object>> list) throws Exception;


}
