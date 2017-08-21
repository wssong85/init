package pantheon.ctms.a01.web;

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

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.a01.service.CTMA01Service;



@Controller
public class CTMA01Controller {

	@Resource(name="CTMA01Service")
	private CTMA01Service ctma01service;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	/**
	 * 공지사항 HOME
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctms/a01/CTMA0101.do")
	public String CTMA0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/a01/CTMA0101";		
	}
	
	/**
	 * 공지사항 작성 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctms/a01/popupCTMA0102.do")
	public String popupCTMA0102(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{

		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		param1.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //모듈 구분 공통코드
		param1.put("CMMN_CLCODE", "DMCJ01");
		param2.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //전체, 과제구분 공통코드
		param2.put("CMMN_CLCODE", "DMCJ02");
		model.addAttribute("moduleCode"  , CommonService.selectQueryDataList(param1));
		model.addAttribute("divisionCode", CommonService.selectQueryDataList(param2));

		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/a01/CTMA0102";
	}
	
//	/**
//	 * 공지사항 count 조회
//	 * @param request
//	 * @param response
//	 * @return
//	 */
//	@RequestMapping(value="/ctms/a01/selectNoticeByCount.do", method=(RequestMethod.POST))
//	public @ResponseBody Map<String , Object> selectNoticeByCount(HttpServletRequest request, HttpServletResponse response, 
//			@RequestParam Map<String, String> map) throws Exception {
//		Map<String, Object> result = new HashMap<String, Object>();
//		List<Map<String, Object>> list = null;
//		
//		try {
//			list = ctma01service.selectNoticeByCount(map);
//			result.put("success", true );			
//			result.put("noticeCount", list);
//					
//		} catch (Exception e) {
//			result.put("success", false);
//			result.put("message", Util.getPantheonErrorMessage(e, this));		
//		}
//		
//		return result;
//	}
	
	/**
	 * 공지사항 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/a01/selectNotice.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNotice(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
//		List<Map<String, Object>> param = null;
		try {
			list = ctma01service.selectNotice(map);
			result.put("success", true );
			result.put("result", list);
					
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 공지사항 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/a01/selectNoticeInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNoticeInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> notice = null;
		System.out.println("selectNoticeInfo==================> map : "+map);
		try {
			notice = ctma01service.selectNoticeInfo(map);
			result.put("success", true );
			result.put("result", notice);
					
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 공통코드 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/a01/selectCmmnCode.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchuserList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		param1.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //모듈 구분 공통코드
		param1.put("CMMN_CLCODE", "DMCJ01");
		param2.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //전체, 과제구분 공통코드
		param2.put("CMMN_CLCODE", "DMCJ02");		
		
		try {
			param1.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param1.put("CMMN_CLCODE", "DMCJ01");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "DMCJ02");
			
			result.put("success", true );			
			result.put("moduleCode", CommonService.selectQueryDataList(param1));
			result.put("divisionCode", CommonService.selectQueryDataList(param2));			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 공지사항 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/a01/insertNotice.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertNotice(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);

		try {
			ctma01service.insertNotice(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
/*-----------------------------------------------------------------------------------------------------------------------------------*/

	/**
	 * 공지사항 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/a01/selectNotifyCtmsList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectNotifyCtmsList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = ctma01service.selectNotifyCtmsList(map);
			result.put("success", true );	
			result.put("result", list);
					
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
}
