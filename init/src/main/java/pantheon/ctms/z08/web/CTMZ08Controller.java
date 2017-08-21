package pantheon.ctms.z08.web;


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
import pantheon.ctms.z08.service.CTMZ08Service;



@Controller
public class CTMZ08Controller {
	
	@Resource(name="CTMZ08Service")
	private CTMZ08Service ctmz08Service;
	
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
	 *시험전 방문보고서 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/z08/CTMZ0801.do")
	public String CTMZ0801(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z08/CTMZ0801";
	}
	
	/**
	 * 시험전 방문보고서 목록 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/z08/CTMZ0802.do")
	public String CTMZ0802(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		return "/pantheon/ctms/z08/CTMZ0802";
	}
	
	/**
	 * 시험전 방문보고서 목록 조회
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z08/selectTitleList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTitleList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			List<Map<String, Object>> list = null;
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
		try {
			list = ctmz08Service.selectTitleList(map); //방문목적 항목 조회
			result.put("success", true);
			result.put("result"   , list);	
			result.put("param", CommonService.selectQueryDataList(param));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 시험전 방문보고서 MAIN 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z08/selectTrialVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectPreTrialVisitReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> list = new HashMap<String, Object>();
			
		try {
			
			list = ctmz08Service.selectTrialVisitReport(map);
			
			list.put("OPRTN_DE", EgovDateUtil.convertDate(String.valueOf(list.get("OPRTN_DE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", ""));
			//System.out.println("list;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"+list);
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());		
		}		
		return result;
	}
		
	
	/**
	 * 시험전 방문보고서 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z08/selectItemReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectItemReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;
			
		try {
			
			list = ctmz08Service.selectItemReport(map);		
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());		
		}		
		return result;
	}
	
	/**
	 * 시험전 방문보고서 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z08/insertPreTrialVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertMonitoringPlanReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz08Service.insertPreTrialVisitReport(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 결재번호 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z08/selectApprovalInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectApprovalInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();			
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
			
			List<Map<String, Object>> list = null;				
			
			
		try {
			list = ctmz08Service.selectApprovalInfo(map);
			result.put("success", true);
			result.put("result", list);	
			result.put("param", CommonService.selectQueryDataList(param));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 모니터링 결재번호 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z08/updateApproval.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateApproval(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz08Service.updateApproval(list);
			result.put("success", true);
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
	@RequestMapping(value="/ctms/z08/insertApprovalEmail.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> sendMail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String emailInfo = "";
		String userName = "";
		String getUrl = "";
		for(Map<String, Object> iMap : list){
			emailInfo = (String) iMap.get("EMAIL");
			userName = (String) iMap.get("USER_NM");
			getUrl = (String) iMap.get("MILESTONE_SN");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		HttpServletRequest req = Util.getHttpServletRequest();
		//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
		map.put("HTML_NM", propertiesMailService.getString("APPROVAL_MAIL_TEMPLATE"));
		//html에는 el식 기준으로 작성하면 변환됨
		map.put("URL", req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()  + "/index.do");
	
		
		PantheonMailService.sendMail(map, emailInfo, userName, "보고서 결재건");
		
		try {
			result.put("success", true);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	
	
}
