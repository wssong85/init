package pantheon.ctms.i01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.a01.service.CTMA01Service;
import pantheon.ctms.i01.service.CTMI01Service;



@Controller
public class CTMI01Controller {

	@Resource(name="CTMI01Service")
	private CTMI01Service ctmi01Service;

	@Resource(name="CTMA01Service")
	private CTMA01Service ctma01Service;

	/**
	 * 공지사항 HOME
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/i01/CTMI0101.do")
	public String CTMI0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		return "/pantheon/ctms/i01/CTMI0101";		
	}
	
	/**
	 * 교육 정보 상세 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/i01/selectCalMilestoneList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCalMilestoneList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> calList  = null;
		List<Map<String, Object>> jobList  = null;

		try {
			calList = ctmi01Service.selectCalMilestoneList(map);
			jobList = ctma01Service.selectNotifyCtmsList(map);
			result.put("success", true   );
			result.put("calList", calList);
			result.put("jobList", jobList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
}
