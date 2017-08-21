package pantheon.iwrs.f01.web;

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
import pantheon.iwrs.e01.service.IWRE01Service;
import pantheon.iwrs.f01.service.IWRF01Service;

@Controller
public class IWRF01Controller {
	@Resource(name = "IWRF01Service")
	private IWRF01Service iwrf01Service;
	
	@Resource(name = "IWRE01Service")
	private IWRE01Service iwre01Service;
	
	@RequestMapping("/iwrs/f01/IWRF0101.do")
	public String IWRF0101(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/iwrs/f01/IWRF0101";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/f01/selectQueryList.do")
	public Map<String, Object> selectQueryList(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		try {
			List<Map<String, String>> list = iwrf01Service.selectQueryList(map);
			result.put("list", list);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "Query 정보를 정상적으로 가져오지 못했습니다. 운영자에게 연락하세요.");
		}
		return result;
	}
	
	@RequestMapping("/iwrs/f01/popupIwrf0102.do")
	public String popupIwrf0102(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		req.setAttribute("QUERY_NO", req.getParameter("QUERY_NO"));
		return "/pantheon/iwrs/f01/IWRF0102";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/f01/updateQueryEndInfo.do")
	public Map<String, Object> updateQueryEndInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("QUERY_NO", req.getParameter("QUERY_NO"));
		map.put("QUERY_STTUS_CODE", req.getParameter("QUERY_STTUS_CODE"));
		map.put("RESN", req.getParameter("RESN"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		try {
			iwre01Service.updateEndQuery(map);
			result.put("result", true);
			result.put("message", "Query 정상적으로 종료 되었습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "Query 정보를 종료하지 못했습니다. 운영자에게 연락하세요.");
		}
		return result;
	}
}
