package pantheon.sdb.b02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBB02DAO")
public class SDBB02DAO extends EgovComAbstractDAO{
	/**
	 * 의약품 수정
	 * @param map 
	 * @return
	 */
	public int updateOrgan(Map<String, String> param) {
		return update("SDBB02DAO.updateOrgan", param);
	}
	
	/**
	 * 의약품 저장 
	 * @param map
	 */
	public void insertOrgan(Map<String, String> param) {
		// TODO Auto-generated method stub
		System.out.println("======dao");
		System.out.println(param);
		insert("SDBB02DAO.insertOrgan", param);
	}
	
	/**
	 * 의약품 pk로 삭제
	 * @param map
	 * @return
	 */
	public void deleteOrgan(Map<String, String> map) {
		update("SDBB02DAO.deleteOrganByPk", map);
	}
	
	
	
	/**
	 * 기관 삭세조회
	 * @param map
	 * @return map
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOrganInfo(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		param.put("LOCALE", Util.getStrLocale());
		return (Map<String, Object>) select("SDBB02DAO.selectOrganInfo", param);	
		
	}


	/**
	 * 기관 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrganList(Map<String, String> map) {
		System.out.println("@@@DAO sdb!!!!!");
		return (List<Map<String, Object>>) list("SDBB02DAO.selectOrganInfo", map);
	}
	
	
	/**
	 * 기관 삭세조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDelnglnInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) select("SDBB02DAO.selectDelnglnInfo", param);
	}
	
	/**
	 * 기관 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCntrctInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBB02DAO.selectCntrctInfo", map);
	}
	
	/**
	 * 담당자 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectChagerListInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBB02DAO.selectChagerListInfo", map);
	}
	
	/**
	 * 담당자 상세조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectChagerInfo(Map<String, Object> param) {
		return (Map<String, Object>) select("SDBB02DAO.selectChagerInfo", param);
	}

	public void insertCharger(Map<String, String> iMap) {
		insert("SDBB02DAO.insertCharger", iMap);
	}

	public int updateCharger(Map<String, String> iMap) {
		return update("SDBB02DAO.updateCharger", iMap);
	}

	public int deleteCharger(Map<String, String> iMap) {
		return delete("SDBB02DAO.deleteCharger", iMap);
	}

	public void insertProduct(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBB02DAO.insertProduct", param);
	}

	public void deleteProduct(Map<String, String> param) {
		// TODO Auto-generated method stub
		update("SDBB02DAO.updateProduct", param);
	}


	/**
	 * 취급의약품 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBB02DAO.selectProductInfo", map);
	}

	public int  delOrgan(Map<String, String> param) {
		// TODO Auto-generated method stub
		return update("SDBB02DAO.delOrgan", param);
	}



	public int delCtFile(Map<String, Object> iMap) {
		// TODO Auto-generated method stub		
		return update("SDBB02DAO.delCtFile", iMap);
	}
	
	/**
	 * 등록된 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBB02DAO.selectProductList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductListReg(Map<String, String> map) {
		// TODO Auto-generated method stub
		System.out.println(map);
		return (List<Map<String, Object>>)list("SDBB02DAO.selectProductListReg", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectProductListCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return (String) select("SDBB02DAO.selectProductListCount", map);
	}

}
