package realtime.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
	
	/**
	 * include 파일 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/common.do")
	public String common(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/common/common";
	}
	
	/**
	 * left 파일 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/leftMenu.do")
	public String leftMenu(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/common/leftMenu";
	}
	
}
