package pantheon.iwrs.a01.web;

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

import pantheon.iwrs.a01.service.IWRA01Service;

@Controller
public class IWRA01Controller {
	@Resource(name = "IWRA01Service")
	private IWRA01Service iwra01Service;
	
	@RequestMapping("/iwrs/a01/IWRA0101.do")
	public String IWRA0101(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/iwrs/a01/IWRA0101";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/a01/selectNotification")
	public Map<String, Object> selectNotification(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			list = iwra01Service.selectNotification();
			result.put("result", true);
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "공지사항 정보를 정상적으로 가져오지 못했습니다. 관리자에게 문의하세요.");
		}
		return result;
	}
}
