package pantheon.edc.j02.web;

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

import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.edc.j02.service.EDCJ02Service;

@Controller
@RequestMapping("/edc/j02")
public class EDCJ02Controller {
	
	@Resource(name = "EDCJ02Service")
	EDCJ02Service edcj02Service;
	
	@IncludedInfo(name="pantheon Comment 목록", order = 6560, gid = 110)
	@RequestMapping("/EDCJ0201.do")
	public String ResearchAtrailList(ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/j02/EDCJ0201";
	}
	
	/**
	 * Report Comment 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectAtrailList.do")
	public @ResponseBody Map<String , Object> seletResearchSubjectList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edcj02Service.selectAtrailList(map);
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}

}
