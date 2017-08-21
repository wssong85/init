package pantheon.iwrs.c02.web;

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
import pantheon.iwrs.c01.service.IWRC01Service;
import pantheon.iwrs.c02.service.IWRC02Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * 배송요청알림 처리 컨트롤러 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
@Controller
public class IWRC02Controller {
	@Resource(name = "IWRC02Service")
	private IWRC02Service iwrc02Service;
	
	@Resource(name = "IWRC01Service")
	private IWRC01Service iwrc01Service;
	
	/**
	 * 배송요청 알림 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="배송요청관리", order = 8040 ,gid = 110)
	@RequestMapping("/iwrs/c02/IWRC0201.do")
	public String IWRC0201(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		String role = "";
		try {
			String strAuth = Util.getAuthorities();
			String str[] = strAuth.split(",");
			if(strAuth.contains("ROLE_PHARM")){
				role = "PHARM";
			}else if(strAuth.contains("ROLE_IPM")){
				role = "IPM";
			}else if(strAuth.contains("ROLE_CRA")){
				role = "CRA";
			}else if(strAuth.contains("ROLE_CRM")){
				role = "CRM";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		req.setAttribute("ROLE", role);
		return "/pantheon/iwrs/c02/IWRC0201";
	}
	
	/**
	 * 배송요청 알림 정보 select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c02/selectRequestInfo.do")
	public Map<String, Object> selectRequestInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String strAuth = Util.getAuthorities();
			String str[] = strAuth.split(",");
			String role = "";
			if(strAuth.contains("ROLE_PHARM")){
				role = "PHARM";
			}else if(strAuth.contains("ROLE_IPM")){
				role = "IPM";
			}else if(strAuth.contains("ROLE_CRA")){
				role = "CRA";
			}else if(strAuth.contains("ROLE_CRM")){
				role = "CRM";
			}
			if("PHARM".equals(role)){
				Map<String, String> insttMap = new HashMap<String, String>();
				insttMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
				String insttCode = iwrc01Service.selectUserInsttCode(insttMap);
				map.put("instt_code", insttCode);
			}
			list = iwrc02Service.selectRequestInfo(map);
			result.put("list", list);
			result.put("result", "true");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/c02/updateRequestInfo.do")
	public Map<String, Object> updateRequestInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> param = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			param.put("DLVYREQUSTMANAGE_CODE", req.getParameter("DLVYREQUSTMANAGE_CODE"));
			param.put("INSTT_CODE", req.getParameter("INSTT_CODE"));
			param.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
			param.put("DLVY_REQUST_CNFIRM_AT", "Y");
			param.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iwrc02Service.updateRequestInfo(param);
			result.put("result", true);
			result.put("messaage", "등록하였습니다.");
		}catch(Exception e){
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
