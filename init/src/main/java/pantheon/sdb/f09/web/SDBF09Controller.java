package pantheon.sdb.f09.web;

import java.util.ArrayList;
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
import pantheon.sdb.f09.service.SDBF09Service;

@Controller
public class SDBF09Controller {
	@Resource(name = "SDBF09Service")
	private SDBF09Service sdbf09Service;
	
	@RequestMapping("/sdb/f09/SDBF0901.do")
	public String SDBF0901(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> param = new HashMap<String, String>();
		param.put("SE_CODE", "03");
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			list = sdbf09Service.selectSopPart(param);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		req.setAttribute("part", list);
		
		return "pantheon/sdb/f09/SDBF0901";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f09/selectSopInfo")
	public Map<String, Object> selectSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("SE_CODE", "03");
		param.put("UPPER_SN", req.getParameter("UPPER_SN"));
		
		try {
			List<Map<String, String>> list = sdbf09Service.selectSopInfo(param);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f09/insertSopInfo")
	public Map<String, Object> insertSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("data", req.getParameter("data"));
		try {
			sdbf09Service.insertSopInfo(param);
			result.put("result", "true");
			result.put("message", "등록하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
		
	@ResponseBody
	@RequestMapping("/sdb/f09/deleteSopInfo.do")
	public Map<String, String> deleteSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("data", req.getParameter("data"));
		try {
			sdbf09Service.deleteSopInfo(param);
			result.put("result", "true");
			result.put("message", "삭제되었습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}