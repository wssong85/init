package pantheon.ctms.z04.web;

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
import pantheon.ctms.z04.service.CTMZ04Service;


@Controller
public class CTMZ04Controller {
	
	@Resource(name="CTMZ04Service")
	private CTMZ04Service ctmz04Service;

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
	 * 모니터링 계획
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z04/CTMZ0401.do")
	public String CTMZ0401(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z04/CTMZ0401";
	}
	
	/**
	 * 모니터링 보고서
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z04/CTMZ0402.do")
	public String CTMZ0402(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z04/CTMZ0402";
	}
	
	/**
	 * 모니터링 목록
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z04/CTMZ0403.do")
	public String CTMZ0403(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z04/CTMZ0403";
	}
	
	
	/**
	 * 모니터링 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z04/selectMonitoringGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectMonitoringGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();	
			List<Map<String, Object>> list = null;					
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
		try {
			list = ctmz04Service.selectMonitoringGrid(map);
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
	 * 모니터링 방문차수 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z04/selectVisitOdr.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitOdr(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> list = new HashMap<String, Object>();
		try {			
			list = ctmz04Service.selectVisitOdr(map);			
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 모니터링 이전 방문차수 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z04/selectvisitOdrPrevious.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectvisitOdrPrevious(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> list = new HashMap<String, Object>();
		try {			
			list = ctmz04Service.selectvisitOdrPrevious(map);			
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	
	
	/**
	 * 모니터링 MAIN 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z04/selectMonitoringMain.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectMonitoringMain(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> list = new HashMap<String, Object>();
			
		try {
			
			list = ctmz04Service.selectMonitoringMain(map);
			
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 모니터링 VISIT1 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z04/selectVisitInfoGrid1.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoGrid1(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			
			list = ctmz04Service.selectVisitInfoGrid1(map);		
			
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 모니터링 VISIT2 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z04/selectVisitInfoGrid2.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoGrid2(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			
			list = ctmz04Service.selectVisitInfoGrid2(map);		
			
			
			for(Map<String, Object> deli : list){
				deli.put("FROM_VISIT_DE", EgovDateUtil.convertDate(String.valueOf(deli.get("FROM_VISIT_DE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				deli.put("TO_VISIT_DE", EgovDateUtil.convertDate(String.valueOf(deli.get("TO_VISIT_DE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));	
				
			}
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**모니터링  ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z04/selectVisitInfoItem.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoItem(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			list = ctmz04Service.selectVisitInfoItem(map);			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	
	
	
	/**
	 * 모니터링 계획보고서 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z04/insertMonitoringPlanReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertMonitoringPlanReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz04Service.insertMonitoringPlanReport(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 모니터링 결재번호 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z04/selectApprovalInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectApprovalInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();			
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
			
			List<Map<String, Object>> list = null;				
			
			
		try {
			list = ctmz04Service.selectApprovalInfo(map);
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
	 * 모니터링 방문보고서 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z04/insertMonitoringVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertMonitoringVisitReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz04Service.insertMonitoringVisitReport(list);
			result.put("success", true);
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
	@RequestMapping(value="/ctms/z04/updateApproval.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateApproval(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz04Service.updateApproval(list);
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
	@RequestMapping(value="/ctms/z04/insertApprovalEmail.do", method=(RequestMethod.POST))
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
