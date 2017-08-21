package pantheon.com.b01.web;

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
import pantheon.com.b01.service.COMB01Service;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.impl.PantheonReloadableFilterInvocationSecurityMetadataSource;

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
public class COMB01Controller {
	
	@Resource(name = "COMB01Service")
	private COMB01Service comb01Service;
	
//	@Resource(name ="databaseSecurityMetadataSource2")
//	private PantheonReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource2;

	
	/**
	 * 역할관리 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/b01/COMB0101.do")
	public String comb0101(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		//역할 저장 버튼 구분자
		model.addAttribute("AUTH_BTN_GUBUN", EgovProperties.getProperty("auth.btn.cmrole"));
		return "pantheon/com/b01/COMB0101";
	}
	
	/**
	 * 역할 콤보박스리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/selectCmRoleForComboBox.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleForComboBox(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comb01Service.selectCmRoleForComboBox(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 통합사용자관리에서 역할 정보 입력 수정 
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/insertCmRoleByCmRole.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmRoleByCmRole(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//사용자정보를 받아온다.
		Map<String, String> loginMap = Util.getUserMap();
		
		//사용자아이디를 각 map에 put한다.
		for(Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", loginMap.get("USER_ID"));
		}
		
		try {
			comb01Service.insertCmRoleByCmRole(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할관리 목록 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/selectCmRole.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCmRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comb01Service.selectCmRole(null);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할관리 입력,수정
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/insertCmRole.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmRole(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//사용자정보를 받아온다.
		Map<String, String> loginMap = Util.getUserMap();
		
		//사용자아이디를 각 map에 put한다.
		for(Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", loginMap.get("USER_ID"));
		}
		
		try {
			comb01Service.insertCmRole(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할계층 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/selectComtnrolesHierarchy.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectComtnrolesHierarchy(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comb01Service.selectComtnrolesHierarchy(null);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할계층 수정
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/b01/insertComtnrolesHierarchy.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertComtnrolesHierarchy(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			comb01Service.insertComtnrolesHierarchy(list);
			
			//스프링 시큐리티 역할계층 reload
//			databaseSecurityMetadataSource2.reload();

			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	

}
