package pantheon.ctms.j05.web;

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
import pantheon.ctms.j05.service.DMCJ05Service;


@Controller
public class DMCJ05Controller {
	
	@Resource(name="DMCJ05Service")
	private DMCJ05Service DMCJ05Service;
	
	
	/**
	 * 기관정보 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	//@IncludedInfo(name="Protocol 리스트 화면", order = 7020 ,gid = 110)
	@RequestMapping(value="/ctms/j05/DMCJ0501.do")
	public String DMCJ0501(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j05/DMCJ0501";
	}
	/**
	 * 기관정보 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j05/selectInstitutionInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectInstitutionInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("map=========================="+map);
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> instt_ty = null;	
		
		try {
			list = DMCJ05Service.selectInstitutionInfo(map);
			instt_ty = DMCJ05Service.selectInstt_tyByCommonCode(map);
			result.put("success", true);
			//result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("instt_ty", instt_ty);	
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
}
