package pantheon.sdb.f02.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.utl.Util;
import pantheon.sdb.f02.service.SDBF02Service;

@Controller
public class SDBF02Controller {
	@Resource(name = "SDBF02Service")
	private SDBF02Service sdbf02Service;
	
	@RequestMapping("/sdb/f02/SDBF0201.do")
	public String SDBF0201(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "/pantheon/sdb/f02/SDBF0201";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f02/selectLiterature.do")
	public Map<String, Object> selectLiterature(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			List<Map<String, String>> list = sdbf02Service.selectLiteratureList(map);
			for(Map<String, String> literature : list){
				literature.put("SEARCH_OPERTNDE_ONE", EgovDateUtil.convertDate(literature.get("SEARCH_OPERTNDE_ONE"), "yyyyMMddHHmmss", "yyyy-MM-dd", null));
				literature.put("SEARCH_OPERTNDE_TWO", EgovDateUtil.convertDate(literature.get("SEARCH_OPERTNDE_TWO"), "yyyyMMddHHmmss", "yyyy-MM-dd", null));
			}
			result.put("list", list);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f02/insertLiterature.do")
	public Map<String, Object> insertLiterature(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("param", req.getParameter("data"));
			sdbf02Service.insertLiteratureInfo(map);
			result.put("message", "저장하였습니다.");
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
