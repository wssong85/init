package pantheon.ctms.b02.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.ctms.b02.service.CTMB02Service;


@Controller
public class CTMB02Controller {
	
	@Resource(name="CTMB02Service")
	private CTMB02Service ctmb02Service;
	

	/**
	 * PMS과제 화면 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="PMS 과제및 과제정보", order = 7040 ,gid = 110)
	@RequestMapping(value="/ctms/b02/CTMB0201.do")
	public String CTMB0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);
		return "/pantheon/ctms/b02/CTMB0201";
	}
	
	/**
	 * PMS과제정보 화면 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b02/CTMB0202.do")
	public String CTMB0202(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);
		return "/pantheon/ctms/b02/CTMB0202";
	}
	
	/**
	 * PMS과제 TASK_NO 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b02/selectPmsTask_NoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectProtocolTask_NoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		//System.out.println("PMSAnnual========================================================"+map);

		try {
			list = ctmb02Service.selectPmsTask_NoList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * PMS과제 Summary 과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b02/selectPmsSummaryGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectPmsSummaryGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> taskInfo = null;		
		List<Map<String, Object>> prptocol = null;		
		List<Map<String, Object>> Annual = null;		

		try {
			taskInfo = ctmb02Service.selectPmsSummaryGrid(map);		
			prptocol = ctmb02Service.selectPmsProtocolGrid(map);	
			Annual = ctmb02Service.selectPmsAnnualGrid(map);	
			
			result.put("success", true);
			result.put("taskInfo", taskInfo);		
			result.put("prptocol", prptocol);	
			result.put("Annual", Annual);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * PMS과제정보 Status 과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b02/selectPmsStatusGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectPmsStatusGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		
		try {
			list = ctmb02Service.selectPmsStatusGrid(map);				
			result.put("success", true);
			result.put("result", list);		
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
}
