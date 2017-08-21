package pantheon.edc.k05.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.edc.k05.service.EDCK05Service;



@Controller
public class EDCK05Controller {

	@Resource(name="EDCK05Service")
	private EDCK05Service EDCK05Service;

	/**
	 * IRB info 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/edc/k05/EDCK0501.do")
	public String EDCK0501(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) {
		model.addAttribute("TASK_SN", "45");
		model.addAttribute("TASK_NO", "CJ_A02_138");
		return "/pantheon/edc/k05/EDCK0501";
	}
	
	/**
	 * IRB 기초 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/edc/k05/selectIRBBasicInfoList.do")
	public @ResponseBody Map<String , Object> selectIRBBasicInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null; //기초정보 리스트

		try {
			list = EDCK05Service.selectIRBBasicInfoList(map);
			result.put("success", true);
			result.put("result"  , list );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	
	/**
	 * IRB 기초 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/edc/k05/selectIRBBasicEndInfoList.do")
	public @ResponseBody Map<String , Object> selectIRBBasicEndInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null; //기초정보 리스트

		try {
			list = EDCK05Service.selectIRBBasicEndInfoList(map);
			result.put("success", true);
			result.put("result"  , list );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	/**
	 * IRB 기초정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/edc/k05/insertIRBBasicInfo.do")
	public @ResponseBody Map<String, Object> insertIRBBasicInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			EDCK05Service.insertIRBBasicInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}	

}



