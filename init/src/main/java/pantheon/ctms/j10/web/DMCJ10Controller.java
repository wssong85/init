package pantheon.ctms.j10.web;

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
import pantheon.ctms.j10.service.DMCJ10Service;


@Controller
public class DMCJ10Controller {
	
	@Resource(name="DMCJ10Service")
	private DMCJ10Service DMCJ10Service;
	
	
	/**
	 * 계약 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j10/DMCJ1001.do")
	public String DMCJ1001(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j10/DMCJ1001";
	}
	/**
	 * 계약 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j10/selectContractList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectContractList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("map=========================="+map);
		List<Map<String, Object>> list = null;		
		List<Map<String, Object>> irbList = null;
		List<Map<String, Object>> cntrctSe = null;
		List<Map<String, Object>> sttus = null;
		try {
			list = DMCJ10Service.selectContractList(map);
			irbList = DMCJ10Service.selectCommonCodeListByIRB_AT(map);
			cntrctSe = DMCJ10Service.selectCommonCodeListByCNTRCT_SE(map);
			sttus = DMCJ10Service.selectCommonCodeListBySTTUS(map);
			result.put("success", true);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("irbList", irbList);	
			result.put("cntrctSe", cntrctSe);	
			result.put("sttus", sttus);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
}
