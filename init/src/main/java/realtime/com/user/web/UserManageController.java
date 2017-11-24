package realtime.com.user.web;

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
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.com.role.service.RoleManageService;
import realtime.com.user.service.UserManageService;

@Controller
public class UserManageController {

	@Resource(name = "UserManageService")
	private UserManageService userManageService;
	
	@Resource(name = "RoleManageService")
	private RoleManageService roleManageService;

	/**
	 * 사용자관리 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/user/userManage.do")
	public String userManage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		List<Map<String, Object>> metaDataList = userManageService.selectTbUserMetaData();
		List<Map<String, Object>> roleList = roleManageService.selectTbRolesList(null);
		
		model.addAttribute("metaDataList", metaDataList);
		model.addAttribute("roleList", roleList);
			
		return "realtime/com/user/userManage";
	}
	
	/**
	 * 사용자 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/user/selectTbUserList.do")
	@ResponseBody 
	public Map<String , Object> selectTbUserList(HttpServletRequest request) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			
			list = userManageService.selectTbUserList();
			
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 사용자 입력,수정,삭제
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/user/multiTbUser.do")
	@ResponseBody 
	public Map<String , Object> multiTbProgram(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			userManageService.multiTbUser(list);
			
			result.put("success", true);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	@RequestMapping("/com/user/test.do")
	@ResponseBody 
	public Map<String , Object> Test(@RequestBody List<Map<String, Object>> list) throws Exception {
		
		System.out.println("call?");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			System.out.println(list);
			
			for(Map<String, Object> map : list) {
				
				System.out.println(map.get("test1"));
				System.out.println(map.get("test2"));
			}
			
			result.put("success", true);
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
}
