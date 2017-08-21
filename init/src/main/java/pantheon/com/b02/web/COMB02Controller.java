package pantheon.com.b02.web;

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

import egovframework.com.cmm.service.EgovProperties;
import pantheon.com.b02.service.COMB02Service;
import pantheon.com.utl.Util;


/**
 * 역할관리 처리하는 컨트롤러 클래스
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
public class COMB02Controller {

	@Resource(name = "COMB02Service")
	private COMB02Service comb02Service;
	
	/**
	 * 역할권한관리 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/b02/COMB0202.do")
	public String comb0202(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		//역할 저장 버튼 구분자
		model.addAttribute("AUTH_BTN_GUBUN", EgovProperties.getProperty("auth.btn.cmroleauthor"));
//		auth.btn.cmroleauthor
		return "/pantheon/com/b02/COMB0202";
	}
	
	/**
	 * 역할권한관리 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b02/selectCmRoleAuthorByRoleId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleAuthorByRoleId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comb02Service.selectCmRoleAuthorByRoleId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할권한관리 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b02/insertCmRoleAuthorByRoleId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmRoleAuthorByRoleId(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			
			comb02Service.insertCmRoleAuthorByRoleId(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * 역할권한관리 전체 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b02/selectCmMenuForDefaultGrid.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmMenuForDefaultGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comb02Service.selectCmMenuForDefaultGrid(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * 역할제한여부 N 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b02/selectCmRoleByFixingAtNForComboBox.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleByFixingAtNForComboBox(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comb02Service.selectCmRoleByFixingAtNForComboBox(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할제한여부 Y 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b02/selectCmRoleByFixingAtYForComboBox.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleByFixingAtYForComboBox(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comb02Service.selectCmRoleByFixingAtYForComboBox(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	 
}
