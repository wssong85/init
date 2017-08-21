package pantheon.sdb.b01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBB01DAO")
public class SDBB01DAO  extends EgovComAbstractDAO{
	
	/**
	 * 의약품 리스트조회
	 * @param map
	 * @return List
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList(Map<String, String> map) {
		System.out.println("@@@DAO sdb!!!!!");
		return (List<Map<String, Object>>) list("SDBB01DAO.selectProductList", map);
	}
	
	/**
	 * 의약품 수정
	 * @param map
	 * @return
	 */
	public int updateProductList(Map<String, String> param) {
		return update("SDBB01DAO.updateProductList", param);
	}
	
	/**
	 * 의약품 저장 
	 * @param map
	 */
	public void insertProductList(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBB01DAO.insertProductList", param);
	}
	
	/**
	 * 의약품 pk로 삭제
	 * @param map
	 * @return
	 */
	public int deleteProductList(Map<String, String> map) {
		return update("SDBB01DAO.deleteProductListByPk", map);
	}

	public int selectProductCount(Map<String, String> param) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * 의약품 삭세조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProductListInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		
		return (Map<String, Object>) select("SDBB01DAO.selectProductListInfo", param);	
		
	}	

	/**
	 * 의약품 보고기관수정
	 * @param map
	 * @return
	 */
	public int updateProductReport(Map<String, String> param) {
		return update("SDBB01DAO.updateProductReport", param);
	}
	
	/**
	 * 의약품 보고기관 저장 
	 * @param map
	 */
	public void insertProductReport(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBB01DAO.insertProductReport", param);
	}
	
	/**
	 * 의약품  보고기관 pk로 삭제
	 * @param mapy
	 * @return
	 */
	public void deleteProductReportByPk(Map<String, String> map) {
		delete("SDBB01DAO.deleteProductReportByPk", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductReportInfo(Map<String, Object> param) {
		System.out.println("@@@DAO selectProductReportInfo!!!!!");
		return (List<Map<String, Object>>) list("SDBB01DAO.selectProductReportInfo", param);
	}

	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLabelList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		System.out.println("@@@DAO sdb!!!!!");
		return (List<Map<String, Object>>) list("SDBB01DAO.selectLabelList", map);
	}


	/**
	 * 
	 * @param map
	 */
	public void insertDmFileMstr(Map<String, String> map) {
		insert("SDBB01DAO.insertDmFileMastr", map);
	}
	
	/**
	 * 
	 * @param map
	 */
	public void insertDmFileDetail(Map<String, String> map) {
		insert("SDBB01DAO.insertDmFileDetail", map);
	}


	
	/**
	 * 의약품 보고기관수정
	 * @param map
	 * @return
	 */
	public int updateLabelList(Map<String, String> param) {
		return update("SDBB01DAO.updateLabelList", param);
	}
	
	/**
	 * 의약품 보고기관 저장 
	 * @param map
	 */
	public void insertLabelList(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBB01DAO.insertLabelList", param);
	}
	
	/**
	 * 의약품  보고기관 pk로 삭제
	 * @param map
	 * @return
	 */
	public int deleteLabelListByPk(Map<String, String> map) {
		return delete("SDBB01DAO.deleteLabelListByPk", map);
	}

	/**
	 * Label 삭세조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLabelListInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		
		return (Map<String, Object>) select("SDBB01DAO.selectLabelListInfo", param);	
		
	}

	/**
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) {
		return (Map<String, String>) select("SDBB01DAO.selectDmFileDetailByPk", map);
	}
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("SDBB01DAO.selectDmFileDetailListByPk", map);
	}
	
	/**
	 * PSUR 리스트 조회
	 * @param map
	 * @return map
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPSURList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		System.out.println("@@@DAO sdb!!!!!");
		return (List<Map<String, Object>>) list("SDBB01DAO.selectPSURList", map);
	}
	

	/**
	 * PSUR 삭세조회
	 * @param map
	 * @return map
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPSURListInfo(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		// TODO Auto-generated method stub		
		return (Map<String, Object>) select("SDBB01DAO.selectPSURListInfo", param);		
	}
	
	/**
	 * PSUR 수정
	 * @param map
	 * @return
	 */
	public int updatePSURList(Map<String, String> param) {
		return update("SDBB01DAO.updatePSURList", param);
	}
	
	/**
	 * PSUR 저장 
	 * @param map
	 */
	public void insertPSURList(Map<String, String> param) {
		// TODO Auto-generated method stub
		insert("SDBB01DAO.insertPSURList", param);
	}
	
	/**
	 * PSUR pk로 삭제
	 * @param map
	 * @return
	 */
	public int deletePSURListByPk(Map<String, String> map) {
		return delete("SDBB01DAO.deletePSURListByPk", map);
	}
	
	/**
	 * Non-Clinical 리스트 조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNonCList(Map<String, String> map) {
		System.out.println("@@@DAO sdb!!!!!");
		return (List<Map<String, Object>>) list("SDBB01DAO.selectNonCList", map);
	}
	

	/**
	 * Non-Clinical 삭세조회
	 * @param map
	 * @return map
	 * */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNonCListInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub		
		return (Map<String, Object>) select("SDBB01DAO.selectNonCListInfo", param);		
	}
	
	/**
	 * Non-Clinical 수정
	 * @param map
	 * @return
	 */
	public int updateNonCList(Map<String, String> param) {
		return update("SDBB01DAO.updateNonCList", param);
	}

	/**
	 * 의약품  보고기관 삭제
	 * @param mapy
	 * @return
	 */
	
	public void deleteProductReport(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		delete("SDBB01DAO.deleteProductReport", iMap);
	}

	public List<Map<String, Object>> selectOrganCodeListByPk(
			Map<String, String> map_ori) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) list("SDBB01DAO.selectOrganCodeListByPk", map_ori);
	}
	
	
	
	
}
