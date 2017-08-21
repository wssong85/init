package pantheon.ctms.b04.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.b04.service.CTMB04Service;
import pantheon.ctms.j02.service.DMCJ02Service;


@Controller
public class CTMB04Controller {
	
	@Resource(name="CTMB04Service")
	private CTMB04Service ctmb04Service;
	
	@Resource(name="DMCJ02Service")
	private DMCJ02Service DMCJ02Service;
	
	/**
	 * NIS과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b04/CTMB0401.do")
	public String CTMB0402(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model)throws Exception {
		model.addAttribute("TASK_SN" , "45");
		model.addAttribute("TASK_NO" , "CJ_A02_138");
		model.addAttribute("TASK_END", "N");
		return "/pantheon/ctms/b04/CTMB0401";
	}

	/**
	 * 과제별 수탁기관 초기
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b04/selectInitTaskTrust.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectInitTaskTrust(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> edc017  = null;
		List<Map<String, Object>> ctmc013 = null;

		try {
			map.put("CMMN_CLCODE", "CTMS013");
			ctmc013 = DMCJ02Service.selectCommonCodeList(map);
		
			result.put("success", true   );
			result.put("EDC017" , edc017 );			
			result.put("CTMS013", ctmc013);			
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 과제별 수탁기관 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b04/selectTaskTrustInsttList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskTrustInsttList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("selectTaskTrustInsttList");
		System.out.println("=====> "+map);
		try {
			list = ctmb04Service.selectTaskTrustInsttList(map);
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	

	/**
	 * 과제별 수탁기관 정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b04/insertTaskTrustInstt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertTaskTrustInstt(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			ctmb04Service.insertTaskTrustInstt(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
}
