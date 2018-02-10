package realtime.shopping.hashtag.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public Map<String , Object> selectTbIfHashtagInterest(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			Map<String, Object> interestMap = hashtagService.selectTbIfHashtagInterest(map);
			
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
	public Map<String , Object> insertTbIfHashtagInterest(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			hashtagService.insertTbIfHashtagInterest(map);
			
			result.put("success", true);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 테스트
	 * 
	 */
	@RequestMapping(value = "/shopping/hastag/apitest.do")
	@ResponseBody 
	public Map<String , Object> selectBuyList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		try {
			
			List<Map<String, Object>> productMap = hashtagService.selectTbProduct(map);
			
			result.put("success", true);
			result.put("products", productMap);
			
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
}
