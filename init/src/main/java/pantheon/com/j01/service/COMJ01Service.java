package pantheon.com.j01.service;

import java.util.List;
import java.util.Map;

/**
 * ATRAIL 처리하는 비지니스 인터페이스 클래스
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
public interface COMJ01Service {
	
	/**
	 * ATRAIL 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmDtaAtrailListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * ATRAIL 목록 카운팅
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCmDtaAtrailListCountByPk(Map<String, String> map) throws Exception;
}
