package pantheon.com.c01.dao;

import java.util.List; 
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * CDISC 관리를 위한 데이터 접근 클래스
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
@Repository("COMC01DAO")
public class COMC01DAO extends EgovComAbstractDAO{
	
	/**
	 * CDISC RULE 입력
	 * @param map
	 */
	public void insertCdiscRuleByExcelSheet(Map<String, Object> map) {
		insert("COMC01DAO.insertCdiscRuleByExcelSheet", map);
	}
	
	/**
	 * CDISC DOMAIN 입력
	 * @param map
	 */
	public void insertCdiscDomnByExcelSheet(Map<String, Object> map) {
		insert("COMC01DAO.insertCdiscDomnByExcelSheet", map);
	}
	
	/**
	 * CDISC Variabl 입력
	 * @param map
	 */
	public void insertCdiscDomnVariablByExcelSheet(Map<String, Object> map) {
		insert("COMC01DAO.insertCdiscDomnVariablByExcelSheet", map);
	}
	
	/**
	 * CDISC Terminal 입력
	 * @param map
	 */
	public void insertCdiscClCodeByExcelSheet(Map<String, Object> map) {
		insert("COMC01DAO.insertCdiscClCodeByExcelSheet", map);
	}
	
	/**
	 * CDISC RULE 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscRuleList() {
		return (List<Map<String, Object>>) list("COMC01DAO.selectCdiscRuleList");
	}
	
	/**
	 * CDISC DOMAIN 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscDomnListByCdiscRuleSn(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC01DAO.selectCdiscDomnListByCdiscRuleSn", map);
	}
	
	/**
	 * CDISC DOMAIN count
	 * @param map
	 * @return
	 */
	public int selectCdiscDomnListCountByCdiscRuleSn(Map<String, String> map) {
		return (Integer) select("COMC01DAO.selectCdiscDomnListCountByCdiscRuleSn", map);
	}
	
	
	/**
	 * CDISC Vriabl 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscDomnVriablListByCdiscDomnSn(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC01DAO.selectCdiscDomnVriablListByCdiscDomnSn", map);
	}
	
	/**
	 * CDISC Vriabl count
	 * @param map
	 * @return
	 */
	public int selectCdiscDomnVriablListCountByCdiscDomnSn(Map<String, String> map) {
		return (Integer) select("COMC01DAO.selectCdiscDomnVriablListCountByCdiscDomnSn", map);
	}
	
	/**
	 * CDISC Terminal 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscClCodeByCdiscRuleSn(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC01DAO.selectCdiscClCodeByCdiscRuleSn", map);
	}
	
	/**
	 * CDISC Terminal count
	 * @param map
	 * @return
	 */
	public int selectCdiscClCodeCountByCdiscRuleSn(Map<String, String> map) {
		return (Integer) select("COMC01DAO.selectCdiscClCodeCountByCdiscRuleSn", map);
	}
	
}
