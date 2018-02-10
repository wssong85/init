package realtime.shopping.product.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ProductMapper")
public interface ProductMapper {
	
	/**
	 * 판매품목목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectSellProductList(Map<String, Object> map) throws Exception;
	
	/**
	 * 판매품목상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectSellProduct(Map<String, Object> map) throws Exception;
	
	/**
	 * 판매품목 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	int insertSellProduct(Map<String, Object> map) throws Exception;

}
