package pantheon.sdb.f01.web;

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

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.utl.Util;
import pantheon.sdb.f01.service.SDBF01Service;

@Controller
public class SDBF01Controller {
	@Resource(name = "SDBF01Service")
	private SDBF01Service sdbf01Service;
	
	@RequestMapping("/sdb/f01/SDBF0101.do")
	public String SDBF0101(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "/pantheon/sdb/f01/SDBF0101";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/selectQcResultReportList.do")
	public Map<String, Object> selectQcResultReportList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("START_DATE", req.getParameter("START_DATE"));
		param.put("END_DATE", req.getParameter("END_DATE"));
		
		try {
			List<Map<String, String>> list = sdbf01Service.selectQcResultReportList(param);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/sdb/f01/SDBF0102.do")
	public String SDBF0102(HttpServletRequest req, HttpServletResponse res) throws Exception{
		List<Map<String, String>> sopList = new ArrayList<Map<String, String>>();
		Map<String, String> qcReport = new HashMap<String, String>();
		Map<String, String> param = new HashMap<String, String>();
		String type = "";
		try {
			param.put("QC_REPRT_NO", req.getParameter("QC_REPRT_NO"));
			param.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
			sopList = sdbf01Service.selectQcSopItemCheckList(param);
			qcReport = sdbf01Service.selectQcReportInfo(param);
			
			if(qcReport != null && qcReport.size() > 0){
				qcReport.put("QLMNGMT_OPRTNDE", EgovDateUtil.convertDate(qcReport.get("QLMNGMT_OPRTNDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				qcReport.put("QLMNGMT_CHARGER_SANCTNDE", EgovDateUtil.convertDate(qcReport.get("QLMNGMT_CHARGER_SANCTNDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				qcReport.put("SFMNGCHRG_DPRLR_SANCTNDE", EgovDateUtil.convertDate(qcReport.get("SFMNGCHRG_DPRLR_SANCTNDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				qcReport.put("PD_LASTDE", EgovDateUtil.convertDate(qcReport.get("PD_LASTDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				qcReport.put("PD_BGNDE", EgovDateUtil.convertDate(qcReport.get("PD_BGNDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				
				
				String strAuth = Util.getAuthorities();
				String str[] = strAuth.split(",");
				String role = "";
				if(strAuth.contains("ROLE_PVM")){
					role = "PVM";
				}
				
				if("PVM".equals(role) && "".equals(qcReport.get("SFMNGCHRG_DPRLR_SANCTNDE"))){
					type = "3";
				}else if(!"".equals(qcReport.get("SFMNGCHRG_DPRLR_SANCTNDE"))){
					type = "4";
				}else if(!Util.getUserMap().get("USER_ID").equals(qcReport.get("QLMNGMT_CHARGER"))){
					type = "2";
				}else{ 
					type = "1";
				}
			}else{
				type = "1";
			}
		} catch (Exception e) {
			sopList = null;
			qcReport = null;
		}

		req.setAttribute("TYPE", type);
		req.setAttribute("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
		req.setAttribute("QC_REPRT_NO", req.getParameter("QC_REPRT_NO"));
		req.setAttribute("soplist", sopList);
		req.setAttribute("qcreport", qcReport);
		return "/pantheon/sdb/f01/SDBF0102";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/insertQcResultReportInfo.do")
	public Map<String, String> insertQcResultReportInfo(HttpServletRequest req, HttpServletResponse res) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("data", req.getParameter("data"));
			sdbf01Service.insertQcResultReportInfo(map);
			result.put("result", "true");
			result.put("message", "등록하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/sdb/f01/popupSdbf0104.do")
	public String popupSdbf0104(HttpServletRequest req, HttpServletResponse res) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		return "/pantheon/sdb/f01/SDBF0104";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/selectUserInfo.do")
	public Map<String, Object> selectUserInfo(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("DEPT_NAME", req.getParameter("DEPT_NAME"));
			map.put("USER_NAME", req.getParameter("USER_NAME"));
			map.put("ROLE_ID", req.getParameter("ROLE_ID"));
			List<Map<String, String>> list = sdbf01Service.selectUserInfo(map);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping("/sdb/f01/popupSdbf0105.do")
	public String popupSdbf0105(HttpServletRequest req, HttpServletResponse res) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		req.setAttribute("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
		System.out.println(req.getParameter("PRDUCT_CODE"));
		return "/pantheon/sdb/f01/SDBF0105";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/selectCaseInfo.do")
	public Map<String, Object> selectCaseInfo(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
			List<Map<String, String>> list = sdbf01Service.selectCaseInfo(map);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/selectProductCaseInfo.do")
	public Map<String, Object> selectProductCaseInfo(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
			map.put("QC_REPRT_NO", req.getParameter("QC_REPRT_NO"));
			List<Map<String, String>> list = sdbf01Service.selectProductCaseInfo(map);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/updateApprovalCaseInfo.do")
	public Map<String, Object> updateApprovalCaseInfo(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
			map.put("QC_REPRT_NO", req.getParameter("QC_REPRT_NO"));
			map.put("SFMNGCHRG_DPRLR", req.getParameter("SFMNGCHRG_DPRLR"));
			map.put("USER_ID", req.getParameter("USER_ID"));
			sdbf01Service.updateApprovalQcInfo(map);
			result.put("result", "true");
			result.put("message", "승인하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f01/selectCapaListInfo.do")
	public Map<String, Object> selectCapaListInfo(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			map.put("QC_REPRT_NO", req.getParameter("QC_REPRT_NO"));
			map.put("PRDUCT_CODE", req.getParameter("PRDUCT_CODE"));
			map.put("SAFE_MANAGE_CHRGDEPT_CHARGER", req.getParameter("SAFE_MANAGE_CHRGDEPT_CHARGER"));
			List<Map<String, String>> list = sdbf01Service.selectCapaListInfo(map);
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
