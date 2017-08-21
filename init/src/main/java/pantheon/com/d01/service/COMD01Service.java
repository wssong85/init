package pantheon.com.d01.service;

import java.util.List;
import java.util.Map;


/**
 * 공통코드 처리하는 비지니스 인터페이스 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
public interface COMD01Service {
	
	/**
	 * 분류코드 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmClCodeListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 분류코드 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmClCodeByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 분류코드 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertCmClCode(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 공통코드 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmCmmnCodeListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 공통코드 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmCmmnCodeByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 공통코드 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertCmCmmnCode(List<Map<String, Object>> list) throws Exception;
}
