package pantheon.iwrs.g01.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.iwrs.g01.service.IWRG01Service;

@Controller
public class IWRG01Controller {
	private static final Logger LOGGER = LoggerFactory.getLogger(IWRG01Controller.class);
	
	@Resource(name = "IWRG01Service")
	private IWRG01Service iwrg01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@RequestMapping("/iwrs/g01/IWRG0101.do")
	public String IWRG0101(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/iwrs/g01/IWRG0101";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/selectTaskList.do")
	public Map<String, Object> selectTaskList(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try{
			map.put("TASK_NO", req.getParameter("TASK_NO"));
			map.put("TASK_NM", req.getParameter("TASK_NM"));
			List<Map<String, String>> list = iwrg01Service.selectTaskList(map);
			for(Map<String, String> task : list){
				task.put("APPLC_DE", EgovDateUtil.convertDate(task.get("APPLC_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("result", true);
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/iwrs/g01/IWRG0102.do")
	public String IWRG0102(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("TASK_SN", req.getParameter("TASK_SN"));
		req.setAttribute("TASK_NM", req.getParameter("TASK_NM"));
		return "/pantheon/iwrs/g01/IWRG0102";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/selectIwrsDesignList.do")
	public Map<String, Object> selectIwrsDesignList(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			List<Map<String, String>> list = iwrg01Service.selectIwrsDesignList(map);
			for(Map<String, String> task : list){
				task.put("APPLC_DE", EgovDateUtil.convertDate(task.get("APPLC_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				task.put("LAST_UPDDE", EgovDateUtil.convertDate(task.get("LAST_UPDDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("result", true);
			result.put("list", list);
		}catch(Exception e){
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping("/iwrs/g01/popupIWRG0103.do")
	public String popupIWRG0103(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		try {
			map.put("CMMN_CLCODE", "IWRS015");
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
			req.setAttribute("IWRS_VER", iwrg01Service.selectIwrsDesignerInfo(map));
			req.setAttribute("IWRS015", comd01Service.selectCmCmmnCodeListByPk(map));
			req.setAttribute("TASK_SN", req.getParameter("TASK_SN"));
		} catch (Exception e) {
			LOGGER.error("IWRG01Controller", e);
			throw e;
		}
		return "/pantheon/iwrs/g01/IWRG0103";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertIwrsDesignerInfo.do")
	public Map<String, Object> insertIwrsDesignerInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			map.put("IWRS_VER", req.getParameter("IWRS_VER"));
			map.put("PROGRS_CODE", req.getParameter("PROGRS_CODE"));
			map.put("CHANGE_RESN", req.getParameter("CHANGE_RESN"));
			map.put("APPLC_CODE", req.getParameter("APPLC_CODE"));
			map.put("APPLC_DE", req.getParameter("APPLC_DE"));
			map.put("USE_AT", req.getParameter("USE_AT"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iwrg01Service.insertIwrsDesignerInfo(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch (Exception e){
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping("/iwrs/g01/IWRG0104.do")
	public String IWRG0104(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		try{
			req.setAttribute("TASK_SN", req.getParameter("TASK_SN"));
			req.setAttribute("IWRS_VER", req.getParameter("IWRS_VER"));
			req.setAttribute("TASK_NM", req.getParameter("TASK_NM"));
		}catch(Exception e){
			LOGGER.error("IWRG01Controller.IWRG0104", e);
			throw e;
		}
		return "/pantheon/iwrs/g01/IWRG0104";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/selectRandomizationList.do")
	public Map<String, Object> selectRandomizationList(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			map.put("IWRS_VER", req.getParameter("IWRS_VER"));
			List<Map<String, String>> list = iwrg01Service.selectRandomizationList(map);
			result.put("result", true);
			result.put("list", list);
		}catch(Exception e){
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping("/iwrs/g01/IWRG0105.do")
	public String IWRG0105(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("CMMN_CLCODE", "IWRS019");
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			req.setAttribute("TASK_SN", req.getParameter("TASK_SN"));
			req.setAttribute("IWRS_VER", req.getParameter("IWRS_VER"));
			req.setAttribute("TASK_NM", req.getParameter("TASK_NM"));
			req.setAttribute("IWRS019", comd01Service.selectCmCmmnCodeListByPk(map));
			map.put("CMMN_CLCODE", "IWRS006");
			req.setAttribute("IWRS006", comd01Service.selectCmCmmnCodeListByPk(map));
			req.setAttribute("visit", iwrg01Service.selectVisitInfo(map));
			req.setAttribute("EDC_VER", iwrg01Service.selectEdcVersion(map));
		} catch(Exception e){
			LOGGER.error("IWRG01Controller.IWRG0105", e);
			throw e;
		}
		return "/pantheon/iwrs/g01/IWRG0105";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/selectArmRaioInfo.do")
	public Map<String, Object> selectArmRaioInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			List<Map<String, String>> list = iwrg01Service.selectArmRaioInfo(map);
			result.put("list", list);
			result.put("result", true);
		}catch(Exception e){
			result.put("result", false);
			result.put("message", "Arm Ratio 데이터 조회 실패");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertCodeCreat.do")
	public Map<String, Object> insertCodeCreat(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("TASK_SN", req.getParameter("TASK_SN"));
			map.put("IWRS_VER", req.getParameter("IWRS_VER"));
			map.put("SE_CODE", req.getParameter("SE_CODE"));
			map.put("STTUS_CODE", req.getParameter("STTUS_CODE"));
			map.put("CODE_TY", req.getParameter("CODE_TY"));
			map.put("ROLE_TY", req.getParameter("ROLE_TY"));
			map.put("STRTFY_AT", req.getParameter("STRTFY_AT"));
			map.put("EDC_VER", req.getParameter("EDC_VER"));
			map.put("OPER_TY", req.getParameter("OPER_TY"));
			map.put("VISIT_SN", req.getParameter("VISIT_SN"));
			map.put("USE_AT", req.getParameter("USE_AT"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			String creat_code = iwrg01Service.insertCodeCreat(map);
			result.put("result", true);
			result.put("message", "저장하였습니다");
			result.put("CREAT_CODE", creat_code);
		}catch(Exception e){
			result.put("result", false);
			result.put("message", "저장중 에러가 발생하였습니다.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertArmRatioInfo.do")
	public Map<String, Object> insertArmRatioInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("data",  req.getParameter("data"));
			int ratio = iwrg01Service.insertArmRatioInfo(map);
			result.put("result", true);
			result.put("ratio", ratio);
			result.put("message", "저장하였습니다.");
		} catch (Exception e){
			result.put("result", false);
			result.put("message", "저장중 에러가 발생하였습니다");
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertCodeConfigurationInfo.do")
	public Map<String, Object> insertCodeConfigurationInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("data", req.getParameter("data"));
			iwrg01Service.insertCodeConf(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch(Exception e){
			result.put("result", false);
			result.put("message", "저장중 에러가 발생하였습니다.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertRandomSeed.do")
	public Map<String, Object> insertRandomSeed(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("data", req.getParameter("data"));
			iwrg01Service.insertRandomSeed(map);
			result.put("result", true);
			result.put("message", "저장하였습니다.");
		} catch(Exception e){
			result.put("result", false);
			result.put("message", "저장중 에러가 발생하였습니다.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/g01/insertRandomizationInfo.do")
	public Map<String, Object> insertRandomizationInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("CREAT_CODE", req.getParameter("CREAT_CODE"));
			map.put("EDC_VER", req.getParameter("EDC_VER"));
			map.put("ADIT_AT", req.getParameter("ADIT_AT"));
			map.put("OPER_TY", req.getParameter("OPER_TY"));
			iwrg01Service.insertRandomizationInfo(map);
			result.put("result", true);
			result.put("message", "무작위 배정 코드를 생서앟였습니다.");
		} catch(Exception e){
			result.put("result", false);
			result.put("message", "무작위배정 코드 생성 중 에러가 발상하였습니다.");
		}
		return result;
	}
	
	@RequestMapping("/iwrs/g01/selectTest.do")
	public void selectTest(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		//iwrg01Service.test();
		
		Map<String, String> result = new HashMap<String, String>();
		try {
			JSONArray array = new JSONArray(req.getParameter("data"));
			System.err.println(array);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	}
}
