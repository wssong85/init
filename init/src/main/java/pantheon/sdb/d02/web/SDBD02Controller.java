package pantheon.sdb.d02.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.sdb.d02.service.SDBD02Service;

@Controller
public class SDBD02Controller {
	@Resource(name = "SDBD02Service")
	private SDBD02Service sdbd02Service;
	
	@RequestMapping("/sdb/d02/SDBD0201.do")
	public String SDBD0201(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		return "/pantheon/sdb/d02/SDBD0201";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/d02/selectReportDelayList.do")
	public Map<String, Object> selectReportDelayList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put(req.getParameter("type"), req.getParameter("value"));
		map.put("count", req.getParameter("count"));
		map.put("page", req.getParameter("page"));
		System.err.println(map);
		try {
			int count = sdbd02Service.selectReportDelayCount(map);
			List<Map<String, String>> list = sdbd02Service.selectReportDelayList(map);
			result.put("result", true);
			result.put("list", list);
			result.put("count", count);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
