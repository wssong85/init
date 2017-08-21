package pantheon.com.i02.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.i02.service.COMI02Service;
import pantheon.com.utl.Util;

/**
 * 아이디/비밀번호 찾기 처리하는 컨트롤러 클래스
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
public class COMI02Controller {

	@Resource(name = "COMI02Service")
	private COMI02Service comi02Service;
	
	@RequestMapping("/com/anonymous/COMI0202.do")
	public String comi0202(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String strGubun = request.getParameter("GUBUN");
		String strViewGubun = request.getParameter("VIEW_GUBUN");
		
		if(strGubun == null || strViewGubun == null) {
			return "redirect:/com/i01/pantheonLoginUsr.do";
		}
		
		model.addAttribute("GUBUN", strGubun);
		model.addAttribute("VIEW_GUBUN", strViewGubun);
		return "pantheon/com/i02/COMI0202";
	}

	
	@RequestMapping("/com/anonymous/COMI0203.do")
	public String comi0203(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		return "pantheon/com/i02/COMI0203";
	}
	
	@RequestMapping("/com/anonymous/COMI0204.do")
	public String comi0204(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String param = request.getParameter("PASSWORD_CODE");
		
		if(param == null) {
			return "redirect:/com/i01/pantheonLoginUsr.do";
		}
		
		model.addAttribute("PASSWORD_CODE", param);
		return "pantheon/com/i02/COMI0204";
	}
	
	/**
	 * 아이디 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmUserForFindId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmUserForFindId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Map<String, String> mapUser = comi02Service.selectCmUserForFindId(map);
			result.put("USER_NM", mapUser.get("USER_NM"));
			result.put("USER_ID", mapUser.get("USER_ID"));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 메일 발송 시 유저 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/updateCmUserForSendTmpMail.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> updateCmUserForSendTmpMail(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comi02Service.updateCmUserForSendTmpMail(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 변경 시 유저 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/updateCmUserForChgPassword.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> updateCmUserForChgPassword(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comi02Service.updateCmUserForChgPassword(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 변경
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/updateCmUserForChgPasswordByPasswordCode.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> updateCmUserForChgPasswordByPasswordCode(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comi02Service.updateCmUserForChgPasswordByPasswordCode(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 코드 수정(Main 클릭)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/i02/updateCmUserForMainClick.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> updateCmUserForMainClick(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			String ret = comi02Service.updateCmUserForMainClick(map);
			result.put("success", true);
			result.put("result", ret);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

}