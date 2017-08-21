package pantheon.edc.j03.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.edc.j03.service.EDCJ03Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * Report AE 목록을 처리하는 컨트롤러 클래스
 * @author 오동근
 * @since 2016.03.16
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.16  오동근          최초 생성
 *  
 */
@Controller
@RequestMapping("/edc/j03")
public class EDCJ03Controller {
	
	@Resource(name = "EDCJ03Service")
	EDCJ03Service edcj03Service;
	
	@IncludedInfo(name="pantheon AE 목록", order = 6570, gid = 110)
	@RequestMapping("/EDCJ0301.do")
	public String ResearchAtrailList(ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/j03/EDCJ0301";
	}
	
	/**
	 * Report AE 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectAeList.do")
	public @ResponseBody Map<String , Object> seletAeList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			 list = edcj03Service.selectAeList(map);
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
}
