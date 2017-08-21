package pantheon.com.z09.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 결재선 관리를 위한 데이터 접근 클래스
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
@Repository("COMZ09DAO")
public class COMZ09DAO extends EgovComAbstractDAO{
	
	/**
	 * 결재선 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSanClineListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMZ09DAO.selectCmSanClineListByPk", map);
	}
	
	/**
	 * 결재선 상세 조회
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSanClineDetailListByPk(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("COMZ09DAO.selectCmSanClineDetailListByPk", map);
	}
	
	/**
	 * 내부유저 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmJobUserListForAll(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMZ09DAO.selectCmJobUserListForAll", map);
	}
	
	/**
	 * 결재선 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmSanClineListForComboBox(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMZ09DAO.selectCmSanClineListForComboBox", map);
	}
	
	/**
	 * 결재선 입력
	 * @param map
	 */
	public void insertCmSanClineByPk(Map<String, Object> map) {
		insert("COMZ09DAO.insertCmSanClineByPk", map);
	}
	
	/**
	 * 결재선 수정
	 * @param map
	 * @return
	 */
	public int updateCmSanClineByPk(Map<String, Object> map) {
		return update("COMZ09DAO.updateCmSanClineByPk", map);
	}
	
	/**
	 * 결재선 상세 입력
	 * @param map
	 */
	public void insertCmSanClineDetailByPk(Map<String, Object> map) {
		insert("COMZ09DAO.insertCmSanClineDetailByPk", map);
	}
	
	/**
	 * 결재선 상세 수정
	 * @param map
	 * @return
	 */
	public int updateCmSanClineDetailByPk(Map<String, Object> map) {
		return update("COMZ09DAO.updateCmSanClineDetailByPk", map);
	}
	
	/**
	 * 결재처리 입력
	 * @param map
	 */
	public void insertCmSanctnProcessByCmSanClineDetailInfo(Map<String, Object> map) {
		insert("COMZ09DAO.insertCmSanctnProcessByCmSanClineDetailInfo", map);
	}
	
	/**
	 * 결재처리 입력
	 * @param map
	 */
	public void insertCmSanctnRequstByCmSanClineDetailInfo(Map<String, Object> map) {
		insert("COMZ09DAO.insertCmSanctnRequstByCmSanClineDetailInfo", map);
	}

	/**
	 * 결재처리 조회
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSanctnProcessListByPk(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("COMZ09DAO.selectCmSanctnProcessListByPk", map);
	}
	
	/**
	 * 결재처리 수정
	 * @param map
	 * @return
	 */
	public int updateCmSanctnProcessByPk(Map<String, String> map) {
		return update("COMZ09DAO.updateCmSanctnProcessByPk", map);
	}

	/**
	 * 결재선 수정
	 * @param map
	 * @return
	 */
	public int updateCmSanCtnRequstByPk(Map<String, String> map) {
		return update("COMZ09DAO.updateCmSanCtnRequstByPk", map);
	}
	
	/**
	 * 결재처리 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSanctnProcessListForUpdate(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMZ09DAO.selectCmSanctnProcessListForUpdate", map);
	}
	
	/**
	 * 결재처리 조회
	 * @param map
	 * @return
	 */
	public int selectCmSanctnProcessCountByPk(Map<String, String> map) {
		return (Integer) select("COMZ09DAO.selectCmSanctnProcessCountByPk", map);
	}
	
	/**
	 * 결제처리 조회
	 * @param map
	 * @return
	 */
	public int selectCmSanctnProcessCountByPk2(Map<String, String> map) {
		return (Integer) select("COMZ09DAO.selectCmSanctnProcessCountByPk2", map);
	}
	
	/**
	 * 결재처리 조회
	 * @param map
	 * @return
	 */
	public int selectCmSanctnProcessCountByPk3(Map<String, String> map) {
		return (Integer) select("COMZ09DAO.selectCmSanctnProcessCountByPk3", map);
	}
	
	/**
	 * 결재처리 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmSanctnRequstCountByPk(Map<String, String> map) {
		return (Integer) select("COMZ09DAO.selectCmSanctnRequstCountByPk", map);
	}
	
	/**
	 * 결재선 상세 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmSanclineDetailListForInsert(Map<String, Object> map) {
		return (Integer) delete("COMZ09DAO.deleteCmSanclineDetailListForInsert", map);
	}
	
	/**
	 * 결제선 상세 삭제 전 이력 남기기 위해 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSanclineDetailListForInsert(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("COMZ09DAO.selectCmSanclineDetailListForInsert", map);
	}
}
