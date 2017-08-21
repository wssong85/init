package pantheon.ctms.j06.web;

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

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.j06.service.DMCJ06Service;

@Controller
public class DMCJ06Controller {
	
	@Resource(name="DMCJ06Service")
	private DMCJ06Service DMCJ06Service;
	
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
	 * 연구자관리 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
//	@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j06/DMCJ0601.do")
	public String DMCJ0601(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
//		model.addAttribute("TASK_SN" , "45");
//		model.addAttribute("TASK_NO" , "CJ_A02_138");
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/j06/DMCJ0601";
	}
	/**
	 * 연구자관리 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j06/selectRsrchManage.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchManage(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		Map<String, String> param3 = new HashMap<String, String>();
		Map<String, String> param4 = new HashMap<String, String>();
		try {
			list = DMCJ06Service.selectRsrchManage(map);
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "CTMS018");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS019");
			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param3.put("CMMN_CLCODE", "CTMS020");
			param4.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param4.put("CMMN_CLCODE", "CTMS030");
			for(Map<String, Object> deli : list){
				deli.put("STTUS_DTE", EgovDateUtil.convertDate((String) deli.get("STTUS_DTE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				
			}
			
			result.put("success", true);			
			result.put("result", list);		
			result.put("cmCode1", CommonService.selectQueryDataList(param1));
			result.put("cmCode2", CommonService.selectQueryDataList(param2));
			result.put("cmCode3", CommonService.selectQueryDataList(param3));
			result.put("cmCode4", CommonService.selectQueryDataList(param4));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 연구자관리 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j06/insertRsrchManage.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchManage(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		try {
			DMCJ06Service.insertRsrchManage(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		
		return result;
	}
	
	@RequestMapping(value="/ctms/j06/popupDMCJ0602.do")
	public String DMCJ0602(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j06/DMCJ0602";
	}
	
	/**
	 * 연구자검색 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j06/selectRsrUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		
		try {
			list = DMCJ06Service.selectRsrUserInfo(map);		
			
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
	@RequestMapping(value="/ctms/j06/insertPasswordEmail.do", method=(RequestMethod.POST))
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
		map.put("HTML_NM", propertiesMailService.getString("TEST_MAIL_TEMPLATE"));
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
