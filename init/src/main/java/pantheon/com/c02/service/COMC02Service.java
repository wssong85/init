package pantheon.com.c02.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * Medical dictionary 처리하는 비지니스 인터페이스 클래스
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
public interface COMC02Service {
	
	/**
	 * ATC 엑셀 조회
	 * @param list
	 * @throws Exception
	 */
	public void insertEdcCrAtcByExcelList(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * ATC 입력
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAtcListByExcel(HttpServletRequest request) throws Exception;
	
	/**
	 * ATC 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrAtcByDicaryVer(Map<String, String> map) throws Exception;
	
	/**
	 * WHOART 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertEdcCrWhoartByExcelList(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * WHOART 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrWhoartByDicaryVer(Map<String, String> map) throws Exception;

	/**
	 * WHOART 엑셀 조회
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectWhoartListByExcel(HttpServletRequest request) throws Exception;

	/**
	 * MedDRA 엑셀 조회
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMeddraListByExcel(HttpServletRequest request) throws Exception;

	/**
	 * MedDRA 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertEdcCrMeddraByExcelList(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * MedDRA 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrMeddraByPk(Map<String, String> map) throws Exception;
	
	/**
	 * KIMS 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrKimsByPk(Map<String, String> map) throws Exception;
	
	/**
	 * KIMS 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertEdcCrKimsByExcelList(List<Map<String, Object>> map) throws Exception;

	/**
	 * KIMS 엑셀 조회
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectKimsListByExcel(HttpServletRequest request) throws Exception;
	
	/**
	 * kims count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrKimsCountByPk(Map<String, String> map) throws Exception;
	
	/**
	 * meddra count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrMeddraCountByPk(Map<String, String> map) throws Exception;
	
	/**
	 * whoart count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrWhoartCountByDicaryVer(Map<String, String> map) throws Exception;
	
	/**
	 * atc count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrAtcCountByDicaryVer(Map<String, String> map) throws Exception;
}
