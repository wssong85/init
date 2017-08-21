package pantheon.com.d01.web;

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

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.d01.service.COMD01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;

/**
 * 공통코드 처리하는 컨트롤러 클래스
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
public class COMD01Controller {
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name="COMD01Service")
	private COMD01Service comd01Service;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 공통코드 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/d01/COMD0101.do")
	public String comd0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/d01/COMD0101";
	}
	
	/**
	 * 분류코드 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/selectCmClCodeListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmClCodeListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = comd01Service.selectCmClCodeListByPk(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 분류코드 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/updateCmClCodeListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCmClCodeListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(true) {
			throw new UnsupportedOperationException();
		}
		/*
		try {
			comd01Service.updateCmClCodeListByPk(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		*/
		return result;
	}
	
	/**
	 * 분류코드 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/insertCmClCode.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmClCode(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			
			//테스트 환경시 Exception
			come01Service.selectCmSysEnvrnByEnvrnSe();
			
			comd01Service.insertCmClCode(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 공통코드 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/selectCmCmmnCodeListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmCmmnCodeListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comd01Service.selectCmCmmnCodeListByPk(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 공통코드 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/updateCmCmmnCodeByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCmCmmnCodeByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(true) {
			throw new UnsupportedOperationException();
		}
		/*
		try {
			comd01Service.updateCmCmmnCodeByPk(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		*/
		return result;
	}
	
	/**
	 * 공통코드 저장
	 * @param request
	 * @param response
	 * @param list
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/d01/insertCmCmmnCode.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmCmmnCode(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//테스트 환경시 Exception
			come01Service.selectCmSysEnvrnByEnvrnSe();
			
			comd01Service.insertCmCmmnCode(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
