package pantheon.ctms.j08.web;

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

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.j08.service.DMCJ08Service;

@Controller
public class DMCJ08Controller {
	
	@Resource(name="DMCJ08Service")
	private DMCJ08Service dmcj08Service;

	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	
	/** EmailService */
	@Resource(name = "PantheonMailService")
	private PantheonMailService PantheonMailService;
	
	//EMAIL
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	/**
	 * 과제별사용자 조회 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j08/DMCJ0801.do")
	public String DMCJ0801(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j08/DMCJ0801";
	}
	
	@RequestMapping(value="/ctms/j08/popupDMCJ0802.do")
	public String popupDMCJ0802(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j08/DMCJ0802";
	}
	
	
	
	/**
	 * 공통코드 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/selectCommonCodeList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCommonCodeList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		try {
			list = dmcj08Service.selectCommonCodeList(map);	
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * ROLE_ID 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/selectRoleId.do")
	public @ResponseBody Map<String , Object> selectRoleId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		
		try {
			list = dmcj08Service.selectRoleId(map);
			result.put("success", true);
			result.put("result", list);	
		
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * USER ROLE_ID 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/selectUserRoleId.do")
	public @ResponseBody Map<String , Object> selectUserRoleId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		
		try {
			list = dmcj08Service.selectUserRoleId(map);			
			
			result.put("success", true);
			result.put("result", list);	
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 과제별사용자  데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/selectTaskUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> insttCode  = null; //모듈구분 공통코드		
		List<Map<String, Object>> userSeCode  = null; //사용자구분 공통코드
		List<Map<String, Object>> divisionId  = null; //아이디 구분 공통코드
		List<Map<String, Object>> stdTime  = null; //표준시간대
		
		try {
			map.put("CMMN_CLCODE", "COM001");
			userSeCode = dmcj08Service.selectCommonCodeList(map);		
			map.put("CMMN_CLCODE", "DMCJ05");
			insttCode = dmcj08Service.selectCommonCodeList(map);			
			map.put("CMMN_CLCODE", "DMCJ04");
			divisionId = dmcj08Service.selectCommonCodeList(map);
			stdTime = dmcj08Service.standardTimeList(map);
			
			
			list = dmcj08Service.selectTaskUserInfo(map);	
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("userSeCode", userSeCode);	
			result.put("insttCode", insttCode);			
			result.put("divisionId", divisionId);
			
			result.put("stdTime", stdTime);
			result.put("result", list);
	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	/**
	 * 과제별사용자 정보 삭제
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/insertTaskUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertTaskUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			dmcj08Service.insertTaskUserInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 과제별사용자 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j08/insertTaskUser.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertTaskUser(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		try {
			dmcj08Service.deleteTaskUserByRole(list);
			dmcj08Service.insertTaskUser(list);			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
	/**
	 * 과제별 role  데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/j08/selectUserRoleInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectUserRoleInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		try {
			list = dmcj08Service.selectUserRoleInfo(map);	
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 사용자 정보 조회(중복체크)
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/j08/selectOverlapUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectOverlapUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		List<Map<String, Object>> list = null;	
		try {
			list = dmcj08Service.selectOverlapUserInfo(map);	
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * EMAIL
	 * @param request
	 * @param response
	 */	
	@RequestMapping(value="/ctms/j08/insertPasswordEmail.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> sendMail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String emailInfo = "";
		String userName = "";
		for(Map<String, Object> iMap : list){
			emailInfo = (String) iMap.get("EMAIL");
			userName = (String) iMap.get("USER_NM");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
		map.put("HTML_NM", propertiesMailService.getString("PASSWORD_MAIL_TEMPLATE"));
		//html에는 el식 기준으로 작성하면 변환됨
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		map.put("URL", "52.2.72.215:8080");
		PantheonMailService.sendMail(map, emailInfo, userName, "메일발송테스트");
		
		try {
			result.put("success", true);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
}
