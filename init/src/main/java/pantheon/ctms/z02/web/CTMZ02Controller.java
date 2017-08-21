package pantheon.ctms.z02.web;

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
import pantheon.ctms.z01.service.CTMZ01Service;
import pantheon.ctms.z02.service.CTMZ02Service;

@Controller
public class CTMZ02Controller {
	
	@Resource(name="CTMZ02Service")
	private CTMZ02Service ctmz02Service;

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
	 * 개시방문 준비기록 CTMZ0201
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/z02/CTMZ0201.do")
	public String CTMZ0201(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z02/CTMZ0201";
	}
	
	/**
	 * 개시방문 보고서 CTMZ0202
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z02/CTMZ0202.do")
	public String CTMZ0202(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z02/CTMZ0202";
	}
	
	/**
	 * 개시방문 목록
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z02/CTMZ0203.do")
	public String CTMZ0203(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		
		return "/pantheon/ctms/z02/CTMZ0203";
	}
	
	/**
	 * 개시방문 준비기록 참석자 VISIT조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/selectVisitInfoGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			list = ctmz02Service.selectVisitInfoGrid(map);
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 개시방문 준비기록 Main 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/z02/selectVisitInfoMain.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoMain(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> list = new HashMap<String, Object>();
			
		try {
			
			list = ctmz02Service.selectVisitInfoMain(map);
			
			
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 개시방문 준비기록 데이터 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/selectVisitInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			
			Map<String, String> param = new HashMap<String, String>();			
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
			
			List<Map<String, Object>> list = null;		
			
			

		try {
			list = ctmz02Service.selectVisitInfo(map);
			
			for(Map<String, Object> deli : list){	
				deli.put("FRST_CREAT_DE", EgovDateUtil.convertDate((String) deli.get("FRST_CREAT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("OPRTN_DE", EgovDateUtil.convertDate((String) deli.get("OPRTN_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				
			}			
			
			result.put("param", CommonService.selectQueryDataList(param));		
			result.put("success", true);
			result.put("result", list);		
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * 개시방문 준비기록 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/insertPlanVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertPlanVisitReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz02Service.insertPlanVisitReport(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
		
	
	/**
	 * 개시방문 준비기록 결제순번 수정
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/updateApproval.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateApproval(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz02Service.updateApproval(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 개시방문 준비기록 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/selectApprovalInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectApprovalInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	

		try {
			list = ctmz02Service.selectApprovalInfo(map);			
			
			result.put("success", true);
			result.put("result", list);		
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**개시방문 보고서 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/selectVisitInfoItem.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoItem(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			list = ctmz02Service.selectVisitInfoItem(map);
			for(Map<String, Object> deli : list){	
				deli.put("DTE", EgovDateUtil.convertDate((String) deli.get("DTE"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));				
			}
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * 메일 링크
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="selectMailLink.do")
	public String selectMailLink(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {		
		model.addAttribute("MILESTONE_SN", map.get("MILESTONE_SN"));
		model.addAttribute("result", map);
		return "redirect:/index.do";
	}
	
	/**
	 * 개시방문 보고서 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z02/insertVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertVisitReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			ctmz02Service.insertVisitReport(list);
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
	@RequestMapping(value="/ctms/z02/insertApprovalEmail.do", method=(RequestMethod.POST))
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
