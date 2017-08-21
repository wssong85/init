package pantheon.ctms.h01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.h01.service.CTMH01Service;

@Controller
public class CTMH01Controller {
	
	@Resource(name="CTMH01Service")
	private CTMH01Service CTMH01Service;

	/**
	 * REQUEST FORM  리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/h01/CTMH0101.do")
	public String CTMH0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		request.setAttribute("map", map);
		return "/pantheon/ctms/h01/CTMH0101";
	}
	
	@RequestMapping(value="/ctms/h01/CTMH0102.do")
	public String CTMH0102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/h01/CTMH0102";
	}
	/**
	 * 유저정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/h01/selectUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			list = CTMH01Service.selectUserInfo(map);			
			result.put("success", true);						
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * REQUEST FORM 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/h01/selectRequestList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRequestList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> moduleCode  = null; //모듈 공통코드	
		List<Map<String, Object>> requestCode  = null; //요청구분 공통코드
		List<Map<String, Object>> requestSttus  = null; //상태 공통코드
		int count = 0;
		try {
			map.put("CMMN_CLCODE", "CTMS024");
			moduleCode = CTMH01Service.selectCommonCodeList(map);		
			map.put("CMMN_CLCODE", "CTMS025");
			requestCode = CTMH01Service.selectCommonCodeList(map);	
			map.put("CMMN_CLCODE", "CTMS027");
			requestSttus = CTMH01Service.selectCommonCodeList(map);	
			
			count = CTMH01Service.selectRequestListByCount(map);	
			list = CTMH01Service.selectRequestList(map);			
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("moduleCode", moduleCode);
			result.put("requestCode", requestCode);
			result.put("requestSttus", requestSttus);
			result.put("count", count);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * REQUEST FORM 파일 이름 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/h01/selectRequestFileNm.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRequestFileNm(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;	
		try {
			list = CTMH01Service.selectRequestFileNm(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * REQUEST FORM 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/h01/insertRequestForm.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRequestForm(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		System.out.println("list==================================================="+list);
		try {
			CTMH01Service.insertRequestForm(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * FileUpload 삭제
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/h01/insertUploadFile.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertUploadFile(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();				
		try {
			CTMH01Service.insertFileUpload(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/*-------------------------------------------------------------------------------------------------------------------------*/
}
