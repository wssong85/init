package pantheon.com.utl.service;


/**
 * 암호화 처리하는 비지니스 인터페이스 클래스
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
public interface DamoService {
	
	/**
	 * damo enc (utf-8)
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public String scpEncStr(String str) throws Exception;
	
	/**
	 * damo dec (utf-8)
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public String scpDecStr(String str) throws Exception;
	
	
	public String scpSha512Str(String str) throws Exception;
}
