package pantheon.ctms.d01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.d01.service.CTMD01Service;



@Controller
public class CTMD01Controller {

	@Resource(name="CTMD01Service")
	private CTMD01Service CTMD01Service;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	
	/**
	 * 시스템 교육 정보 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctms/d01/CTMD0101.do")
	public String CTMD0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		//model.addAttribute("SCREEN_ID", "CTMD0101");
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/d01/CTMD0101";
	}
	
	/**
	 * 과제 교육 정보 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctms/d01/CTMD0102.do")
	public String CTMD0102(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		//model.addAttribute("SCREEN_ID", "CTMD0101");
		model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/d01/CTMD0102";
	}

	
}



