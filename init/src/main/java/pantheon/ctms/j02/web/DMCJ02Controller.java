package pantheon.ctms.j02.web;

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

import pantheon.com.utl.Util;
import pantheon.ctms.j02.service.DMCJ02Service;

@Controller
public class DMCJ02Controller {
	
	@Resource(name="DMCJ02Service")
	private DMCJ02Service DMCJ02Service;

	/**
	 * 공지사항 관리 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j02/DMCJ0201.do")
	public String DMCJ0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j02/DMCJ0201";
	}
	
	@RequestMapping(value="/ctms/j02/DMCJ0202.do")
	public String DMCJ0202(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j02/DMCJ0202";
	}
	
	/**
	 * 공통코드 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j02/selectCommonCodeList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCommonCodeList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		try {
			list = DMCJ02Service.selectCommonCodeList(map);	
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 공지사항 관리 목록  데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j02/selectAllNoticeList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectAllNoticeList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;	
		
		List<Map<String, Object>> module_se  = null; //모듈구분 공통코드
		List<Map<String, Object>> notice_se  = null; //공지구분 공통코드     CTMS017
		try {
			list = DMCJ02Service.selectAllNoticeList(map);				
			
			map.put("CMMN_CLCODE", "DMCJ01");
			module_se = DMCJ02Service.selectCommonCodeList(map);
			map.put("CMMN_CLCODE", "DMCJ02");
			notice_se = DMCJ02Service.selectCommonCodeList(map);
			
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("result", list);		
			
			result.put("module_se", module_se );
			result.put("notice_se", notice_se );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 공지사항 관리 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value="/ctms/j02/selectNoticeByPopup.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNoticeByPopup(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> roleId = null;
		
		try {
			list = DMCJ02Service.selectNoticeByPopup(map);	
			roleId = DMCJ02Service.selectRoleId(map);
			result.put("success", true);			
			result.put("result", list);		
			result.put("roleId", roleId);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	/**
	 * 공지사항 권한관리 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j02/insertNoticeManageData.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertNoticeManageData(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			DMCJ02Service.insertNoticeManageData(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
	/**
	 * 공지사항 송/수신 권한 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j02/insertNoticeAuthor.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertNoticeAuthor(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map================================="+list);		
		try {
			DMCJ02Service.insertNoticeAuthor(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
}
