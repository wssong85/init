package pantheon.sdb.b03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBB03DAO")
public class SDBB03DAO extends EgovComAbstractDAO{
	/**
	 * 의약품 수정
	 * @param map
	 * @return
	 */
	public int updateOrganList(Map<String, String> param) {
		return update("SDBB03DAO.updateOrganList", param);
	}
	
	/**
	 * 의약품 저장 
	 * @param map
	 */
	public void insertOrganList(Map<String, String> param) {
		// TODO Auto-generated method stub
		System.out.println("=============dao");
		insert("SDBB03DAO.insertOrganList", param);
	}
	
	/**
	 * 의약품 pk로 삭제
	 * @param map
	 * @return
	 */
	public int deleteOrganList(Map<String, String> map) {
		return delete("SDBB03DAO.deleteOrganListByPk", map);
	}
	
	
	/**
	 * 기관 삭세조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOrganInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		
		return (Map<String, Object>) select("SDBB03DAO.selectOrganInfo", param);	
		
	}


	/**
	 * 기관 리스트조회
	 * @param map
	 * @return List
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrganList(Map<String, String> map) throws Exception {
		System.out.println("@@@DAO sdb!!!!!");
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("SDBB03DAO.selectOrganList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrganListPop(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("SDBB03DAO.selectOrganListPop", map);
	}
	
}
