package pantheon.edc.k03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * Data import 목록을 위한 데이터 접근 클래스
 * @author 오동근
 * @since 2016.02.29
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.29  오동근          최초 생성
 *  
 */
@Repository("EDCK03DAO")
public class EDCK03DAO extends EgovComAbstractDAO {
	
	/**
	 * Data import 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLabList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCK03DAO.selectLabList", param);
	}
	
	/**
	 * Data import 목록 Count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectLabListCount(Map<String, Object> param) throws Exception {
		return (String) select("EDCK03DAO.selectLabListCount", param);
	}
	
	/**
	 * Data import 상세
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLab(Map<String, Object> param)	throws Exception {
		return (Map<String, Object>) select("EDCK03DAO.selectLab", param);
	}

	/**
	 * Data import 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertLab(Map<String, Object> param) throws Exception {
		insert("EDCK03DAO.insertLab", param);
	}

	/**
	 * Data import 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateLab(Map<String, Object> param) throws Exception {
		update("EDCK03DAO.updateLab", param);
	}
	
	/**
	 * Lab 정상범위 업로드 전 EDC_CF_LAB 테이블에 같은 기관의 같은 실험실 명이 있는지 건수 COUNT
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectLabCount(Map<String, Object> param) throws Exception{
		return (int) select("EDCK03DAO.selectLabCount", param);
	}
	
	/**
	 * 한 기관의 새로운 실험실 명이면 insert
	 * @param param
	 * @throws Exception
	 */
	public void insertCfLab(Map<String, Object>param) throws Exception{
		insert("EDCK03DAO.insertCfLab", param);
	}

}
