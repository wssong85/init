package pantheon.com.utl.service;

import java.util.Map;

/**
 * 메일발송 처리하는 비지니스 인터페이스 클래스
 * @author 송원석
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  송원석          최초 생성
 *  
 */
public interface PantheonMailService {
	
	/**
	 * 메일발송
	 * @param map
	 * @param emailTo
	 * @param emailUserName
	 * @param emailSubject
	 * @return
	 * @throws Exception
	 */
	public boolean sendMail(Map<String, String> map, String emailTo, String emailUserName, String emailSubject) throws Exception;
}
