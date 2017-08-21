package pantheon.iwrs.e01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.iwrs.b01.service.IWRB01Service;
import pantheon.iwrs.c01.service.IWRC01Service;
import pantheon.iwrs.e01.service.IWRE01Service;
import egovframework.com.utl.fcc.service.EgovDateUtil;

@Controller
public class IWRE01Controller {
	@Resource(name = "IWRE01Service")
	private IWRE01Service iwre01Service;
	
	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "IWRC01Service")
	private IWRC01Service iwrc01Service;
	
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;
	
	@RequestMapping("/iwrs/e01/IWRE0101.do")
	public String IWRE0101(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
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
			List<Map<String, String>> list = iwre01Service.selectVisitLabel(map);
			req.setAttribute("list", list);
			req.setAttribute("ROLE", role);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pantheon/iwrs/e01/IWRE0101";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/selectDispenseList.do")
	public Map<String, Object> selectDispenseList(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		try {
			List<Map<String, String>> list = iwre01Service.selectDispenseList(map);
			result.put("list", list);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping("/iwrs/e01/IWRE0102.do")
	public String IWRE0102(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
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
			List<Map<String, String>> list = iwre01Service.selectSubjectList(map);
			List<Map<String, String>> visit = iwre01Service.selectVisitLabel(map);
			
			req.setAttribute("visit", visit);
			req.setAttribute("list", list);
			req.setAttribute("ROLE", role);
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.setAttribute("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		return "/pantheon/iwrs/e01/IWRE0102";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/selectDispenseListForSubject.do")
	public Map<String, Object> selectDispenseListForSubject(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", Util.getUserMap().get("TASK_SN"));
		map.put("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
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
			List<Map<String, String>> listList = iwre01Service.selectDispenseListForSubject(map);
			List<Map<String, String>> viewList = iwre01Service.selectDispenseForView(map);
			for(Map<String, String> dispenseMap : listList){
				dispenseMap.put("RTUN_DT", EgovDateUtil.convertDate(dispenseMap.get("RTUN_DT"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				dispenseMap.put("RTURN_DT", EgovDateUtil.convertDate(dispenseMap.get("RTURN_DT"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("list", listList);
			result.put("view", viewList);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping("/iwrs/e01/IWRE0103.do")
	public String IWRE0103(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		req.setAttribute("VISIT_CODE", req.getParameter("VISIT_CODE"));
		req.setAttribute("VISIT_LBL", req.getParameter("VISIT_LBL"));
		req.setAttribute("TASK_CODE", req.getParameter("TASK_CODE"));
		return "/pantheon/iwrs/e01/IWRE0103";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/selectDispenseReturnInfo")
	public Map<String, Object> selectDispenseReturnInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_CODE", req.getParameter("TASK_CODE"));
		map.put("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		map.put("VISIT_CODE", req.getParameter("VISIT_CODE"));
		try {
			List<Map<String, String>> list = iwre01Service.selectDispenseReturnInfo(map);
			List<Map<String, String>> queryList = iwre01Service.selectQueryInfo(map);
			for(Map<String, String> dispenseMap : list){
				dispenseMap.put("RTUN_DT", EgovDateUtil.convertDate(dispenseMap.get("RTUN_DT"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				dispenseMap.put("RTURN_DT", EgovDateUtil.convertDate(dispenseMap.get("RTURN_DT"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				dispenseMap.put("IPASIGN_DE", EgovDateUtil.convertDate(dispenseMap.get("IPASIGN_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("list", list);
			result.put("queryList", queryList);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/updateDispenseInfo.do")
	public Map<String, Object> updateDispenseInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("param", req.getParameter("data"));
			iwre01Service.updateDispenseInfo(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/e01/IWRE0104.do")
	public String IWRE0104(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		req.setAttribute("VISIT_CODE", req.getParameter("VISIT_CODE"));
		req.setAttribute("VISIT_LBL", req.getParameter("VISIT_LBL"));
		req.setAttribute("TASK_CODE", req.getParameter("TASK_CODE"));
		return "/pantheon/iwrs/e01/IWRE0104";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/updateReturnInfo.do")
	public Map<String, Object> updateReturnInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("param", req.getParameter("data"));
			iwre01Service.updateReturnInfo(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/e01/IWRE0105.do")
	public String IWRE0105(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		req.setAttribute("VISIT_CODE", req.getParameter("VISIT_CODE"));
		req.setAttribute("VISIT_LBL", req.getParameter("VISIT_LBL"));
		req.setAttribute("TASK_CODE", req.getParameter("TASK_CODE"));
		return "/pantheon/iwrs/e01/IWRE0105";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/updateConfirmInfo.do")
	public Map<String, Object> updateConfirmInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("param", req.getParameter("data"));
			iwre01Service.updateConfirmInfo(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/e01/popupIwre0106.do")
	public String popupIwre0106(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
		req.setAttribute("VISIT_CODE", req.getParameter("VISIT_CODE"));
		req.setAttribute("VISIT_LBL", req.getParameter("VISIT_LBL"));
		req.setAttribute("TASK_CODE", req.getParameter("TASK_CODE"));
		req.setAttribute("IPASIGN_DE", req.getParameter("IPASIGN_DE"));
		req.setAttribute("RTUN_NO", req.getParameter("RTUN_NO"));
		req.setAttribute("IP_CODE", req.getParameter("IP_CODE"));
		req.setAttribute("DLVYMANAGE_CODE", req.getParameter("DLVYMANAGE_CODE"));
		req.setAttribute("SN", req.getParameter("SN"));
		req.setAttribute("INVNTRYMANAGE_CODE", req.getParameter("INVNTRYMANAGE_CODE"));
		return "/pantheon/iwrs/e01/IWRE0106";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/updateErrorInfo.do")
	public Map<String, Object> updateErrorInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("USER_ID", req.getParameter("USER_ID"));
			map.put("PASSWORD", req.getParameter("PWD"));
			map.put("IP_STTUS_CODE", "06");
			map.put("RTUN_NO", req.getParameter("RTUN_NO"));
			map.put("IP_CODE", req.getParameter("IP_CODE"));
			map.put("DLVYMANAGE_CODE", req.getParameter("DLVYMANAGE_CODE"));
			map.put("SN", req.getParameter("SN"));
			map.put("INVNTRYMANAGE_CODE", req.getParameter("INVNTRYMANAGE_CODE"));
			map.put("SUBJECT_CODE", req.getParameter("SUBJECT_CODE"));
			map.put("VISIT_CODE", req.getParameter("VISIT_CODE"));
			map.put("IP_ERROR_COMMENT", req.getParameter("IP_ERROR_COMMENT"));
			map.put("IP_ERROR_CODE", req.getParameter("IP_ERROR_CODE"));
			map.put("IP_ERROR_REGISTER_ID", req.getParameter("USER_ID"));
			if(!Util.getUserMap().get("USER_ID").equals(map.get("USER_ID"))){
				result.put("result", false);
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){
					iwre01Service.updateErrorInfo(map);
					result.put("message", "저장하였습니다.");
					result.put("result", true);
				}else{
					result.put("result", false);
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("result", false);
		}
		return result;
	}
	
	@RequestMapping("/iwrs/e01/popupIwre0107.do")
	public String popupIwre0107(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("CMMN_CLCODE", req.getParameter("queryItemType"));
		try {
			List<Map<String, Object>> queryItem = comd01Service.selectCmCmmnCodeListByPk(map);
			req.setAttribute("item", queryItem);
			req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/pantheon/iwrs/e01/IWRE0107";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/insertQuery.do")
	public Map<String, Object> insertQuery(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("RTUN_NO", req.getParameter("RTUN_NO"));
		map.put("DLVY_SE_CODE", req.getParameter("DLVY_SE_CODE"));
		map.put("QUERY_SE_CODE", req.getParameter("QUERY_SE_CODE"));
		map.put("MODULE_CODE", req.getParameter("MODULE_CODE"));
		map.put("QUERY_TY_CODE", req.getParameter("QUERY_TY_CODE"));
		map.put("QUERY_STTUS_CODE", req.getParameter("QUERY_STTUS_CODE"));
		map.put("QUERY_CN", req.getParameter("QUERY_CN"));
		map.put("RESN", req.getParameter("RESN"));
		map.put("END_AT", req.getParameter("END_AT"));
		map.put("USE_AT", req.getParameter("USE_AT"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		
		try {
			iwre01Service.insertQuery(map);
			result.put("result", true);
			result.put("message", "쿼리를 등록하였습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "쿼리 등록중 오래가 발생하였습니다.");
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/e01/popupIwre0108.do")
	public String popupIwre0108(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		req.setAttribute("QUERY_GROUP", req.getParameter("QUERY_GROUP"));
		req.setAttribute("QUERY_CN", req.getParameter("QUERY_CN"));
		req.setAttribute("RTUN_NO", req.getParameter("RTUN_NO"));
		req.setAttribute("DLVY_SE_CODE", req.getParameter("DLVY_SE_CODE"));
		req.setAttribute("QUERY_SE_CODE", req.getParameter("QUERY_SE_CODE"));
		return "/pantheon/iwrs/e01/IWRE0108";
	}
	
	@RequestMapping("/iwrs/e01/popupIwre0109.do")
	public String popupIwre0109(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC053");
		req.setAttribute("EDC053", pantheonCommonService.selectQueryDataList2(map));
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		req.setAttribute("QUERY_GROUP", req.getParameter("QUERY_GROUP"));
		req.setAttribute("QUERY_CN", req.getParameter("QUERY_CN"));
		req.setAttribute("RTUN_NO", req.getParameter("RTUN_NO"));
		req.setAttribute("DLVY_SE_CODE", req.getParameter("DLVY_SE_CODE"));
		req.setAttribute("QUERY_SE_CODE", req.getParameter("QUERY_SE_CODE"));
		return "/pantheon/iwrs/e01/IWRE0109";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/insertEndQueryInfo.do")
	public Map<String, Object> insertEndQueryInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("END_AT", req.getParameter("END_AT"));
		map.put("RESN", req.getParameter("RESN"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		map.put("QUERY_GROUP", req.getParameter("QUERY_GROUP"));
		map.put("QUERY_CN", req.getParameter("QUERY_CN"));
		map.put("RTUN_NO", req.getParameter("RTUN_NO"));
		map.put("DLVY_SE_CODE", req.getParameter("DLVY_SE_CODE"));
		map.put("QUERY_SE_CODE", req.getParameter("QUERY_SE_CODE"));
		map.put("MODULE_CODE", req.getParameter("MODULE_CODE"));
		map.put("QUERY_TY_CODE", req.getParameter("QUERY_TY_CODE"));
		map.put("QUERY_STTUS_CODE", req.getParameter("QUERY_STTUS_CODE"));
		map.put("QUERY_END_TYPE", req.getParameter("QUERY_END_TYPE"));
		map.put("USE_AT", req.getParameter("USE_AT"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		
		try{
			iwre01Service.insertEndQueryInfo(map);
			result.put("result", true);
			result.put("message", "쿼리를 정상적으로 종료하였습니다.");
		} catch(Exception e){
			result.put("result", false);
			result.put("message", "쿼리를 종료중 오류가 발생하였습니다.\r\n다시 한번 시도하시고, 같은 증상이 발생시 운영자에게 문의하십시오.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/e01/insertAnswerQueryInfo.do")
	public Map<String, Object> insertAnswerQueryInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("END_AT", req.getParameter("END_AT"));
		map.put("RESN", req.getParameter("RESN"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		map.put("QUERY_GROUP", req.getParameter("QUERY_GROUP"));
		map.put("QUERY_CN", req.getParameter("QUERY_CN"));
		map.put("RTUN_NO", req.getParameter("RTUN_NO"));
		map.put("DLVY_SE_CODE", req.getParameter("DLVY_SE_CODE"));
		map.put("QUERY_SE_CODE", req.getParameter("QUERY_SE_CODE"));
		map.put("MODULE_CODE", req.getParameter("MODULE_CODE"));
		map.put("QUERY_TY_CODE", req.getParameter("QUERY_TY_CODE"));
		map.put("QUERY_STTUS_CODE", req.getParameter("QUERY_STTUS_CODE"));
		map.put("USE_AT", req.getParameter("USE_AT"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		
		try{
			iwre01Service.insertAnswerQueryInfo(map);
			result.put("result", true);
			result.put("message", "쿼리를 정상적으로 응답하였습니다.");
		} catch(Exception e){
			result.put("result", false);
			result.put("message", "쿼리를 응답중 오류가 발생하였습니다.\r\n다시 한번 시도하시고, 같은 증상이 발생시 운영자에게 문의하십시오.");
		}
		return result;
	}
}
