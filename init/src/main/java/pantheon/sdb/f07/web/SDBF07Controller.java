package pantheon.sdb.f07.web;

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

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.sdb.f07.service.SDBF07Service;

@Controller
public class SDBF07Controller {
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "SDBF07Service")
	private SDBF07Service sdbf07Service;
	
	@RequestMapping("/sdb/f07/SDBF0701.do")
	public String SDBF0701(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		List<Map<String, Object>> assessmentType = new ArrayList<Map<String, Object>>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("CMMN_CLCODE", "SDB069");
		try {
			assessmentType = comd01Service.selectCmCmmnCodeListByPk(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		req.setAttribute("assessment", assessmentType);
		return "/pantheon/sdb/f07/SDBF0701";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f07/selectAssessmentSettingInfo.do")
	public Map<String, Object> selectAssessmentSettingInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("SE_CODE", req.getParameter("SE_CODE"));
		try {
			List<Map<String, String>> list = sdbf07Service.selectAssessmentSettingInfo(param);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f07/insertAssessmentInfo.do")
	public Map<String, String> insertAssessmentInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("data", req.getParameter("data"));
		try {
			sdbf07Service.insertAssessmentInfo(param);
			result.put("result", "true");
			result.put("message", "등록하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f07/deleteAssessmentInfo.do")
	public Map<String, String> deleteAssessmentInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("data", req.getParameter("data"));
		try {
			sdbf07Service.deleteAssessmentInfo(param);
			result.put("result", "true");
			result.put("message", "삭제되었습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
