package pantheon.ctms.z13.web;

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
import pantheon.ctms.z13.service.CTMZ13Service;



@Controller
public class CTMZ13Controller {

	@Resource(name="CTMZ13Service")
	private CTMZ13Service CTMZ13Service;

	/**
	 * IRB info 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z13/CTMZ1301.do")
	public String CTMZ1301(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map
			, ModelMap model) throws Exception {
		model.addAttribute("TASK_SN", "45");
		model.addAttribute("TASK_NO", "CJ_A02_138");
		model.addAttribute("SCREEN_ID", "CTMZ1301");
		return "/pantheon/ctms/z13/CTMZ1301";
	}
	
	/**
	 * IRB 기초 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z13/selectIRBBasicInfoList.do")
	public @ResponseBody Map<String , Object> selectIRBBasicInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> irblist  = null; //기초정보 리스트

		try {
			irblist = CTMZ13Service.selectIRBBasicInfoList(map);
			result.put("success", true);
			result.put("irblist"  , irblist );
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
	@RequestMapping(value="/ctms/z13/insertIRBBasicInfo.do")
	public @ResponseBody Map<String, Object> insertIRBBasicInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMZ13Service.insertIRBBasicInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}	
	
	/**
	 * IRB 사용자 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z13/selectUserInfoList.do")
	public @ResponseBody Map<String , Object> selectUserInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> irblist  = null; //기초정보 리스트

		try {
			irblist = CTMZ13Service.selectUserInfoList(map);
			result.put("success", true);
			result.put("irblist"  , irblist );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

/*-------------------------------------------------------------------------------------------------------------------------------*/

}



