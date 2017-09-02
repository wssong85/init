package realtime.com.login.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;

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
	
	@RequestMapping(value = "/com/login/processLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		System.out.println("vvv");
		return "";
	}
	
	/**
	 * 초기화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/login/intro.do")
	public String intro(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("111");
		System.out.println("111");
		System.out.println("123");
		return "realtime/com/login/intro";
	}
	
	@RequestMapping(value = "/com/board/board_27.do")
	public String board(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("111");
		System.out.println("111");
		System.out.println("123");
		return "realtime/com/login/intro";
	}

	
	
}
