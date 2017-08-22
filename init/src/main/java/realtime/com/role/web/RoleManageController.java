package realtime.com.role.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.com.role.service.RoleManageService;

/**
 * 
 * @author songwonseock
 *
 */
@Controller
public class RoleManageController {
	
	@Resource(name = "RoleManageService")
	private RoleManageService roleManageService;

	/**
	 * 역할관리화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/roleManage.do")
	public String roleManage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/role/roleManage";
	}
	
	/**
	 * 프로그램관리 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/programManage.do")
	public String programManage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/role/programManage";
	}
	
	/**
	 * 메뉴관리 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/menuManage.do")
	public String menuManage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/role/menuManage";
	}
	
	/**
	 * 역할결합화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/roleCombineManage.do")
	public String roleCombine(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/role/roleCombineManage";
	}
	
	/**
	 * 프로그램 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbProgramList.do")
	@ResponseBody 
	public Map<String , Object> selectTbProgramList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbProgramList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 프로그램 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/role/multiTbProgram.do")
	public @ResponseBody Map<String , Object> multiTbProgram(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			roleManageService.multiTbProgram(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
	
	/**
	 * 메뉴 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbMenuList.do")
	@ResponseBody 
	public Map<String , Object> selectTbMenuList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbMenuList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 메뉴 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/role/multiTbMenu.do")
	public @ResponseBody Map<String , Object> multiTbMenu(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			roleManageService.multiTbMenu(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
	/**
	 * 상위 메뉴 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbUpMenuList.do")
	@ResponseBody 
	public Map<String , Object> selectTbUpMenuList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbUpMenuList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 상위 메뉴 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/role/multiTbUpMenu.do")
	public @ResponseBody Map<String , Object> multiTbUpMenu(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			roleManageService.multiTbUpMenu(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
	/**
	 * 역할 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbRolesList.do")
	@ResponseBody 
	public Map<String , Object> selectTbRoleList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbRolesList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 역할 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/role/multiTbRoles.do")
	public @ResponseBody Map<String , Object> multiTbRoles(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			roleManageService.multiTbRoles(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
	/**
	 * 메뉴리스트 조회(역할결합화면)
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbMenuListForRoleCombine.do")
	@ResponseBody 
	public Map<String , Object> selectTbMenuListForRoleCombine(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbMenuListForRoleCombine(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 역할결합화면 (권한)
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/role/selectTbMenuProgramListByRole.do")
	@ResponseBody 
	public Map<String , Object> selectTbMenuProgramListByRole(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = roleManageService.selectTbMenuProgramListByRole(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 역할결합 입력
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/role/insertTbMenuProgramForAll.do")
	public @ResponseBody Map<String , Object> insertTbMenuProgramForAll(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			roleManageService.insertTbMenuProgramForAll(list);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
		
	}
	
}
