package realtime.shopping.user.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import realtime.shopping.user.serice.UserService;

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
	public Map<String , Object> apiSelectTbUserCountForCheck(@RequestParam Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
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
