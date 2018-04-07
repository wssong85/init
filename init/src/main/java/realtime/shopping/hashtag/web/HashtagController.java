package realtime.shopping.hashtag.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.shopping.hashtag.service.HashtagService;

@Controller
public class HashtagController {
	
	@Resource(name = "HashtagService")
	private HashtagService hashtagService;
	
	/**
	 * 관심목록 & 해쉬태그 조회
	 * 
	 */
	@RequestMapping(value = "/shopping/hastag/apiSelectTbIfHashtagInterest.do")
	@ResponseBody 
	public Map<String , Object> apiSelectTbIfHashtagInterest(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			Map<String, Object> interestMap = hashtagService.apiSelectTbIfHashtagInterest(map);
			
			result.put("success", true);
			result.put("interest", interestMap);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 관심목록 & 해쉬태그 등록
	 * 
	 */
	@RequestMapping(value = "/shopping/hastag/apiInsertTbIfHashtagInterest.do")
	@ResponseBody 
	public Map<String , Object> apiInsertTbIfHashtagInterest(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			hashtagService.apiInsertTbIfHashtagInterest(map);
			
			result.put("success", true);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 구매 목록 가져오기
	 * 추후 product 쪽으로 이동 해야 함
	 * 
	 */
	@RequestMapping(value = "/shopping/hastag/apiSelectBuyProduct.do")
	@ResponseBody 
	public Map<String , Object> apiSelectBuyProduct(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		map.put("userId", "admin");	  //TODO 추후세션변경
		
		System.out.println(map);
		
		try {
			
			List<Map<String, Object>> productMap = hashtagService.apiSelecBuyTbProductList(map);
			
			result.put("success", true);
			result.put("products", productMap);
			
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 네이버 리버스 지오코딩 API 호출
	 * 
	 */
	@RequestMapping(value = "/shopping/hastag/apiRequestReverseGeocoding.do")
	@ResponseBody 
	public Map<String , Object> apiRequestReverseGeocoding(@RequestParam Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			// 값은 반드시 있다고 가정함
			String resp = hashtagService.apiRequestReverseGeocoding((String) map.get("query"));
			
			result.put("success", true);
			result.put("result", resp);
			
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
}
