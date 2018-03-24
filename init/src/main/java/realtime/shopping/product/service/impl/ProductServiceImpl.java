package realtime.shopping.product.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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
		//조회수증가
		productMapper.updateSellReadCnt(map);
		
		return productMapper.selectSellProduct(map);
	}

	@Override
	public int insertSellProduct(Map<String, Object> map) throws Exception {
		
		int resultCnt = 0;
		
		/******************************
		 * 판매품목 등록
		 ******************************/
		//판매품목 시퀀스생성
		Map<String, Object> productResult = productMapper.getMaxProductSeq(map);
		if (productResult == null) {
			map.put("productSeq", 1);  //일련번호
		} else {
			map.put("productSeq", productResult.get("productSeq"));  //일련번호
		}
		
		//상품 등록
		resultCnt = productMapper.insertSellProduct(map);
		
		/******************************
		 * 해시태그 판매품목 등록
		 ******************************/
		List<String> hashtagList = new ArrayList<String>();
		hashtagList = Arrays.asList(map.get("hashtag").toString().split(","));
		
		int hashtagSeq = 0;
		Map<String, Object> hashtagParam = new HashMap<String, Object>();
		
		for (int i=1; i<hashtagList.size(); i++) {
			
			//해시태그 시퀀스생성
			Map<String, Object> hashtagResult = productMapper.getMaxHashtagSeq(map);
			if (hashtagResult == null) {
				hashtagSeq = 1;  //일련번호
			} else {
				hashtagSeq = Integer.parseInt(hashtagResult.get("hashtagSeq").toString());  //일련번호
			}
			
			hashtagParam.put("productSeq", map.get("productSeq"));
			hashtagParam.put("hashtagSeq", hashtagSeq);
			hashtagParam.put("hashtag"   , hashtagList.get(i));
			hashtagList.get(i);
			
			//해시태그 등록
			productMapper.insertHashtag(hashtagParam);
			
			//해시태그상품 등록
			productMapper.insertHashtagProduct(hashtagParam);
		}
		
		return resultCnt;
	}

	@Override
	public int updateSellProduct(Map<String, Object> map) throws Exception {
		
		int resultCnt = 0;
		
		/******************************
		 * 판매품목 수정
		 ******************************/
		//상품 수정
		resultCnt = productMapper.updateSellProduct(map);
		
		/******************************
		 * 해시태그 판매품목 삭제 후 등록
		 ******************************/
		//해시태그 삭제
		productMapper.deleteHashtag(map);
		
		//해시태그상품 삭제
		productMapper.deleteHashtagProduct(map);
		
		List<String> hashtagList = new ArrayList<String>();
		hashtagList = Arrays.asList(map.get("hashtag").toString().split(","));
		
		int hashtagSeq = 1;
		Map<String, Object> hashtagParam = new HashMap<String, Object>();
		
		for (int i=1; i<hashtagList.size(); i++) {
			
			hashtagParam.put("productSeq", map.get("productSeq"));
			hashtagParam.put("hashtagSeq", hashtagSeq);
			hashtagParam.put("hashtag"   , hashtagList.get(i));
			hashtagList.get(i);
			
			//해시태그 등록
			productMapper.insertHashtag(hashtagParam);
			
			//해시태그상품 등록
			productMapper.insertHashtagProduct(hashtagParam);
		}
		
		return resultCnt;
	}

}
