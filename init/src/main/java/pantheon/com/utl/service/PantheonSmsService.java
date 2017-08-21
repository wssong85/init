package pantheon.com.utl.service;

import java.util.Map;

/**
 * SMS 관리 인터페이스
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
public interface PantheonSmsService {
	public boolean insertSmsService(Map<String, String> map, String smsTo, String smsSubject) throws Exception;
}
