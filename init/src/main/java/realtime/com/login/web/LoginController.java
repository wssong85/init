package realtime.com.login.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	/**
	 * 로그인 인덱스 화면
	 * @param model
	 * @return
	 */
	@RequestMapping("/index.do")
	public String index(ModelMap model) throws Exception{
		return "forward:/com/login/loginUsr.do";
	}
	
	/**
	 * login 화면 (메인 화면)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/login/loginUsr.do")
	public String loginUsr(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/login/loginUsr";
	}
	
}
