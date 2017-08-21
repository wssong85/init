package pantheon.edc.k01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EDCK01DAO")
public class EDCK01DAO extends EgovComAbstractDAO {

	/**
	 * 과제 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectStudyList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck01DAO.selectStudyList", map);
	}

	/**
	 * 과제 목록 카운트 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String selectStudyListCount(Map<String, Object> map) throws Exception {
		return (String) select("edck01DAO.selectStudyListCount", map);
	}

	/**
	 * 과제정보 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBaseInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck01DAO.selectBaseInfo", map);
	}

	/**
	 * 중복확인
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCheckTaskNo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("edck01DAO.selectCheckTaskNo", map);
	}

	/**
	 * selectTaskSn
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Object selectTaskSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck01DAO.selectTaskSn", map);
	}

	/**
	 * selectCDISCSn
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Object selectCDISCSn() throws Exception {
		return (Object) select("edck01DAO.selectCDISCSn", null);
	}

	/**
	 * 과제정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertBaseInfo(Map<String, Object> map) throws Exception {
		insert("edck01DAO.insertBaseInfo", map);
	}

	/**
	 * 과제정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateBaseInfo(Map<String, Object> map) throws Exception {
		return update("edck01DAO.updateBaseInfo", map);
	}

	/**
	 * 파일 master 상태 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateFileMasterUse(Map<String, Object> map) throws Exception {
		return update("edck01DAO.updateFileMasterUse", map);
	}

	/**
	 * 파일 detail 상태 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateFileDetailUse(Map<String, Object> map) throws Exception {
		return update("edck01DAO.updateFileDetailUse", map);
	}

	/**
	 * 제품 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("edck01DAO.selectProductList", map);
	}

	/**
	 * ProductSn 조회
	 * 
	 * @param map
	 * @return
	 */
	public Object selectProductSn(Map<String, Object> map) throws Exception {
		return (Object) select("edck01DAO.selectProductSn", map);
	}

	/**
	 * 제품정보 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertProduct(Map<String, Object> map) throws Exception {
		insert("edck01DAO.insertProduct", map);
	}

	/**
	 * 제품정보 수정
	 * 
	 * @param map
	 * @return
	 */
	public int updateProduct(Map<String, Object> map) throws Exception {
		return update("edck01DAO.updateProduct", map);
	}
}
