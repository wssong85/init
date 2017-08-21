package pantheon.ctms.b03.service;

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
 *  2016.03.23  김복민          최초 생성
 *  
 */
public interface CTMB03Service {
	/**
	 * NIS 과제번호 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectNISTask_NoList(Map<String, String> map) throws Exception;
	/**
	 * NIS 과제 정보 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectAssignmentbyNisGrid(Map<String, String> map) throws Exception;

	/**
	 * NIS 과제 입력
	 * @param map
	 * @throws Exception
	 */	
	public void insertAssignmentbyNisGrid(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * NIS 과제정보 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectNisStatusGrid(Map<String, String> map) throws Exception;
	
}
