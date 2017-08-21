package pantheon.com.i01.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import egovframework.com.cmm.LoginVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.slm.EgovMultiLoginPreventor;
import egovframework.rte.fdl.property.EgovPropertyService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.fasoo.adk.packager.WorkPackager;

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.g01.service.COMG01Service;
import pantheon.com.h01.service.COMH01Service;
import pantheon.com.i01.service.COMI01Service;
import pantheon.com.sample.service.SampleService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.DamoService;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.utl.service.PantheonProgrmLogAspect;
import pantheon.com.utl.service.PantheonSmsService;
import pantheon.ctms.j03.service.DMCJ03Service;

/**
 * 로그인 처리하는 컨트롤러 클래스
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
public class COMI01Controller {
	
	private static final Logger log = LoggerFactory.getLogger(COMI01Controller.class);
	
	@Resource(name = "COMI01Service")
	private COMI01Service comi01Service;
	
	@Resource(name="COMG01Service")
	private COMG01Service comg01Service;
	
	@Resource(name = "COMH01Service")
	private COMH01Service comh01Service;
	
	@Resource(name = "DMCJ03Service")
	private DMCJ03Service dmcj03Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "PantheonProgrmLogAspect")
	private PantheonProgrmLogAspect pantheonProgrmLogAspect;
	
	@Resource(name = "DamoService")
	private DamoService damoService;
	
	@Resource(name = "PantheonSmsService")
	private PantheonSmsService pantheonSmsService;
	
	@Resource(name = "propertiesSmsService")
	protected EgovPropertyService propertiesSmsService;
	
	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
	@Resource(name = "SampleService")
	private SampleService sampleService;
	
	/**
	 * js 및 css 파일 링크 된 jsp 호출
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/common.do")
	public String mainCommon(ModelMap model) throws Exception{
		return "pantheon/com/common";
	}
	
	/**
	 * js 및 css 파일 링크 된 jsp 호출
	 * @param model	
	 * @return
	 */
	@RequestMapping("/com/popup/popupCommon.do")
	public String popoupCommon(ModelMap model) throws Exception{
		return "pantheon/com/popupCommon";
	}
	
	/**
	 * 헤더 영역
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/topHeader.do")
	public String topHeader(ModelMap model, HttpServletRequest request) throws Exception{
		
		String test = EgovStringUtil.replace(request.getServletPath(), "/WEB-INF/jsp/pantheon", "");
		model.addAttribute("LOCALE_RETURN", EgovStringUtil.replace(test, ".jsp", "") + ".do");
		
		return "pantheon/com/topHeader";
	}
	
	/**
	 * 레프트 영역
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/com/lnb.do")
	public String lnb(ModelMap model, @RequestParam Map<String, String> map, HttpServletRequest request) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		String sTaskSn = EgovStringUtil.isNullToString(Util.getUserMap().get("TASK_SN"));
		String sRoleId = EgovStringUtil.isNullToString(Util.getUserMap().get("ROLE_ID"));
		
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));

		try {
			String test = EgovStringUtil.replace(request.getServletPath(), "/WEB-INF/jsp/pantheon", "");
			test = EgovStringUtil.replace(test, ".jsp", "") + ".do";
			result.put("MODULE_CODE", map.get("MODULE_CODE"));
			result.put("MENU_ID", map.get("MENU_ID"));
			result.put("UPPER_MENU_ID", map.get("UPPER_MENU_ID"));
			result.put("leftTitle", String.valueOf(map.get("MODULE_CODE") + " SYSTEM"));
			result.put("compareId", map.get("MENU_ID"));
			
			List<Map<String, Object>> progrmList = pantheonProgrmLogAspect.getInstanceForProgrmInitialUrl();	
			
			for(Map<String, Object> iMap : progrmList) {
				
				if("N".equals(iMap.get("TASK_AT")) && map.get("MENU_ID").equals(iMap.get("PROGRM_ID"))) {
					
					sTaskSn = "";
					
				}
				
			}
			
			if(sTaskSn.compareTo("") == 0){
				
				result.put("distinctLeftMenu", comi01Service.selectCmMenuDistinctForLeftMenu(map));
				result.put("leftMenu", comi01Service.selectCmMenuForLeftMenu(map));
				
			} else{
				
				map.put("TASK_SN", sTaskSn);
				map.put("ROLE_ID", sRoleId);
				map.put("MODULE_CODE", map.get("MODULE_CODE"));
				result.put("distinctLeftMenu", comi01Service.selectDistinctTaskByLeftMenu(map));
				result.put("leftMenu", comi01Service.selectTaskByLeftMenu(map));
				
			}
			
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		model.addAttribute("result", result);
		return "pantheon/com/lnb";
	}
	
	/**
	 * intro 화면 호출
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/com/i01/intro.do")
	public String intro(ModelMap model) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			if(Util.getUserMap() != null) {
				
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_SN", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_NO", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("ROLE_ID", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_TY_CODE", null));
				
			}
			
			HttpSession hs = Util.getHttpSession();
			List<Map<String, Object>> list = comi01Service.selectCmMenuForModuleCode(Util.getUserMap());
			List<Map<String, String>> subList = new ArrayList<Map<String, String>>();
			
			String completeYn = "";
			
			//CTMS 교육
			Map<String, String> condMap = new HashMap<String, String>();
			condMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			condMap.put("GUBUN"  , "SYSTEM");
			List<Map<String, Object>> edulist = dmcj03Service.selectUserByEducationList(condMap);
			
			//CTMS 교육
			Map<String, String> map = new HashMap<String, String>();
			map.put("CMMN_CLCODE", "COM007");
			List<Map<String, Object>> moduleList = comd01Service.selectCmCmmnCodeListByPk(map);
			
			//CTMS 교육
			if(hs.getAttribute("directPath") == null) {
				for(Map<String, Object> mMap : moduleList) {
						
					model.addAttribute(mMap.get("CMMN_CODE").toString(), "Y");
						
				}
			}
			
			for(Map<String, Object> iMap : list) {
				
				Map<String, Object> tmpMap = new HashMap<String, Object>();
				tmpMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
				tmpMap.put("MODULE_CODE", iMap.get("MODULE_CODE"));
				
				//CTMS 교육
				for(Map<String, Object> eMap : edulist) {
					System.out.println(eMap);
					if("SYSTEM".equals(eMap.get("GUBUN"))){
						
						if(iMap.get("MODULE_CODE").equals(eMap.get("MODULE")) && hs.getAttribute("directPath") == null){
							
							iMap.put("COMPLETE_YN", eMap.get("COMPLETE_YN"));
							model.addAttribute(eMap.get("MODULE").toString() , eMap.get("COMPLETE_YN").toString());
							completeYn = EgovStringUtil.isNullToString(eMap.get("COMPLETE_YN"));
							
						}
						
					}
					
				}
				
				List<Map<String, String>> jList = comi01Service.selectCmMenuByModuleCode(tmpMap);
				
				if(jList.size() > 0) {
					
					iMap.put("MODULE_COUNT", jList.get(0).get("MODULE_COUNT"));
					
				}
				
				for(Map<String, String> jMap : jList) {
					
					jMap.put("COMPLETE_YN", completeYn);
					subList.add(jMap);
					
				}
				
				completeYn = "";
			}
			
			result.put("list", list);
			result.put("subList", subList);
			
			if(hs.getAttribute("directPath") != null) {
				
				Map<String, String> mapDirectPath = (Map<String, String>) hs.getAttribute("directPath");
				
				//directPath 가 세션에 들어 있다면 SDB URL을 CM_PROGRM 테이블에서 URL을 검색하여 redirect 한다.
				if("SDB".equals(mapDirectPath.get("MODULE_CODE"))) {
					
					for(Map<String, Object> iMap : list) {
						
						if("SDB".equals(iMap.get("MODULE_CODE"))) {
							
							for(Map<String, String> jMap : subList) {
								
								if("SDB".equals(jMap.get("MODULE_CODE"))) {
									
									hs.setAttribute("directPath", null);
									
									return "redirect:" + jMap.get("PROGRM_URL");

								}
								
							}
							
						}
						
					}
					
				}
				//directPath가 SDB가 아니라면 EDC과제 화면이라 생각하여 과제화면으로 보내도록 한다.
				else {
					
					return "redirect:/edc/system/EDCA0101.do";
					
				}
				
			}
			
			model.addAttribute("result", result);
			
		} catch (Exception e) {
			log.debug(e.getLocalizedMessage());
			return "forward:/com/i01/pantheonLoginUsr.do";
		}
		
		return "pantheon/com/i03/COMI0301";
	}
	
	@RequestMapping(value = "/{directPath}/index.do")
	public String directPath(HttpServletRequest request, HttpServletResponse response, @PathVariable String directPath, HttpSession session) throws Exception {
		
		Map<String, String> mapDirectPath = new HashMap<String, String>();
		
		if("SDB".equals(directPath.toUpperCase())) {
			mapDirectPath.put("MODULE_CODE", directPath.toUpperCase());
		} else {
			mapDirectPath.put("MODULE_CODE", "EDC");
			mapDirectPath.put("TASK_NO", directPath);
		}
		
		session.setAttribute("directPath", mapDirectPath);
		
		return "redirect:/com/i01/pantheonLoginUsr.do";
	}
	
	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/com/i01/pantheonLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

//		if (EgovComponentChecker.hasComponent("mberManageService")) {
//			model.addAttribute("useMemberManage", "true");
//		}
		
//		if("Y".equals(EgovStringUtil.isNullToString(request.getParameter("existence")))) {
//			model.addAttribute("existence", true);
//		} else {
//			model.addAttribute("existence", false);
//		}
		
		/*
		if(Util.getUserMap() != null) {
			return "redirect:/com/i01/intro.do";
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("page", "1");
		map.put("count", "7");
		map.put("SDATE", EgovDateUtil.addYMDtoDayTime(EgovDateUtil.getToday(), "000000", 0, 0, -30, 0 ,0, "yyyyMMdd"));
		map.put("EDATE", EgovDateUtil.getToday());
		map.put("NOTICE_BGNDE", "Y");
		map.put("NOTICE_ENDDE", "Y");

		List<Map<String, Object>> listCmNotice = comg01Service.selectCmNoticeListByPk(map);
		
		String stConvert = "";
		
		for(Map<String, Object> iMap : listCmNotice) {
			
			stConvert = EgovStringUtil.isNullToString(iMap.get("NOTICE_SJ"));
			
			if(stConvert.length() > 29) {
				iMap.put("NOTICE_SJ", stConvert.substring(0, 27) + "..");
			}
			
			iMap.put("LAST_UPDDE", EgovDateUtil.convertDate(String.valueOf(iMap.get("LAST_UPDDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", ""));
			
		}
		
		model.addAttribute("LIST_CM_NOTICE", listCmNotice);
		
		String test = EgovStringUtil.replace(request.getServletPath(), "/WEB-INF/jsp/pantheon", "");
		model.addAttribute("LOCALE_RETURN", EgovStringUtil.replace(test, ".jsp", ""));
		
		return "pantheon/com/i01/COMI0101";
		*/
		
		return "";
	}
	
	/**
	 * 로그아웃
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/i01/pantheonLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		
		if(Util.getUserMap() != null) {
			EgovMultiLoginPreventor.invalidateByLoginId(Util.getUserMap().get("USER_ID"));
		}
		
		request.getSession().setAttribute("loginVO", null);
		request.getSession().setAttribute("loginMap", null);
		request.getSession().setAttribute("progrmMap", null);
		request.getSession().setAttribute("directPath", null);
		
//		Util.getHttpSession().invalidate();
		
		return "forward:/com/i01/pantheonLoginUsr.do";
	}
	
	/**
	 * 유저 체크
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/i01/pantheonUsrOverlapCheck.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> pantheonUsrOverlapCheck(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//계정 유효성 체크(만약 제대로 입력 안하면 계정잠근다.)
			comh01Service.selectCmUserForContractReq(map);
			
			if(!comi01Service.selectCmUserForPasswordChangeDe(map)) {
				result.put("redirect", true);
			}
			
			if(EgovMultiLoginPreventor.findByLoginId(map.get("USER_ID"))) {
				result.put("OVERLAP", true);
			} else {
				result.put("OVERLAP", false);
			}
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 상단 헤더 모듈 조회(전체)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/i01/selectCmProgrmForHeaderAllModule.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmProgrmForHeaderAllModule(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		try {
			list = comi01Service.selectCmProgrmForHeaderAllModule(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 상단 헤더 모듈 조회(과제)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/i01/selectCmProgrmForHeaderTaskModule.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmProgrmForHeaderTaskModule(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		try {
			list = comi01Service.selectCmProgrmForHeaderTaskModule(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
//////////////////////////
//운영/개발 시 확인 (운영 시 필요한 프로그램이 제대로 동작되는지 ) 할 수 있도록 메소드 만듬	
////////////////////////	
	/**
	 * 운영/개발 시 확인할 수 있는 테스트 페이지
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/anonymous/test.do")
	public String test(ModelMap model) throws Exception{
		return "pantheon/com/test/test";
	}
	
	//트랜잭션테스트
	@RequestMapping("/com/anonymous/transactionTest.do")
	public @ResponseBody Map<String , Object> transactionTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			sampleService.insertSample(null);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	//메일테스트
	@RequestMapping("/com/anonymous/mailTest.do")
	public @ResponseBody Map<String , Object> mailTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			map.put("HTML_NM", propertiesMailService.getString("TEST_MAIL_TEMPLATE"));
			//html에는 el식 기준으로 작성하면 변환됨
			map.put("USER_ID", "admin");
			map.put("PASSWORD", "1234");
			map.put("URL", "52.2.72.199:8080");
			
			if(map.containsKey("MAIL") && !"".equals(EgovStringUtil.isNullToString(map.get("MAIL")))) {
				pantheonMailService.sendMail(map, map.get("MAIL"), "신창식님", "메일발송테스트");
			} else {
				pantheonMailService.sendMail(map, "csshin75@cj.net", "신창식님", "메일발송테스트");
			}
			
			result.put("success", true);
			result.put("result", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	//SMS테스트
	@RequestMapping("/com/anonymous/smsTest.do")
	public @ResponseBody Map<String , Object> smsTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			map.put("HTML_NM", propertiesSmsService.getString("TEST_SMS_TEMPLATE"));
			map.put("USER_ID", "admin");
			map.put("PASSWORD", "1234");
			map.put("URL", "52.2.72.199:8080");

			if(map.containsKey("SMS") && !"".equals(EgovStringUtil.isNullToString(map.get("SMS")))) {
				pantheonSmsService.insertSmsService(map, map.get("SMS"), "문자발송테스트");
			} else {
				pantheonSmsService.insertSmsService(map, "01032049585", "문자발송테스트");
			}
			
			result.put("success", true);
			result.put("result", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	//DRM 테스트
	@RequestMapping("/com/anonymous/drmTest.do")
	public @ResponseBody Map<String , Object> drmTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
	 		WorkPackager wp = new WorkPackager();
	 		wp.DoExtract("C:/pantheon/fasoo/fsdinit", "0000000000010105", "C:/test/drm/drm_sample.xlsx", "C:/test/drm/drm_sample.xlsx");
	 		
			result.put("success", true);
			result.put("result", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	//word pdf converter
	@RequestMapping("/com/anonymous/openOfficeTest.do")
	public @ResponseBody Map<String , Object> openOfficeTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		SocketOpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);			
		try {
			connection = new SocketOpenOfficeConnection(8100);
			connection.connect();

			result.put("success", true);
			result.put("result", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		} finally {
			try {
				if (connection.isConnected()) {
					connection.disconnect();
				}
			} catch (Exception e2) {
				log.debug(e2.getLocalizedMessage());
			}
		}
		
		return result;
	}
	
	//damo Test
	@RequestMapping("/com/anonymous/damoTest.do")
	public @ResponseBody Map<String , Object> damoTest(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String fileEncoding=System.getProperty("file.encoding");
			
			log.debug("file encoding :" + fileEncoding);
			log.debug("file encoding :" + fileEncoding);
			log.debug("file encoding :" + fileEncoding);
			
			String str1 = damoService.scpEncStr("1234");
			String str2 = damoService.scpEncStr("한글 안녕하세요 반갑습니다. 주소는 서울시 서대문구 홍은동입니다. 숫자: 222");
			String str3 = damoService.scpEncStr("中国語");
			String str4 = damoService.scpEncStr("こんにちは");
			
			String strResult = "enc 숫자 :" + str1 + "\n"
					+ "enc 한글 :" + str2 + "\n"
					+ "enc 중국어 :" + str3 + "\n"
					+ "enc 일본어 :" + str4 + "\n";
			
			String strResult2 = "dec 숫자 :" + damoService.scpDecStr(str1) + "\n"
					+ "dec 한글 :" + damoService.scpDecStr(str2) + "\n"
					+ "dec 중국어 :" + damoService.scpDecStr(str3) + "\n"
					+ "dec 일본어 :" + damoService.scpDecStr(str4) + "\n";
			
			result.put("success", true);
			result.put("result", strResult);
			result.put("result2", strResult2);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}