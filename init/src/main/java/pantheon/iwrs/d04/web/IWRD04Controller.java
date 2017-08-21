package pantheon.iwrs.d04.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.iwrs.b01.service.IWRB01Service;
import pantheon.iwrs.c01.service.IWRC01Service;
import pantheon.iwrs.d04.service.IWRD04Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;

/**
 * 공장 IP 재고 처리 컨트롤러 클래스
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
public class IWRD04Controller {
	@Resource(name = "IWRD04Service")
	private IWRD04Service iwrd04Service;
	
	@Resource(name = "IWRC01Service")
	private IWRC01Service iwrc01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;
	
	/**
	 * 공장재고 현황 페이지 오픈
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="공장재고현황", order = 8080 ,gid = 110)
	@RequestMapping("/iwrs/d04/IWRD0401.do")
	public String IWRD0401(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		map.put("type", "1");
		map.put("CMMN_CLCODE", "IWRS005");
		try {
			List<Map<String, String>> ipType = iwrc01Service.selectGroupInfo(map);
			List<Map<String, Object>> ipStatus = comd01Service.selectCmCmmnCodeListByPk(map);
			request.setAttribute("iptype", ipType);
			request.setAttribute("ipstatus", ipStatus);
		} catch (Exception e) {
			System.err.println(e.getLocalizedMessage());
			e.printStackTrace();
		}
		return "/pantheon/iwrs/d04/IWRD0401";
	}
	
	/**
	 * IP 현황 정보 select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/d04/selectFactoryInventoryInfo.do")
	public Map<String, Object> selectFactoryInventoryInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		map.put("IP_TYPE", request.getParameter("IP_TYPE"));
		map.put("IP_STTUS_CODE", request.getParameter("IP_STTUS_CODE"));
		try{
			List<Map<String, String>> list = iwrd04Service.selectFactoryInventoryInfo(map);
			int totalCount = iwrd04Service.selectFactoryInvntoryTotalCount(map);
			int count = iwrd04Service.selectFactoryInventoryCount(map);
			for(Map<String, String> inven : list){
				inven.put("DLVY_RQESTDE", EgovDateUtil.convertDate(inven.get("DLVY_RQESTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("result", "ok");
			result.put("list", list);
			result.put("totalcount", totalCount);
			result.put("count", count);
		}catch(Exception ex){
			result.put("result", "fail");
			result.put("message", ex.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * IP 상태 등록 팝업 오픈
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/d04/popupIwrd0402.do")
	public String popupIwrd0402(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String ip_code = request.getParameter("ip_code");
		String ip_type = request.getParameter("ip_type");
		String create_code = request.getParameter("create_code");
		request.setAttribute("ip_code", ip_code);
		request.setAttribute("ip_type", ip_type);
		request.setAttribute("creat_code", create_code);
		return "/pantheon/iwrs/d04/IWRD0402";
	}
	
	/**
	 * IP 상태 정보 변경
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/d04/updateIpStatus.do")
	public Map<String, Object> updateIpStatus(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		
		String ip_code = request.getParameter("ip_code");
		String ip_type = request.getParameter("ip_type");
		String creat_code = request.getParameter("creat_code");
		String ip_sttus_code = request.getParameter("ip_sttus_code");
		String ip_error_code = request.getParameter("ip_error_code");
		String ip_error_comment = request.getParameter("ip_error_comment");
		String ip_etc = request.getParameter("ip_etc");
		String user_id = request.getParameter("user_id");
		String password = request.getParameter("password");
		
		map.put("IP_CODE", ip_code);
		map.put("IP_TYPE", ip_type);
		map.put("CREAT_CODE", creat_code);
		map.put("IP_STTUS_CODE", ip_sttus_code);
		map.put("IP_ERROR_CODE", ip_error_code);
		map.put("IP_ERROR_COMMENT", ip_error_comment);
		map.put("IP_ETC", ip_etc);
		map.put("USER_ID", user_id);
		map.put("PASSWORD", password);
		
		try{
			if(!Util.getUserMap().get("USER_ID").equals(request.getParameter("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){					
					iwrd04Service.updateIpStatus(map);
					result.put("result", true);
					result.put("message", "저장하였습니다.");
				}else{
					result.put("result", false);
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception ex){
			result.put("result", false);
			result.put("message", "IP상태 등록중 오류가 발생하였습니다. 관리자에게 문의하십시오.");
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/d04/IWRD0403.do")
	public String IWRD0403(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/iwrs/d04/IWRD0403";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/d04/selectFactoryInventorySummary.do")
	public Map<String, Object> selectFactoryInventorySummary(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
			List<Map<String, String>> list = iwrd04Service.selectFactoryInventorySummary(map);
			result.put("result", true);
			result.put("list", list);
		}catch(Exception ex){
			result.put("result", false);
			result.put("message", "공장재고 Summary 정보를 가져오는 중 오류가 발생하였습니다. 관리자에게 문의하십시오.");
		}
		
		return result;
	}
}
