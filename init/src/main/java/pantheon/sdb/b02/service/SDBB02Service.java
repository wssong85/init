package pantheon.sdb.b02.service;

import java.util.List;
import java.util.Map;


public interface SDBB02Service {
	/**
	 * 의약품 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	

	public Map<String, Object> selectOrganInfo(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectOrganList(Map<String, String> map) throws Exception;

	public Map<String, Object> selectDelnglnInfo(Map<String, Object> param);

	public List<Map<String, Object>> selectCntrctInfo(Map<String, String> map) throws Exception;

	public List<Map<String, Object>> selectChagerListInfo(Map<String, String> map) throws Exception;

	public Map<String, Object> selectChagerInfo(Map<String, Object> param);

	//public boolean insertOrgan(Map<String, String> param, String txtmode) throws Exception;
	/**
	 * 거래선, 담당자 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */	
	public String insertOrgan(Map<String, String> param) throws Exception;
	
		
	/**
	 * 취급의약품 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */

	public void insertProduct(Map<String, String> param) throws Exception;

	public void insertProductDel(Map<String, String> param) throws Exception;

	

	public List<Map<String, Object>> selectProductInfo(Map<String, String> map) throws Exception;

	public boolean delOrgan(Map<String, String> param, String txtmode) throws Exception;

	public void delCtFile(List<Map<String, Object>> list) throws Exception;

	public List<Map<String, Object>> selectProductList(Map<String, String> map) throws Exception;

	public List<Map<String, Object>> selectProductListReg(Map<String, String> map) throws Exception;

	public String selectProductListCount(Map<String, String> map) throws Exception;



	
}
