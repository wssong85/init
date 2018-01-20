package realtime.shopping.user.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.shopping.user.service.UserService;

@Controller
public class UserController {

	@Resource(name = "UserService")
	private UserService userService;
	
	
	/**
	 * 사용자 체크(api)
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value = "/shopping/user/apiSelectTbUserCountForCheck.do")
	@ResponseBody 
	public Map<String , Object> apiSelectTbUserCountForCheck(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		System.out.println("파라미터 => "+ map);
		
		try {
			
			if(userService.apiSelectTbUserCountForCheck(map) > 0) {
				result.put("success", true);
				result.put("result", true);	
			} else {
				result.put("success", true);
				result.put("result", false);	
			}
			
		} catch (Exception e) {
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
}
