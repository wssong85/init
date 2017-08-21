package pantheon.com.a01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 메뉴관리를 위한 데이터 접근 클래스
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
@Repository("COMA01DAO")
public class COMA01DAO extends EgovComAbstractDAO{
	
	/**
	 * 메뉴 입력
	 * @param map
	 */
	public void insertCmMenu(Map<String, Object> map) {
		insert("COMA01DAO.insertCmMenu", map);
	}
	
	/**
	 * 메뉴아이디로 메뉴삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteCmMenuForMenuId(Map<String, Object> map) {
		return delete("COMA01DAO.deleteCmMenuForMenuId", map);
	}
	
	/**
	 * 메뉴아이디로 메뉴수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmMenuForMenuId(Map<String, Object> map) {
		return update("COMA01DAO.updateCmMenuForMenuId", map);
	}
	
	/**
	 * 상위메뉴아이디로 메뉴삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteCmMenuForUpperMenuId(Map<String, Object> map) {
		return delete("COMA01DAO.deleteCmMenuForUpperMenuId", map);
	}
	
	/**
	 * 상위메뉴아이디로 메뉴수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmMenuForUpperMenuId(Map<String, Object> map) {
		return update("COMA01DAO.updateCmMenuForUpperMenuId", map); 
	}
	
	/**
	 * 상위메뉴아이디로 메뉴목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmMenuListByUpperMenuId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMA01DAO.selectCmMenuListByUpperMenuId", map);
	}
	
	/**
	 * 상위메뉴목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmMenuListForUpperMenuId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMA01DAO.selectCmMenuListForUpperMenuId", map);
	}
	
	/**
	 * 메뉴 종복체크
	 * @param map
	 * @return
	 */
	public int selectCmMenuForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMA01DAO.selectCmMenuForDupCheck", map); 
	}
	
	/**
	 * USE_YN 을 'N' 으로 수정
	 * @param map
	 * @return
	 */
	public int updateCmMenuForDelete(Map<String, Object> map) {
		return (Integer) delete("COMA01DAO.updateCmMenuForDelete", map);
	}
	
	/**
	 * 메뉴삭제하기전 조회
	 * @param map
	 * @return
	 */
	public int selectCmMenuForDelete(Map<String, Object> map) {
		return (Integer) select("COMA01DAO.selectCmMenuForDelete", map);
	}
	
	/**
	 * 수정하기전 홈화면인지 확인한다.
	 * @param map
	 * @return
	 */
	public int selectCmProgrmForDulCheckByEssntlAt(Map<String, Object> map) {
		return (Integer) select("COMA01DAO.selectCmProgrmForDulCheckByEssntlAt", map);
	}
}
