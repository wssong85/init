package pantheon.iwrs.d02.web;

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
import pantheon.iwrs.d02.service.IWRD02Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;

/**
 * IP 현황(약국) 처리 컨트롤러 클래스
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
public class IWRD02Controller {
	@Resource(name = "IWRD02Service")
	private IWRD02Service iwrd02Service;
	
	@Resource(name = "IWRC01Service")
	private IWRC01Service iwrc01Service;
	
	/**
	 * ip현황(약국) 페이지 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="IP현황(약국)", order = 8060 ,gid = 110)
	@RequestMapping("/iwrs/d02/IWRD0201.do")
	public String IWRD0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		try {
			String strAuth = Util.getAuthorities();
			String str[] = strAuth.split(",");
			String role = "";
			String insttCode = "";
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
				insttCode = iwrc01Service.selectUserInsttCode(insttMap);
				map.put("INSTT_CODE", insttCode);
			}
			List<Map<String, String>> insttList = iwrc01Service.selectInstt(map);
			request.setAttribute("insttlist", insttList);
			request.setAttribute("role", role);
			request.setAttribute("insttcode", insttCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/pantheon/iwrs/d02/IWRD0201";
	}
	
	/**
	 * ip현황(약국) 데이터 조회
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/d02/selectDrugStock")
	public Map<String, Object> selectDrugStock(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		map.put("instt_code", request.getParameter("instt_code"));
		try{
			List<Map<String, String>> list = iwrd02Service.selectDrugStock(map);
			for(Map<String, String> drug : list){
				drug.put("WRHOUSNGDE", EgovDateUtil.convertDate( drug.get("WRHOUSNGDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				drug.put("VALIDPD", EgovDateUtil.convertDate( drug.get("VALIDPD"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("result", true);
			result.put("list", list);
		}catch(Exception ex){
			result.put("result", false);
			result.put("message", ex.getLocalizedMessage());
		}
		
		return result;
	}
}
