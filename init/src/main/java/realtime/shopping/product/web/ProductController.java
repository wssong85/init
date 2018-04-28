package realtime.shopping.product.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.shopping.product.service.ProductService;

@Controller
public class ProductController {
	
	//품목서비스
	@Resource(name="ProductService")
	private ProductService productService;
	
	/**
	 * 판매품목의 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@RequestMapping("/shopping/product/apiSelectSellProductList.do")
	@ResponseBody
	public Map<String, Object> apiSelectSellProductList(@RequestBody Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//map.put("userId", "admin");	  //TODO 추후세션변경
			
			List<Map<String, Object>> productList = productService.apiSelectSellProductList(map);
			
			result.put("data", productList);       //판매품목목록
			result.put("success", true);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 판매품목의 상세정보를 조회한다.
	 * @param param
	 * @return
	 */
	@RequestMapping("/shopping/product/apiSelectSellProduct.do")
	@ResponseBody
	public Map<String, Object> apiSelectSellProduct(@RequestBody Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			result.put("success", true);
			result.put("data", productService.apiSelectSellProduct(map));  //판매품목상세
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 판매품목을 등록한다.
	 * @param param
	 * @return
	 */
	@RequestMapping("/shopping/product/apiInsertSellProduct.do")
	@ResponseBody 
	public Map<String, Object> apiInsertSellProduct(@RequestBody Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			map.put("userId", "admin");   //TODO 추후세션변경
			int resultCnt = productService.apiInsertSellProduct(map);
			if (resultCnt>0) {
				result.put("success", true);
			} else {
				
				result.put("success", false);
				result.put("message", "등록 실패, 관리자문의");
			}
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 판매품목을 수정한다.
	 * @param param
	 * @return
	 */
	@RequestMapping("/shopping/product/apiUpdateSellProduct.do")
	@ResponseBody 
	public Map<String, Object> apiUpdateSellProduct(@RequestBody Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			map.put("userId", "admin");   //TODO 추후세션변경
			int resultCnt = productService.apiUpdateSellProduct(map);
			if (resultCnt>0) {
				result.put("success", true);
			} else {
				
				result.put("success", false);
				result.put("message", "수정 실패, 관리자문의");
			}
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
}
