package pantheon.iwrs.c02.service;

import java.util.List;
import java.util.Map;

/**
 * 배송요청 알림 처리하는 비지니스 인터페이스 클래스
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
public interface IWRC02Service {
	
	/**
	 * 배송 요청 알림 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectRequestInfo(Map<String, String> param) throws Exception;
	
	public void updateRequestInfo(Map<String, String> param) throws Exception;
}
