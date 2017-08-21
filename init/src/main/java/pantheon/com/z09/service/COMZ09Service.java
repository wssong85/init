package pantheon.com.z09.service;

import java.util.List; 
import java.util.Map;

/**
 * 결재선 처리하는 비지니스 인터페이스 클래스
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
public interface COMZ09Service {
	
	/**
	 * 결재선 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmSanClineByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 결재선 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmSanClineListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 결재선 상세 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmSanClineDetailByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 결재선 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmSanClineDetailListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 내부유저 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmJobUserListForAll(Map<String, String> map) throws Exception;
	
	/**
	 * 결재선 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmSanClineListForComboBox(Map<String, String> map) throws Exception;

	/**
	 * 결재선 입력
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public String insertSanClineForCreate(List<Map<String, Object>> list) throws Exception;

	/**
	 * 결재선 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertSanClineForUpdate(List<Map<String, Object>> list) throws Exception;

	/**
	 * 결재선 입력
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public String insertCmSanctnRequstByCmSanClineDetailInfo(List<Map<String, Object>> list) throws Exception;

	/**
	 * 결재처리 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmSanctnProcessListByPk(Map<String, String> map) throws Exception;

	/**
	 * 결재처리 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String updateCmSanctnProcessByPk(Map<String, String> map) throws Exception;
}
