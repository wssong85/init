package pantheon.ctms.b03.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.ctms.b03.service.CTMB03Service;


@Controller
public class CTMB03Controller {
	
	@Resource(name="CTMB03Service")
	private CTMB03Service ctmb03Service;
	

	/**
	 * NIS과제 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="NIS과제및 과제정보", order = 7050 ,gid = 110)
	@RequestMapping(value="/ctms/b03/CTMB0301.do")
	public String CTMB0301(HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);
		return "/pantheon/ctms/b03/CTMB0301";
	}
	
	/**
	 * NIS과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b03/CTMB0302.do")
	public String CTMB0302(HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);
		return "/pantheon/ctms/b03/CTMB0302";
	}
	
	/**
	 * NIS과제 헤더 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b03/selectNISTask_NoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNISTask_NoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = ctmb03Service.selectNISTask_NoList(map);	
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("success", true);
			result.put("result", list);			
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * NIS과제 TASK_NO 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b03/selectAssignmentbyNisGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectAssignmentbyNisGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		//System.out.println("PMSAnnual========================================================"+map);

		try {
			list = ctmb03Service.selectAssignmentbyNisGrid(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * NIS 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b03/insertAssignmentbyNisGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertAssignmentbyNisGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			ctmb03Service.insertAssignmentbyNisGrid(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * NIS과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b03/selectNisStatusGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNisStatusGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = ctmb03Service.selectNisStatusGrid(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
}
