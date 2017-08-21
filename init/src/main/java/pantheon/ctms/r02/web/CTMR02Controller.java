package pantheon.ctms.r02.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;








import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.utl.Util;
import pantheon.ctms.r02.service.CTMR02Service;

@Controller
public class CTMR02Controller {
	
	@Resource(name="CTMR02Service")
	private CTMR02Service ctmr02Service;

	/**
	 * Pms 연차보고서 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="Pms 연차보고서 화면", order = 7030 ,gid = 110)
	@RequestMapping(value="/ctms/r02/CTMR0201.do")
	public String ctmr0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/r02/CTMR0201";
	}
	
	/**
	 * Pms 연차보고서 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/r02/selectAnnualReportList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectAnnualReportList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		

		try {
			list = ctmr02Service.selectAnnualReportList(map);	
			
			for(Map<String, Object> deli : list){				
				deli.put("PERIOD_FROM", EgovDateUtil.convertDate((String) deli.get("PERIOD_FROM"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
				deli.put("PERIOD_TO", EgovDateUtil.convertDate((String) deli.get("PERIOD_TO"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
				deli.put("FDRMREPORT_PRESENTNDE", EgovDateUtil.convertDate((String) deli.get("FDRMREPORT_PRESENTNDE"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
				deli.put("EXAMINPD_FROM", EgovDateUtil.convertDate((String) deli.get("EXAMINPD_FROM"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
				deli.put("EXAMINPD_TO", EgovDateUtil.convertDate((String) deli.get("EXAMINPD_TO"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
			}
			
			result.put("success", true);
			result.put("result", list);		
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * Pms 연차보고서 데이터  저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/r02/insertAnnualReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertAnnualReport(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			ctmr02Service.insertAnnualReport(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
