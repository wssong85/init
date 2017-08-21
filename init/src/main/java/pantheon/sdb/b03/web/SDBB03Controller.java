package pantheon.sdb.b03.web;

import java.util.ArrayList;
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

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.sdb.b03.service.SDBB03Service;
import egovframework.com.cmm.annotation.IncludedInfo;

@Controller
public class SDBB03Controller {
	@Resource(name="SDBB03Service")
	private SDBB03Service sdbb03Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@RequestMapping(value="/sdb/b03/SDBB0301.do")
	public String sdbb0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/b03/SDBB0301";	 	
	}
	
	@RequestMapping(value="/sdb/b03/SDBB0302.do")
	public String sdbb0302(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> map11 = new HashMap<String, String>();
		Map<String, String> map10 = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType11 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType10 = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB072");
		map.put("task_code", "1");
		map.put("type", "type");
		map11.put("CMMN_CLCODE", "SDB011");
		map11.put("task_code", "1");
		map11.put("type", "type");
		map10.put("CMMN_CLCODE", "SDB010");
		map10.put("task_code", "1");
		map10.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			printType11 = comd01Service.selectCmCmmnCodeListByPk(map11);
			printType10 = comd01Service.selectCmCmmnCodeListByPk(map10);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("printType11", printType11);
		request.setAttribute("printType10", printType10);
		
		String INSTT_NO = request.getParameter("INSTT_NO");			
		request.setAttribute("INSTT_NO", INSTT_NO);
		return "/pantheon/sdb/b03/SDBB0302";	 	
	}
	
	@RequestMapping(value="/sdb/b03/popupSDBB0303.do")
	public String popupSdbb0303(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		
		String INSTT_NO = request.getParameter("INSTT_NO");			
		request.setAttribute("INSTT_NO", INSTT_NO);
		
		return "/pantheon/sdb/b03/SDBB0303";		
		
	}	
	
	/**
	 * 기관 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/b03/insertOrganList.do")
	public Map<String, Object> insertOrganList(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb03Service.insertOrganList(iMap);
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 기관 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b03/selectOrganInfo.do")
	public Map<String, Object> selectOrganInfo(HttpServletRequest req, HttpServletResponse resp, @RequestParam Map<String, String> param ) throws Exception {			
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		//Map<String, Object> result = new HashMap<String, Object>();		
		map = sdbb03Service.selectOrganInfo(param);
		
		try {			
			result.put("success", "true");
			result.put("result", map);
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 기관 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b03/selectOrganList.do")
	public @ResponseBody Map<String , Object> selectOrganList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb03Service.selectOrganList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping(value="/sdb/b03/selectOrganListPop.do")
	public @ResponseBody Map<String, Object> selectOrganListPop(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = sdbb03Service.selectOrganListPop(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		
		return result;
	}
	
	
	
	//
}
