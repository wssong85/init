package pantheon.com.h01.web;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import pantheon.com.h01.service.COMH01Service;
import pantheon.com.utl.Util;

/**
 * 전자계약 처리하는 컨트롤러 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
@Controller
public class COMH01Controller {
	
	@Resource(name = "COMH01Service")
	private COMH01Service comh01Service;
	
	
	/**
	 * 본인인증 메인 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/checkplus_main.do")
	public String checkplus_main(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception{
	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
	    
	    String sSiteCode = EgovProperties.getProperty("sms.auth.code");				// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = EgovProperties.getProperty("sms.auth.password");		// NICE로부터 부여받은 사이트 패스워드
	    String sRequestNumber = EgovProperties.getProperty("sms.auth.reqnumber");   // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
	                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
	  	
	   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
	   	
	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	   	String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
			
	    String sReturnUrl = Util.getFullUrl() + "/com/anonymous/checkplus_success.do";      // 성공시 이동될 URL
	    String sErrorUrl = Util.getFullUrl() + "/com/anonymous/checkplus_fail.do";          // 실패시 이동될 URL

	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
	    
	    String sMessage = "";
	    String sEncData = "";
	    
	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	    if( iReturn == 0 )
	    {
	        sEncData = niceCheck.getCipherData();
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "암호화 시스템 에러입니다.";
	    }    
	    else if( iReturn == -2)
	    {
	        sMessage = "암호화 처리오류입니다.";
	    }    
	    else if( iReturn == -3)
	    {
	        sMessage = "암호화 데이터 오류입니다.";
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }
	    
	    model.addAttribute("sEncData", sEncData);
		return "pantheon/com/h01/checkplus/checkplus_main";
	}

	/**
	 * 본인인증 성공 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/checkplus_success.do")
	public String checkplus_success(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception{
		
	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
	    String sEncodeData = Util.requestReplace(request.getParameter("EncodeData"), "encodeData");
	    String sReserved1  = Util.requestReplace(request.getParameter("param_r1"), "");
	    String sReserved2  = Util.requestReplace(request.getParameter("param_r2"), "");
	    String sReserved3  = Util.requestReplace(request.getParameter("param_r3"), "");
	    String sSiteCode = EgovProperties.getProperty("sms.auth.code");				   // NICE로부터 부여받은 사이트 코드
	    String sSitePassword = EgovProperties.getProperty("sms.auth.password");			 // NICE로부터 부여받은 사이트 패스워드
	    String sCipherTime = "";				 // 복호화한 시간
	    String sRequestNumber = "";			 // 요청 번호
	    String sResponseNumber = "";		 // 인증 고유번호
	    String sAuthType = "";				   // 인증 수단
	    String sName = "";							 // 성명
	    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
	    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
	    String sBirthDate = "";					 // 생일
	    String sGender = "";						 // 성별
	    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
	    String sMessage = "본인인증이 완료되었습니다.";
	    String sPlainData = "";
	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);
	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();
	        
	        // 데이타를 추출합니다.
	        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
	        
	        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
	        sResponseNumber = (String)mapresult.get("RES_SEQ");
	        sAuthType 		= (String)mapresult.get("AUTH_TYPE");
	        sName 			= (String)mapresult.get("NAME");
	        sBirthDate 		= (String)mapresult.get("BIRTHDATE");
	        sGender 		= (String)mapresult.get("GENDER");
	        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
	        sDupInfo 		= (String)mapresult.get("DI");
	        sConnInfo 		= (String)mapresult.get("CI");
	        
	        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	        if(!sRequestNumber.equals(session_sRequestNumber))
	        {
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	            sResponseNumber = "";
	            sAuthType = "";
	        }
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
	    }    
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
	    }    
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
	    }    
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }    
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }
	    
	    model.put("USER_NAME", sName);
	    model.put("sMessage", sMessage);
		
		return "pantheon/com/h01/checkplus/checkplus_success";
	}

	/**
	 * 본인인증 실패 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/checkplus_fail.do")
	public String checkplus_fail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sEncodeData = Util.requestReplace(request.getParameter("EncodeData"), "encodeData");
	    String sReserved1  = Util.requestReplace(request.getParameter("param_r1"), "");
	    String sReserved2  = Util.requestReplace(request.getParameter("param_r2"), "");
	    String sReserved3  = Util.requestReplace(request.getParameter("param_r3"), "");

	    String sSiteCode = EgovProperties.getProperty("sms.auth.code");				   // NICE로부터 부여받은 사이트 코드
	    String sSitePassword = EgovProperties.getProperty("sms.auth.password");			 // NICE로부터 부여받은 사이트 패스워드

	    String sCipherTime = "";					// 복호화한 시간
	    String sRequestNumber = "";				// 요청 번호
	    String sErrorCode = "";						// 인증 결과코드
	    String sAuthType = "";						// 인증 수단
	    String sMessage = "본인인증이 실패하였습니다.";
	    String sPlainData = "";
	    
	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();
	        
	        // 데이타를 추출합니다.
	        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
	        
	        sRequestNumber 	= (String)mapresult.get("REQ_SEQ");
	        sErrorCode 			= (String)mapresult.get("ERR_CODE");
	        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
	    }    
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
	    }    
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
	    }    
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }    
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }

		model.put("sMessage", sMessage);
		model.put("sErrorCode", sErrorCode);
		
		return "pantheon/com/h01/checkplus/checkplus_fail";
	}
	
	/**
	 * 테스트
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/popup_01.do")
	public String popup_01(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/h01/popup_01";
	}
	
	/**
	 * 권한 오류 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/i01/code403.do")
	public String code403(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/i01/code403";
	}
	
	/**
	 * 전자계약 최초 url 요청시 로그인 화면으로 redirect 시켜준다.
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/Contract")
	public String contract(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "forward:/com/anonymous/COMH0109.do";
	}
	
	/**
	 * 전자계약 로그인 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0109.do")
	public String anonymousComh0109(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = Util.getHttpSession();
		
		//기존 세션값 무효화
		session.setAttribute("REQ_INFO", null);
		session.setAttribute("REQ_USER_ID", null);
		session.setAttribute("JOIN_SUCCESS", null);
		session.setAttribute("JOIN_TASK_NO", null);
		session.setAttribute("JOIN_PROGRESS_LEVEL", "1");
		
		return "pantheon/com/h01/COMH0109";
	}
	
	/**
	 * 약관동의 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0101.do")
	public String anonymousComh0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = Util.getHttpSession();
		
		if(!"1".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/Contract";	
		}
		
		session.setAttribute("JOIN_PROGRESS_LEVEL", "2");
		
		return "pantheon/com/h01/COMH0101";
	}
	
	/**
	 * 본인인증 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0102.do")
	public String anonymousComh0102(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HttpSession session = Util.getHttpSession();
		
		if(!"2".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/Contract";		
		}
		
		if(EgovStringUtil.isEmpty(request.getParameter("TASK_NO"))) {
			return "redirect:/Contract";
		}
		
		session.setAttribute("JOIN_PROGRESS_LEVEL", "3");
		session.setAttribute("JOIN_TASK_NO", request.getParameter("TASK_NO"));
		
		return "pantheon/com/h01/COMH0102";
	}
	
	/**
	 * 정보입력 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0103.do")
	public String anonymousComh0103(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HttpSession session = Util.getHttpSession();
		
		String userName = request.getParameter("USER_NAME");
		
		if(userName == null) {
			return "redirect:/Contract";
		}
		
		if(!"3".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/Contract";	
		}
		
		session.setAttribute("JOIN_PROGRESS_LEVEL", "4");
		
		model.put("USER_NAME", userName);
		
		return "pantheon/com/h01/COMH0103";
	}
	
	/**
	 * 계약안내 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0104.do")
	public String anonymousComh0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = Util.getHttpSession();
		
		if(!"4".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/Contract";	
		}
		
		session.setAttribute("JOIN_PROGRESS_LEVEL", "5");
		
		return "pantheon/com/h01/COMH0104";
	}
	
	/**
	 * 계약요청 화면 호출
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0105.do")
	public String anonymousComh0105(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HttpSession session = Util.getHttpSession();
		
		if(!"5".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/Contract";	
		}
		
		if(session.getAttribute("REQ_USER_ID") != null && 
				comh01Service.selectCmRsrchuserCountByUserId(EgovStringUtil.isNullToString(session.getAttribute("REQ_USER_ID"))) > 0) {
			model.addAttribute("REQ_INFO", comh01Service.selectCmUserByReqUserId(EgovStringUtil.isNullToString(session.getAttribute("REQ_USER_ID"))));
		} else {
			return "redirect:/Contract";
		}
		
		if(request.getParameter("TASK_NO") != null) {
			session.setAttribute("JOIN_TASK_NO", request.getParameter("TASK_NO"));
		} else {
			return "redirect:/Contract";
		}
		
		session.setAttribute("JOIN_PROGRESS_LEVEL", "6");
		
		//테스트
//			model.addAttribute("REQ_INFO", comh01Service.selectCmUserByReqUserId("testws1"));
//			session.setAttribute("JOIN_TASK_NO", "13");
		return "pantheon/com/h01/COMH0105";
	}
	
	/**
	 * 계약요청완료 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0106.do")
	public String anonymousComh0106(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = Util.getHttpSession();
		if(!"6".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
			return "redirect:/com/anonymous/COMH0109.do";		
		}
		return "pantheon/com/h01/COMH0106";
	}
	
	/**
	 * 계약서미리보기 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/COMH0107.do")
	public String anonymousComh0107(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
//		HttpSession session = Util.getHttpSession();
//		if(!"7".equals(EgovStringUtil.isNullToString(session.getAttribute("JOIN_PROGRESS_LEVEL")))) {
//			return "redirect:/com/anonymous/COMH0109.do";	
//		}
//		session.setAttribute("JOIN_PROGRESS_LEVEL", "8");
		return "pantheon/com/h01/COMH0107";
	}
	
	/**
	 * 과제 중복 체크
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectEdcCrTaskCountForDupCheckByTaskNo.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectEdcCrTaskCountForDupCheckByTaskNo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			result.put("success", true);
			result.put("count", comh01Service.selectEdcCrTaskCountForDupCheckByTaskNo(map.get("TASK_NO")));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 시간 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmStdTimeForJoin.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmStdTimeForJoin(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> list = comh01Service.selectCmStdTimeForJoin();
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 연구자 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/insertCmRsrchuserForJoin.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmRsrchuserForJoin(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			comh01Service.insertCmRsrchuserForJoin(map);
			
			HttpSession session = Util.getHttpSession();
			
			//전자계약으로 계약안내로 이동;
			session.setAttribute("JOIN_SUCCESS", "01");
			session.setAttribute("REQ_USER_ID", map.get("USER_ID"));
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * ctms 계약 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/insertCtmsCoCntrctManageForJoin.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCtmsCoCntrctManageForJoin(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comh01Service.insertCtmsCoCntrctManageForJoin(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 유저 중복체크
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmUserCountForDupCheck.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmUserCountForDupCheck(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("success", true);
			result.put("count", comh01Service.selectCmUserCountForDupCheck(map.get("USER_ID")));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 유저 이메일 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmUserCountForEmail.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmUserCountForEmail(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			result.put("success", true);
			result.put("count", comh01Service.selectCmUserCountForEmail(map.get("EMAIL")));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 전자계약 이동 전 유저조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmUserForContractReq.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmUserForContractReq(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//계정 유효성 체크(만약 제대로 입력 안하면 계정잠근다.)
			comh01Service.selectCmUserForContractReq(map);
			
			HttpSession session = Util.getHttpSession();
			
			//전자계약으로 계약안내로 이동
			session.setAttribute("JOIN_SUCCESS", "02");
			session.setAttribute("REQ_USER_ID", map.get("USER_ID"));
			
			//전자계약 level 설정
			session.setAttribute("JOIN_PROGRESS_LEVEL", "4");
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 전자서명 유저 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/h01/selectCmUserForContractReq2.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmUserForContractReq2(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//계정 유효성 체크(만약 제대로 입력 안하면 계정잠근다.)
			comh01Service.selectCmUserForContractReq(map);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}
