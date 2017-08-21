package pantheon.sdb.f04.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * SOP 등록 관리 인터페이스 클래스
 * @author 이원민
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17   이원민                    최초 생성
 *  
 */
public interface SDBF04Service {
	
	/**
	 * SOP 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertSopInfo(Map<String, String> param) throws Exception;
	
	public String insertSopFile(HttpServletRequest req) throws Exception;
	
	/**
	 * SOP 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateSopInfo(Map<String, String> param) throws Exception;
	
	public void updateSopFile(HttpServletRequest req, String fileSn) throws Exception;
	
	/**
	 * SOP 정보 조회 
	 * @param param
	 * @return ArrayList<Map<String, String>
	 * @throws Exception
	 */
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 등록된 첨부파일 개별 삭제 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void deleteFileInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 등록된 SOP 정보 삭제 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void deleteSopInfo(Map<String, String> param) throws Exception;
}
