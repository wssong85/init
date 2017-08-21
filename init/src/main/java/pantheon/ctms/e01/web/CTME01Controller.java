package pantheon.ctms.e01.web;

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

import pantheon.com.utl.Util;
import pantheon.ctms.l01.service.CTML01Service;
import pantheon.ctms.v01.service.CTMV01Service;



@Controller
public class CTME01Controller {

	@Resource(name="CTMV01Service")
	private CTMV01Service CTMV01Service;

	@Resource(name="CTML01Service")
	private CTML01Service CTML01Service;

	/**
	 * IRB info 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/CTME0101.do")
	public String CTME0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception{
		model.addAttribute("TASK_SN", "");
		model.addAttribute("TASK_NO", "");
		model.addAttribute("SCREEN_ID", "CTME0101");
		return "/pantheon/ctms/e01/CTME0101";
	}

	/**
	 * IRB 기초 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBInitInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBInitInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> insttlist  = null; //기관리스트
		List<Map<String, Object>> cralist    = null; //CRA 리스트
		List<Map<String, Object>> code1list  = null; //연락처구분코드     CTMS017
		List<Map<String, Object>> code2list  = null; //심의비 구분1 코드 CTMS008
		List<Map<String, Object>> code3list  = null; //심의비 구분2코드  CTMS009
		List<Map<String, Object>> code4list  = null; //계산서 종류 구분   CTMS010
		List<Map<String, Object>> code5list  = null; //심의 구분             CTMS016
		List<Map<String, Object>> code6list  = null; //심의 종류 구분      CTMS026

		try {
			insttlist = CTML01Service.selectInsttList(map);
			cralist   = CTML01Service.selectCRAList(map);
			
			map.put("CMMN_CLCODE", "CTMS017");
			code1list = CTML01Service.selectCommonCodeList(map);
			map.put("CMMN_CLCODE", "CTMS008");
			code2list = CTML01Service.selectCommonCodeList(map);
			map.put("CMMN_CLCODE", "CTMS009");
			code3list = CTML01Service.selectCommonCodeList(map);
			map.put("CMMN_CLCODE", "CTMS010");
			code4list = CTML01Service.selectCommonCodeList(map);
			map.put("CMMN_CLCODE", "CTMS016");
			code5list = CTML01Service.selectCommonCodeList(map);
			
			map.put("CMMN_CLCODE", "CTMS026");
			code6list = CTML01Service.selectCommonCodeList(map);

			result.put("success"  , true);
			result.put("insttlist", insttlist );
			result.put("cralist"  , cralist   );
			result.put("code1list", code1list );
			result.put("code2list", code2list );
			result.put("code3list", code3list );
			result.put("code4list", code4list );
			result.put("code5list", code5list );
			result.put("code6list", code6list );

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB 기초 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBBasicInfoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBBasicInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> irblist  = null; //기초정보 리스트

		try {
			irblist = CTMV01Service.selectIRBBasicInfoList(map);
			result.put("success", true);
			result.put("irblist"  , irblist );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB 연락처 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBCttpcList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBCttpcList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> cttpcList   = null; //IRB 연락처

		try {
			cttpcList   = CTMV01Service.selectIRBCttpcList  (map);

			result.put("success", true);
		    result.put("cttpcList"  , cttpcList   );

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB 심의비 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBDlbrtctList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBDlbrtctList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> dlbrtctList = null; //IRB 심의비

		try {
			dlbrtctList = CTMV01Service.selectIRBDlbrtctList(map);

			result.put("success", true);
		    result.put("dlbrtctList", dlbrtctList );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB 연구비 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBRsrcctist.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBRsrcctist(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> rsrcctist   = null; //IRB 연구비

		try {
			rsrcctist   = CTMV01Service.selectIRBRsrcctList  (map);

			result.put("success", true);
		    result.put("rsrcctist"  , rsrcctist   );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB 심의 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBDlbrtList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBDlbrtList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> dlbrtList   = null; //IRB 심의

		try {
			dlbrtList   = CTMV01Service.selectIRBDlbrtList  (map);

			result.put("success", true);
		    result.put("dlbrtList"  , dlbrtList   );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * IRB SAE 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBSaeList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBSaeList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> saeList = null; //IRB SAE

		try {
			saeList   = CTMV01Service.selectIRBSaeList(map);

			result.put("success", true);
		    result.put("saeList", saeList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * e-IRB 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/selectIRBInfoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectIRBInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> eInfoList   = null; //e-IRB

		try {
			eInfoList   = CTMV01Service.selectIRBInfoList   (map);

			result.put("success", true);
		    result.put("eInfoList"  , eInfoList   );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * IRB 기초정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBBasicInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBBasicInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBBasicInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * IRB 연락처 정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBCttpcInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBCttpcInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBCttpcInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * IRB 심의비 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBDlbrtctInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBDlbrtctInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBDlbrtctInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * IRB 연구비 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBRsrcctInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBRsrcctInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBRsrcctInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * IRB 심의 정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBDlbrtInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBDlbrtInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBDlbrtInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * e-IRB 정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBInfoInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBInfoInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBInfoInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * IRB SAE 정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/e01/insertIRBSaeInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertIRBSaeInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTMV01Service.insertIRBSaeInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
/*-------------------------------------------------------------------------------------------------------------------------------*/

}



