package pantheon.com.f05.service;

import java.util.List;
import java.util.Map;

/**
 * 프로그램 이력 처리하는 비지니스 인터페이스 클래스
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
public interface COMF05Service {
	
	/**
	 * 프로그램 이력 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmProgrmConectListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 프로그램 이력 카운팅
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCmProgrmConectListCountByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 프로그램 이력 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmProgrmConect(Map<String, String> map) throws Exception;
}
