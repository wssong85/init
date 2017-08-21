package pantheon.sdb.f08.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.sdb.f08.service.SDBF08Service;

@Controller
public class SDBF08Controller {
	@Resource(name = "SDBF08Service")
	private SDBF08Service sdbf08Service;
	
	@RequestMapping("/sdb/f08/SDBF0801.do")
	public String SDBF0701(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		return "/pantheon/sdb/f08/SDBF0801";
	}
	
	@RequestMapping("/sdb/f08/selectReconciliationList.do")	
	public @ResponseBody Map<String, Object> selectReconciliationList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			param.put("ORGAN_DATE", param.get("ORGAN_DATE").replace("-",""));
			param.put("ORGAN_DATE_END", param.get("ORGAN_DATE_END").replace("-",""));
			list= sdbf08Service.selectReconciliationList(param);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("sucess", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
