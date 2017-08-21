package pantheon.ctms.j07.web;

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

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.utl.Util;
import pantheon.ctms.j07.service.DMCJ07Service;



@Controller
public class DMCJ07Controller {

	@Resource(name="DMCJ07Service")
	private DMCJ07Service DMCJ07Service;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * Investigational Infomation
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j07/DMCJ0701.do")
	public String DMCJ0701(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception{
		model.addAttribute("SCREEN_ID", "DMCJ0701");
		return "/pantheon/ctms/j07/DMCJ0701";
	}

	/**
	 * 권한별 메뉴 및 버튼 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j07/selectRoleByProgAndBtnList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRoleByProgAndBtnList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null;

		try {
			list = DMCJ07Service.selectRoleByProgAndBtnList(map);
			result.put("success", true);
			result.put("result" , list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 과제별 버튼 권한 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j07/selectTaskByBtnList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskByBtnList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null;

		try {
			list = DMCJ07Service.selectTaskByBtnList(map);
			result.put("success", true);
			result.put("result" , list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	
	/**
	 * 과제별 버튼 권한 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/j07/insertTaskByBtnInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertTaskByBtnInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+list);
		try {
			DMCJ07Service.insertTaskByBtnInfo(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

/*-------------------------------------------------------------------------------------------------------------------------------*/

}



