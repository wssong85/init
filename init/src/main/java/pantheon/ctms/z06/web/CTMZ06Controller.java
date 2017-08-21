package pantheon.ctms.z06.web;


import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.RequestParam;



import pantheon.com.common.service.PantheonCommonService;



@Controller
public class CTMZ06Controller {
	
	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	
	/**
	 * 임상 기관리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/z06/CTMZ0601.do")
	public String CTMZ0601(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception {
		return "/pantheon/ctms/z06/CTMZ0601";
	}
	
	
	
	
	
	
	
	
	
}
