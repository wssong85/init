package pantheon.ctms.j04.web;

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
import pantheon.ctms.j04.service.DMCJ04Service;

@Controller
public class DMCJ04Controller {
	
	@Resource(name="DMCJ04Service")
	private DMCJ04Service DMCJ04Service;

	/**
	 * REQUEST FORM  리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j04/DMCJ0401.do")
	public String DMCJ0401(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception {
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/j04/DMCJ0401";
	}
	
	
	/**
	 * 유저정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j04/selectUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			list = DMCJ04Service.selectUserInfo(map);			
			result.put("success", true);						
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * REQUEST FORM 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j04/selectRequestList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRequestList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> moduleCode  = null; //모듈 공통코드	
		List<Map<String, Object>> requestCode  = null; //요청구분 공통코드
		List<Map<String, Object>> requestSttus  = null; //상태 공통코드
		int count = 0;
		try {
			map.put("CMMN_CLCODE", "CTMS024");
			moduleCode = DMCJ04Service.selectCommonCodeList(map);		
			map.put("CMMN_CLCODE", "CTMS025");
			requestCode = DMCJ04Service.selectCommonCodeList(map);	
			map.put("CMMN_CLCODE", "CTMS027");
			requestSttus = DMCJ04Service.selectCommonCodeList(map);	
			
			count = DMCJ04Service.selectRequestListByCount(map);	
			list = DMCJ04Service.selectRequestList(map);			
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("moduleCode", moduleCode);
			result.put("requestCode", requestCode);
			result.put("requestSttus", requestSttus);
			result.put("count", count);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * REQUEST FORM 리스트 데이터 승인,반려
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j04/insertRequestForm.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRequestForm(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		
		try {
			DMCJ04Service.insertRequestForm(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
}
