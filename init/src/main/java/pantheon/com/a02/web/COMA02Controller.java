package pantheon.com.a02.web;

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
import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.a02.service.COMA02Service;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonProgrmLogAspect;

/**
 * 프로그램 처리하는 컨트롤러 클래스
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
public class COMA02Controller {
	
	@Resource(name="COMA02Service")
	private COMA02Service coma02Service;
	
	@Resource(name="PantheonProgrmLogAspect")
	private PantheonProgrmLogAspect pantheonProgrmLogAspect;
	
//	@Resource(name="databaseSecurityMetadataSource")
//	private EgovReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource;
	
	/**
	 * 프로그램관리 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/com/a02/COMA0201.do")
	public String coma0201(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		//프로그램 역할 제한 저장 버튼 구분자
		model.addAttribute("AUTH_BTN_GUBUN", EgovProperties.getProperty("auth.btn.cmrolelmtt"));
		return "/pantheon/com/a02/COMA0201";
	}
	
	/**
	 * 프로그램 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/selectCmProgrm.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmProgrm(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma02Service.selectCmProgrm(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 프로그램 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/insertCmProgrm.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmProgrm(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			
			coma02Service.insertCmProgrm(list);
			
			//프로그램 이력 URL 재설정
			pantheonProgrmLogAspect.setInstanceForProgrmInitialUrl();
			
			//스프링 시큐리티 url mapping 권한 재설정
//			databaseSecurityMetadataSource.reload();

			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	
	/**
	 * 버튼 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/selectCmButtonByProgrmId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmButtonByProgrmId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma02Service.selectCmButtonByProgrmId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 버튼 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/insertCmButton.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmButton(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			coma02Service.insertCmButton(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할제한 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/selectCmRoleLmttByProgrmId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleLmttByProgrmId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma02Service.selectCmRoleLmttByProgrmId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할 제한 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/insertCmRoleLmttByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmRoleLmttByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			coma02Service.insertCmRoleLmttByPk(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 역할 고정여부로 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a02/selectCmRoleByFixingAtForComboBox.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmRoleByFixingAtForComboBox(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma02Service.selectCmRoleByFixingAtForComboBox(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	
}
