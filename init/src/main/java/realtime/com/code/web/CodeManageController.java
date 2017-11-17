package realtime.com.code.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import realtime.com.code.service.CodeManageService;

/**
 * 
 * @author songwonseock
 *
 */
@Controller
public class CodeManageController {

	@Resource(name = "CodeManageService")
	private CodeManageService codeManageService;
	
	
	/**
	 * 공통코드화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/com/code/codeManage.do")
	public String codeManage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/code/codeManage";
	}

	
	/**
	 * 그룹코드 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/code/selectTbGroupCodeList.do")
	@ResponseBody 
	public Map<String , Object> selectTbGroupCodeList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = codeManageService.selectTbGroupCodeList(null);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 그룹코드 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/code/multiTbGroupCode.do")
	public @ResponseBody Map<String , Object> multiTbGroupCode(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			codeManageService.multiTbGroupCode(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
	/**
	 * 상세코드 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/code/selectTbDetailCodeList.do")
	public @ResponseBody Map<String , Object> selectTbDetailCodeList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = codeManageService.selectTbDetailCodeList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 상세코드 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/code/multiTbDetailCode.do")
	public @ResponseBody Map<String , Object> multiTbDetailCode(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			codeManageService.multiTbDetailCode(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
}
