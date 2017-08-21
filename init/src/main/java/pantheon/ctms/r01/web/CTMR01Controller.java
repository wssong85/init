package pantheon.ctms.r01.web;

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
import pantheon.ctms.r01.service.CTMR01Service;

@Controller
public class CTMR01Controller {
	
	@Resource(name="CTMR01Service")
	private CTMR01Service ctmr01Service;

	/**
	 * Protocol 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/r01/CTMR0101.do")
	public String ctmr0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/r01/CTMR0101";
	}
	/**
	 * Protocol 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/r01/selectProtocolList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectProtocolList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		

		try {
			list = ctmr01Service.selectProtocolList(map);
			
			for(Map<String, Object> deli : list){				
				deli.put("CONFMDE", EgovDateUtil.convertDate((String) deli.get("CONFMDE"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
				deli.put("FRMLA_OFFIC_PRESENTNDE", EgovDateUtil.convertDate((String) deli.get("FRMLA_OFFIC_PRESENTNDE"), "yyyyMMddHHmmss", "yyyy-MM-dd",null));
			}
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	/**
	 * Protocol 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/r01/insertProtocolList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertProtocolList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			ctmr01Service.insertProtocolList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
