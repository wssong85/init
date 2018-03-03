package realtime.shopping.product.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.shopping.product.mapper.ProductMapper;
import realtime.shopping.product.service.ProductService;

@Service("ProductService")
public class ProductServiceImpl implements ProductService {

	/**
	 * 상품목록Mapper
	 */
	@Resource(name = "ProductMapper")
	private ProductMapper productMapper;
	
	/**
	 * 상품목록일련번호
	 */
//	@Resource(name = "TB_INTEREST_SEQ")
//	private EgovIdGnrService tbProductSeq;

	@Override
	public List<Map<String, Object>> selectSellProductList(Map<String, Object> map) throws Exception {
		return productMapper.selectSellProductList(map);
	}

	@Override
	public Map<String, Object> selectSellProduct(Map<String, Object> map) throws Exception {
		return productMapper.selectSellProduct(map);
	}

	@Override
	public int insertSellProduct(Map<String, Object> map) throws Exception {
		
		//시퀀스생성
		Map<String, Object> result = productMapper.getMaxProductSeq(map);
		
		if (result == null) {
			map.put("productSeq", 1);  //일련번호
		} else {
			map.put("productSeq", result.get("productSeq"));  //일련번호
		}
		
		return productMapper.insertSellProduct(map);
	}

}
