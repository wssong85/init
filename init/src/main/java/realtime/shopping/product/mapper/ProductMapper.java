package realtime.shopping.product.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ProductMapper")
public interface ProductMapper {
	
	/**
	 * 해시태그 시퀀스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> getMaxHashtagSeq(Map<String, Object> map) throws Exception;
	
	/**
	 * 판매품목 시퀀스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> getMaxProductSeq(Map<String, Object> map) throws Exception;
	
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
	
	/**
	 * 해시태그 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	int insertHashtag(Map<String, Object> map);

	/**
	 * 해시태그상품 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	int insertHashtagProduct(Map<String, Object> map);

	/**
	 * 조회수 증가
	 * @param map
	 * @return
	 * @throws Exception
	 */
	void updateSellReadCnt(Map<String, Object> map);

}
