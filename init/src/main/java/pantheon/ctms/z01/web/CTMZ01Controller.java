package pantheon.ctms.z01.web;

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


import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.z01.service.CTMZ01Service;


@Controller
public class CTMZ01Controller {
	
	@Resource(name="CTMZ01Service")
	private CTMZ01Service ctmz01Service;

	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	/**
	 * 과제별사용자 조회 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/z01/CTMZ0101.do")
	public String CTMZ0101(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		return "/pantheon/ctms/z01/CTMZ0101";
	}
	
	
	/**
	 * 기관정보 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z01/selectInsttInfo.do")
	public @ResponseBody Map<String , Object> selectInsttInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			
			List<Map<String, Object>> list = null;		

		try {
			list = ctmz01Service.selectInsttInfo(map);
			
			result.put("success", true);
			result.put("result", list);		
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 방문보고서 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z01/selectVisitReportInfo.do")
	public @ResponseBody Map<String , Object> selectVisitReportInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
		
			List<Map<String, Object>> list = null;		
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");

		try {
			list = ctmz01Service.selectVisitReportInfo(map);
			
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
	 * 적합성 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z01/selectComPatibilityReportInfo.do")
	public @ResponseBody Map<String , Object> selectComPatibilityReportInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param2= new HashMap<String, String>();
		
			List<Map<String, Object>> list = null;		
			
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS041");

		try {
			list = ctmz01Service.selectComPatibilityReportInfo(map);
			
			result.put("success", true);
			result.put("result", list);	
			result.put("param2", CommonService.selectQueryDataList(param2)); 			
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	
	
	
}
