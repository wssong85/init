package pantheon.iwrs.d03.service;

import java.util.List;
import java.util.Map;

/**
 * IP Error Log 처리하는 비지니스 인터페이스 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
public interface IWRD03Service {
	
	/**
	 * IP Error Log 현황 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectErrorLog(Map<String, String> param) throws Exception;
}
