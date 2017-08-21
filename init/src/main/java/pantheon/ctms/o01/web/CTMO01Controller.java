package pantheon.ctms.o01.web;

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
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.o01.service.CTMO01Service;

@Controller
public class CTMO01Controller {
	
	@Resource(name="CTMO01Service")
	private CTMO01Service CTMO01Service;

	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;

	/**
	 * 연구자정보 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	
	@RequestMapping(value="/ctms/o01/CTMO0101.do")
	public String CTMO0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception {
						
		return "/pantheon/ctms/o01/CTMO0101";
	}
	/**
	 * 연구자정보 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectRsrchUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			Map<String, String> param2 = new HashMap<String, String>();
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS001");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS034");
			
			list = CTMO01Service.selectRsrchUserInfo(map);
			for(Map<String, Object> deli : list){
				deli.put("ISF_PYMNT_DE", EgovDateUtil.convertDate((String) deli.get("ISF_PYMNT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("DSCNTC_DE", EgovDateUtil.convertDate((String) deli.get("DSCNTC_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				
			}
			result.put("success", true);
			result.put("result", list);		
			result.put("cmCode", CommonService.selectQueryDataList(param));
			result.put("activeCode", CommonService.selectQueryDataList(param2));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 연구자정보 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/updateRsrchUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateRsrchUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.updateRsrchUserInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 조사연구기관 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectRsrchInstt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchInstt(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS001");
			
			list = CTMO01Service.selectRsrchInstt(map);			
			result.put("success", true);
			result.put("result", list);		
			result.put("cmCode", CommonService.selectQueryDataList(param));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 조사연구기관 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/insertRsrchInstt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchInstt(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.insertRsrchInstt(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 계약관리 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectCntrctManage.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCntrctManage(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS020");
			
			list = CTMO01Service.selectCntrctManage(map);	
			for(Map<String, Object> deli : list){
				deli.put("EXMNT_REQUST_DE", EgovDateUtil.convertDate((String) deli.get("EXMNT_REQUST_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("FRST_CREAT_DE", EgovDateUtil.convertDate((String) deli.get("FRST_CREAT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("CNTRCT_DE", EgovDateUtil.convertDate((String) deli.get("CNTRCT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}
			result.put("success", true);
			result.put("result", list);		
			result.put("cmCode", CommonService.selectQueryDataList(param));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 계약관리 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/updateCntrctManage.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateCntrctManage(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.updateCntrctManage(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 연구비 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectResearchFunds.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectResearchFunds(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS001");			
			list = CTMO01Service.selectResearchFunds(map);
			for(Map<String, Object> deli : list){
				deli.put("RCPMNY_DE", EgovDateUtil.convertDate((String) deli.get("RCPMNY_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("LAST_PYMNT_DE", EgovDateUtil.convertDate((String) deli.get("LAST_PYMNT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}
			result.put("success", true);
			result.put("result", list);		
			
			result.put("cmCode", CommonService.selectQueryDataList(param));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 연구비 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/insertResearchFunds.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertResearchFunds(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.insertResearchFunds(list);			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * IRB심의 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectRsrchDlbrt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchDlbrt(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			Map<String, String> param2 = new HashMap<String, String>();
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS001");			
		
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS016");
			
			list = CTMO01Service.selectRsrchDlbrt(map);
			for(Map<String, Object> deli : list){
				deli.put("PRESENTN_DE", EgovDateUtil.convertDate((String) deli.get("PRESENTN_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("DLBRT_DE", EgovDateUtil.convertDate((String) deli.get("DLBRT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("DLBRT_RESULT_DE", EgovDateUtil.convertDate((String) deli.get("DLBRT_RESULT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("DLBRTCT_RCPMNY_DE", EgovDateUtil.convertDate((String) deli.get("DLBRTCT_RCPMNY_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}
			
			result.put("success", true);
			result.put("result", list);				
			result.put("cmCode001", CommonService.selectQueryDataList(param));
			result.put("cmCode016", CommonService.selectQueryDataList(param2));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * IRB심의 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/insertRsrchDlbrt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchDlbrt(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.insertRsrchDlbrt(list);			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * 동의서 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectRsrchWrtcns.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchWrtcns(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param = new HashMap<String, String>();
			
			List<Map<String, Object>> list = null;		

		try {
			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS001");	
			
			list = CTMO01Service.selectRsrchWrtcns(map);
			for(Map<String, Object> deli : list){
				deli.put("VALID_DE", EgovDateUtil.convertDate((String) deli.get("VALID_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));				
			}
			
			result.put("success", true);
			result.put("result", list);				
			result.put("cmCode", CommonService.selectQueryDataList(param));
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 동의서 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/insertRsrchWrtcns.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchWrtcns(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.insertRsrchWrtcns(list);			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 버전 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/selectRsrchVer.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchVer(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, String> param1 = new HashMap<String, String>(); //항목
			Map<String, String> param2 = new HashMap<String, String>(); //심의종류
			List<Map<String, Object>> list = null;		

		try {
			
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "CTMS028");	
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS029");	
			list = CTMO01Service.selectRsrchVer(map);
			for(Map<String, Object> deli : list){
				deli.put("CONFM_DE", EgovDateUtil.convertDate((String) deli.get("CONFM_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));				
			}
			
			result.put("success", true);
			result.put("result", list);				
			result.put("cmCodeItem", CommonService.selectQueryDataList(param1));
			result.put("cmCodeReview", CommonService.selectQueryDataList(param2));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 버전 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/o01/insertRsrchVer.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchVer(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMO01Service.insertRsrchVer(list);			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
