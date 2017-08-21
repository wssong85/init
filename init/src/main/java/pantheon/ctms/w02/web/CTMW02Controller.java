package pantheon.ctms.w02.web;

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

import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.j06.service.DMCJ06Service;
import pantheon.ctms.w02.service.CTMW02Service;

@Controller
public class CTMW02Controller {
	
	@Resource(name="CTMW02Service")
	private CTMW02Service ctmw02Service;

	@Resource(name="DMCJ06Service")
	private DMCJ06Service DMCJ06Service;
	
	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	
	/**
	 * CRF Status Report 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0201.do")
	public String ctmw0201(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/w02/CTMW0201";
	}
	
	/**
	 * CRF Status Report : visit 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0202.do")
	public String ctmw0202(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception {
		model.addAttribute("TAKS_SN", "1");
		return "/pantheon/ctms/w02/CTMW0202";
	}
	
	/**
	 * Subject CRF Version Report 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0203.do")
	public String ctmw0203(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("TAKS_SN", "1");
		return "/pantheon/ctms/w02/CTMW0203";
	}
	
	/**
	 * Changes After Report 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0204.do")
	public String ctmw0204(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception {
		model.addAttribute("TAKS_SN", "1");
		return "/pantheon/ctms/w02/CTMW0204";
	}
	
	/**
	 * User Report 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0205.do", method=(RequestMethod.POST))
	public String ctmw0205(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("TAKS_SN", "1");
		return "/pantheon/ctms/w02/CTMW0205";
	}
	
	/**
	 * User History Report 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */	
	@RequestMapping(value="/ctms/w02/CTMW0206.do")
	public String ctmw0206(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		model.addAttribute("TAKS_SN", "1");
		return "/pantheon/ctms/w02/CTMW0206";
	}
	
	/**
	 * CRF Stauts Report 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/w02/selectCTMW0201.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCTMW0201(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		
		Map<String, String> param3 = new HashMap<String, String>();
		
		try {
			
			list = ctmw02Service.selectCTMW0201(map);
			

			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //국가코드
			param3.put("CMMN_CLCODE", "COM008");			
			
			result.put("stCode", CommonService.selectQueryDataList(param3));
			result.put("success", true);			
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	/**
	 * CRF Stauts Report : VISIT 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/w02/selectCTMW0202.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCTMW0202(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		Map<String, String> param3 = new HashMap<String, String>();
		try {
			list = ctmw02Service.selectCTMW0202(map);
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "DMCJ03");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS034");
			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //국가코드
			param3.put("CMMN_CLCODE", "COM008");
			
			result.put("roleCode", CommonService.selectQueryDataList(param1));
			result.put("ynCode", CommonService.selectQueryDataList(param2));
			result.put("stCode", CommonService.selectQueryDataList(param3));
			result.put("success", true);			
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * CRF Stauts Report 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/w02/selectCTMW0203.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCTMW0203(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		Map<String, String> param3 = new HashMap<String, String>();
		try {
			list = ctmw02Service.selectCTMW0203(map);
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "DMCJ03");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS034");
			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //국가코드
			param3.put("CMMN_CLCODE", "COM008");
			
			result.put("roleCode", CommonService.selectQueryDataList(param1));
			result.put("ynCode", CommonService.selectQueryDataList(param2));
			result.put("stCode", CommonService.selectQueryDataList(param3));
			result.put("success", true);			
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * User Report 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/w02/selectCTMW0205.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCTMW0205(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> standardTimeList = null;
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		Map<String, String> param3 = new HashMap<String, String>();
		try {
			list = ctmw02Service.selectCTMW0205(map);
			standardTimeList = ctmw02Service.standardTimeList(map);
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //롤 코드
			param1.put("CMMN_CLCODE", "DMCJ03");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //유저과제 중단 상태정보
			param2.put("CMMN_CLCODE", "CTMS034");
			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //국가코드
			param3.put("CMMN_CLCODE", "COM008");
			
			
			
			result.put("roleCode", CommonService.selectQueryDataList(param1));
			result.put("ynCode", CommonService.selectQueryDataList(param2));
			result.put("stCode", CommonService.selectQueryDataList(param3));
			result.put("success", true);			
			result.put("result", list);
			result.put("timeZone", standardTimeList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * User History Report 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/w02/selectCTMW0206.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCTMW0206(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		Map<String, String> param3 = new HashMap<String, String>();
		try {
			list = ctmw02Service.selectCTMW0206(map);
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "DMCJ03");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS034");
			param3.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //국가코드
			param3.put("CMMN_CLCODE", "COM008");
			
			result.put("roleCode", CommonService.selectQueryDataList(param1));
			result.put("ynCode", CommonService.selectQueryDataList(param2));
			result.put("stCode", CommonService.selectQueryDataList(param3));
			result.put("success", true);			
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	
	/*----------------------------------------------------------------------------------------------------------------------------*/
}
