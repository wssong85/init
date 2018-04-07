package realtime.shopping.product.service;

import java.util.List;
import java.util.Map;

public interface ProductService {
	
	/**
	 * 판매품목목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> apiSelectSellProductList(Map<String, Object> map) throws Exception;
	
	/**
	 * 판매품목상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> apiSelectSellProduct(Map<String, Object> map) throws Exception;
	
	/**
	 * 판매품목 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int apiInsertSellProduct(Map<String, Object> map) throws Exception;

	/**
	 * 판매품목 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int apiUpdateSellProduct(Map<String, Object> map) throws Exception;

}
