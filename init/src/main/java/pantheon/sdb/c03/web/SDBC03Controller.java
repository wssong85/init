package pantheon.sdb.c03.web;

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
import pantheon.sdb.c03.service.SDBC03Service;

@Controller
public class SDBC03Controller {
	@Resource(name = "SDBC03Service")
	private SDBC03Service sdbc03Service;
	
	@RequestMapping("/sdb/c03/SDBC0301.do")
	public String SDBC0301(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/c03/SDBC0301";
	}
	
	@RequestMapping("/sdb/c03/SDBC0303.do")
	public String SDBC0303(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/c03/SDBC0303";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/c03/selectUploadHistory.do")
	public Map<String, Object> selectUploadHistory(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
		try {
			map.put("LOCALE", Util.getStrLocale());
			List<Map<String, String>> list = sdbc03Service.selectUploadHistory(map);
			result.put("result", true);
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "history 정보를 가져오지 못하였습니다.");
		}
		return result;
	}
}
