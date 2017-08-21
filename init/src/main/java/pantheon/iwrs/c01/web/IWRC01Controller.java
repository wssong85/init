
package pantheon.iwrs.c01.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.iwrs.b01.service.IWRB01Service;
import pantheon.iwrs.c01.service.IWRC01Service;
import pantheon.iwrs.e01.service.IWRE01Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;

/**
 * 배송 정보 처리 컨트롤러 클래스
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
public class IWRC01Controller {
	@Resource(name = "IWRC01Service")
	private IWRC01Service iwrc01Service;
	
	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;
	
	@Resource(name = "IWRE01Service")
	private IWRE01Service iwre01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	/**
	 * 배송관리 화면 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="배송관리", order = 8030 ,gid = 110)
	@RequestMapping("/iwrs/c01/IWRC0101.do")
	public String IWRC0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
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
		request.setAttribute("ROLE", role);
		return "/pantheon/iwrs/c01/IWRC0101";
	}
	
	/**
	 * 배송 정보 select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/selectDeliveryInfo.do")
	public Map<String, Object> selectDeliveryInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, String>> list = null;
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
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
				map.put("INSTT_CODE", insttCode);
			}
			list = iwrc01Service.selectDeliveryInfo(map);
			for(Map<String, String> deli : list){
				deli.put("DLVY_RQESTDE", EgovDateUtil.convertDate(deli.get("DLVY_RQESTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm:ss", null));
				deli.put("DLVY_HOPEDE", EgovDateUtil.convertDate(deli.get("DLVY_HOPEDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				deli.put("DLVY_BGNDE", EgovDateUtil.convertDate(deli.get("DLVY_BGNDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				deli.put("DLVY_COMPTDE", EgovDateUtil.convertDate(deli.get("DLVY_COMPTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				deli.put("DLVY_CNCDE", EgovDateUtil.convertDate(deli.get("DLVY_CNCDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("result", "ok");
			result.put("list", list);
			result.put("count", list.size());
		} catch (Exception e) {
			result.put("result", "fail");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 배송요청 알림 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0102.do")
	public String popupIwrc0102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/iwrs/c01/IWRC0102";
	}
	
	/**
	 * 배송요청 알림 정보 등록
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/insertDeliveryRequestInfo.do")
	public Map<String, String> insertDeliveryRequestInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		map.put("DLVY_RQESTER_ID", request.getParameter("user_id"));
		map.put("DLVY_REQUST_COMMENT", request.getParameter("dlvy_requst_comment"));
		map.put("DLVY_REQUST_CNFIRM_AT", "N");
		map.put("USE_AT", "Y");
		map.put("USER_ID", request.getParameter("user_id"));
		map.put("PASSWORD", request.getParameter("pwd"));
		
		//사용자 체크 부분 필요, 로그인 한 사용자와 아이디 체크
		Map<String, String> result = new HashMap<String, String>();
		try{
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
				map.put("INSTT_CODE", insttCode);
			}
			if(!Util.getUserMap().get("USER_ID").equals(request.getParameter("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){
					iwrc01Service.insertDeliveryRequestInfo(map);
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 배송요청 등록 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0103.do")
	public String popupIwrc0103(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		List<Map<String, String>> insttList = new ArrayList<Map<String, String>>();
		Map<String, String> deliInfo = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
		try {
			list = iwrc01Service.selectIpType(map);
			insttList = iwrc01Service.selectInstt(map); 
			if(request.getParameter("dlvymanage_code") != null && !"".equals(request.getParameter("dlvymanage_code"))){
				deliInfo = iwrc01Service.selectDeliveryRequestInfo(map);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("INSTT_CODE", request.getParameter("INSTT_CODE"));
		request.setAttribute("DLVYREQUSTMANAGE_CODE", request.getParameter("DLVYREQUSTMANAGE_CODE"));
		request.setAttribute("ipType", list);
		request.setAttribute("insttlist", insttList);
		request.setAttribute("deliInfo", deliInfo);
		request.setAttribute("PAGE_ID", request.getParameter("PAGE_ID"));
		return "/pantheon/iwrs/c01/IWRC0103";
	}
	
	/**
	 * 배송요청 정보 등록
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/insertDeliveryCountRequestInfo.do")
	public Map<String, String> insertDeliveryCountRequestInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		try {
			JSONArray array = new JSONArray(request.getParameter("data"));
			Map<String, String> userMap = new HashMap<String, String>();
			userMap.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			userMap.put("PASSWORD", array.getJSONObject(0).getString("pass"));
			
			if(!Util.getUserMap().get("USER_ID").equals(array.getJSONObject(0).get("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(userMap);
				
				if(cnt > 0){
					Map<String, String> map = new HashMap<String, String>();
					map.put("param", request.getParameter("data"));
					
					iwrc01Service.insertDeliveryInfo(map);
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
				
		return result;
	}
	
	/**
	 * 배송요청 정보 수정
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/updateDeliveryInfo.do")
	public Map<String, String> updateDeliveryInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		try{
			JSONArray array = new JSONArray(request.getParameter("data"));
			Map<String, String> userMap = new HashMap<String, String>();
			userMap.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			userMap.put("PASSWORD", array.getJSONObject(0).getString("pass"));
			
			if(!Util.getUserMap().get("USER_ID").equals(array.getJSONObject(0).get("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(userMap);
				
				if(cnt > 0){
					Map<String, String> map = new HashMap<String, String>();
					map.put("param", request.getParameter("data"));
					
					iwrc01Service.updateDeliveryInfo(map);
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 배송요청 확인 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0104.do")
	public String popupIwrc0104(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> deliInfoMap = new HashMap<String, String>();
		map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
//		System.err.println(map);
		try {
			list = iwrc01Service.selectDeliveryIpDetailInfo(map);
			deliInfoMap = iwrc01Service.selectDeliveryRequestInfo(map);
			deliInfoMap.put("DLVY_RQESTDE", EgovDateUtil.convertDate(deliInfoMap.get("DLVY_RQESTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
		} catch (Exception e) {
			
		}
//		System.err.println(deliInfoMap);
		request.setAttribute("list", list);
		request.setAttribute("deliInfo", deliInfoMap);
		
		return "/pantheon/iwrs/c01/IWRC0104";
	}
	
	/**
	 * 배송요청 확인 처리
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/updateDeliveryConfirmInfo.do")
	public Map<String, String> updateDeliveryConfirmInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		try{
			Map<String, String> map = new HashMap<String, String>();
			map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
			map.put("DLVY_BGNDE", request.getParameter("deli_begin_date"));
			map.put("DLVY_CNFIRM_COMMENT", request.getParameter("dlvy_cnfirm_comment"));
			map.put("DLVY_CNFRMR_ID", request.getParameter("user_id"));
			map.put("USER_ID", request.getParameter("user_id"));
			map.put("PASSWORD", request.getParameter("pass"));
			
			if(!Util.getUserMap().get("USER_ID").equals(request.getParameter("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){					
					iwrc01Service.updateDeliveryConfirmInfo(map);
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 배송요청 취소 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0105.do")
	public String popupIwrc0105(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("dlvymanage_code", request.getParameter("dlvymanage_code"));
		map.put("type", request.getParameter("type"));
		map.put("layer", request.getParameter("layer"));
		
		request.setAttribute("map", map);
		
		return "/pantheon/iwrs/c01/IWRC0105";
	}
	
	/**
	 * 배숑요청 취소 처리
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/updateDeliveryCancelInfo.do")
	public Map<String, Object> updateDeliveryCancelInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Map<String, String> map = new HashMap<String, String>();
			map.put("USER_ID", request.getParameter("user_id"));
			map.put("PASSWORD", request.getParameter("pwd"));
			
			if(!Util.getUserMap().get("USER_ID").equals(request.getParameter("user_id"))){
				result.put("result", false);
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){
					map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
					map.put("DLVY_REQUST_CANCL_COMMENT", request.getParameter("dlvy_requst_comment"));
					map.put("DLVY_CANCL_COMMENT", request.getParameter("dlvy_requst_comment"));
					map.put("DLVY_REQUST_CNCLR_ID", request.getParameter("user_id"));
					map.put("DLVY_CNCLR_ID", request.getParameter("user_id"));
					map.put("USER_ID", request.getParameter("user_id"));
					map.put("type", request.getParameter("type"));
					map.put("DLVY_STTUS_CODE", "05");
					
					iwrc01Service.updateDeliveryCancelInfo(map);

					result.put("result", true);
				}else{
					result.put("result", false);
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", false);
			result.put("message", "아이디와 비밀번호가 일치하지 않습니다");
		}
		
		return result;
	}
	
	/**
	 * 사용자 확인
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/selectIdCheck.do")
	public Map<String, String> selectIdCheck(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		try{
			Map<String, String> map = new HashMap<String, String>();
			map.put("USER_ID", request.getParameter("user_id"));
			map.put("PASSWORD", request.getParameter("pwd"));
			
			if(!Util.getUserMap().get("USER_ID").equals(request.getParameter("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", "false");
			result.put("message", "아이디와 비밀번호가 일치하지 않습니다");
		}
		
		return result;
	}
	
	/**
	 * 배송요청 취소 확인 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0106.do")
	public String popupIwrc0106(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
		
		try {
			Map<String, String> info = iwrc01Service.selectCancelInfo(map);
			List<Map<String, String>> list = iwrc01Service.selectDeliveryIpDetailInfo(map);
			request.setAttribute("info", info);
			request.setAttribute("list", list);
//			System.err.println("map : " + info);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return "/pantheon/iwrs/c01/IWRC0106";
	}
	
	/**
	 * 인수 확인 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0107.do")
	public String popupIwrc0107(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> deliMap = new HashMap<String, String>();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		
		map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		try {
			list = iwrc01Service.selectDeliveryIpDetailInfo(map);
			deliMap = iwrc01Service.selectDeliveryRequestInfo(map);
			deliMap.put("DLVY_RQESTDE", EgovDateUtil.convertDate(deliMap.get("DLVY_RQESTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("deli", deliMap);
		request.setAttribute("list", list);
		
		return "/pantheon/iwrs/c01/IWRC0107";
	}
	
	/**
	 * 인수 확인시 배송된 모든 ip 정보 select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/selectIpErroInfo.do")
	public Map<String, Object> selectIpErroInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("DLVYMANAGE_CODE", request.getParameter("dlvymanage_code"));
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			list = iwrc01Service.selectIpErroInfo(map);
			result.put("result", "ok");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "fail");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 인수 확인 처리
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/c01/updateIpInsuInfo.do")
	public Map<String, String> updateIpInsuInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> result = new HashMap<String, String>();
		try {
			JSONArray array = new JSONArray(request.getParameter("data"));
			Map<String, String> userMap = new HashMap<String, String>();
			userMap.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			userMap.put("PASSWORD", array.getJSONObject(0).getString("pass"));
			
			if(!Util.getUserMap().get("USER_ID").equals(array.getJSONObject(0).get("user_id"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(userMap);
				
				if(cnt > 0){
					map.put("data", request.getParameter("data"));
					
					iwrc01Service.updateIpInsuInfo(map);
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * ip수불 팝업 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/iwrs/c01/popupIwrc0110.do")
	public String popupIwrc0110(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, String>> siteType = new ArrayList<Map<String, String>>();
		List<Map<String, String>> subjectType = new ArrayList<Map<String, String>>();
		List<Map<String, String>> ipType = new ArrayList<Map<String, String>>();
		map.put("CMMN_CLCODE", "IWRS010");
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			ipType = iwrc01Service.selectGroupInfo(map);
			siteType = iwrc01Service.selectInstt(map);
			subjectType = iwre01Service.selectSubjectList(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("ipType", ipType);
		request.setAttribute("siteType", siteType);
		request.setAttribute("subjectType", subjectType);
		return "/pantheon/iwrs/c01/IWRC0110";
	}
	
	@RequestMapping("/iwrs/c01/popupIwrc0113.do")
	public String popupIwrc0113(HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("DLVYMANAGE_CODE", request.getParameter("DLVYMANAGE_CODE"));
		request.setAttribute("IP_TYPE", request.getParameter("IP_TYPE"));
		return "/pantheon/iwrs/c01/IWRC0113";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/c01/selectDeliveryIpCode.do")
	public Map<String, Object> selectDeliveryIpCode(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("DLVYMANAGE_CODE", request.getParameter("DLVYMANAGE_CODE"));
			map.put("IP_TYPE", request.getParameter("IP_TYPE"));
//			System.err.println(map);
			List<Map<String, String>> list = iwrc01Service.selectDeliveryIpCode(map);
			result.put("result", true);
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
