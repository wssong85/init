package pantheon.ctms.c01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.utl.Util;
import pantheon.ctms.c01.service.CTMC01Service;



@Controller
public class CTMC01Controller {

	@Resource(name="CTMC01Service")
	private CTMC01Service CTMC01Service;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * Investigational Infomation
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/c01/CTMC0101.do")
	public String CTMC0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		model.addAttribute("SCREEN_ID", "CTMC0101");
		return "/pantheon/ctms/c01/CTMC0101";
	}

	/**
	 * 시험기관 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/c01/selectInvestInfoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectInvestInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null;

		try {
			list = CTMC01Service.selectInvestInfoList(map);
			result.put("success", true);
			result.put("result" , list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}


/*-------------------------------------------------------------------------------------------------------------------------------*/

}



