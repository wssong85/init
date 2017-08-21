package pantheon.sdb.e03.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.sdb.e03.service.SDBE03Service;

@Controller
public class SDBE03Controller {
	@Resource(name = "SDBE03Service")
	private SDBE03Service sdbe03Service;
	
	@RequestMapping("/sdb/e03/SDBE0305.do")
	public String SDBE0305(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/e03/SDBE0305";
	}
	
	@RequestMapping(value="/sdb/e03/popupSDBE0308.do")
	public String popupSdbe0308(HttpServletRequest request, HttpServletResponse response) throws Exception {		

		return "/pantheon/sdb/e03/SDBE0308";
	}
	
	@RequestMapping("/sdb/e03/SDBE0312.do")
	public String SDBE0312(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/e03/SDBE0312";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/selectQueryList.do")
	public Map<String, Object> selectQueryList(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("count", req.getParameter("count"));
		map.put("page", req.getParameter("page"));
		map.put("TASK_CODE", "1");
		try {
			List<Map<String, String>> list = sdbe03Service.selectQueryList(map);
			int count = sdbe03Service.selectQueryCnt(map);
			result.put("list", list);
			result.put("count", count);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "Query 정보를 정상적으로 가져오지 못했습니다. 운영자에게 연락하세요.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/updateQueryEndInfo.do")
	public Map<String, Object> updateQueryEndInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("QUERY_NO", req.getParameter("QUERY_NO"));
		map.put("QUERY_STTUS_CODE", req.getParameter("QUERY_STTUS_CODE"));
		map.put("RESN", req.getParameter("RESN"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		try {
			sdbe03Service.updateEndQueryInfo(map);
			result.put("result", true);
			result.put("message", "Query 정상적으로 종료 되었습니다.");
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "Query 정보를 종료하지 못했습니다. 운영자에게 연락하세요.");
		}
		return result;
	}
	
	@RequestMapping("/sdb/e03/SDBE0310.do")
	public String SDBE0310(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/e03/SDBE0310";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/selectVerification.do")
	public Map<String, Object> selectVerification(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		map.put("MAFU_NO", req.getParameter("MAFU_NO"));
		map.put("PRDUCT_NM", req.getParameter("PRDUCT_NM"));
		map.put("FIRST_DATE_START", req.getParameter("FIRST_DATE_START"));
		map.put("FIRST_DATE_END", req.getParameter("FIRST_DATE_END"));
		map.put("REPORT_DATE_START", req.getParameter("REPORT_DATE_START"));
		map.put("REPORT_DATE_END", req.getParameter("REPORT_DATE_END"));
		map.put("DMSTC_OUTNATN_SE", req.getParameter("DMSTC_OUTNATN_SE"));
		map.put("NORMAL", req.getParameter("NORMAL"));
		try {
			System.err.println(map);
			list = sdbe03Service.selectVerificationInfo(map);
			result.put("result", true);
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/insertSafetyManagerFile.do")
	public String insertSafetyManagerFile(HttpServletRequest req, HttpServletResponse resp){
		String result = "";
		try {
			String fileName = sdbe03Service.insertExcelInfo(req);
			result = "{\"success\": true, \"result\" : \"" + fileName + "\"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : \"안전관리원파일 업로드 중 에러가 발생하였습니다. 관리자에게 문의하세요.\"}";
		}
		return result; 
	}
	
	@RequestMapping("/sdb/e03/popupSdbe0311.do")
	public String popupSdbe0311(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		req.setAttribute("FILENM", req.getParameter("FILENM"));
		req.setAttribute("MAFU_NO", req.getParameter("MAFU_NO"));
		req.setAttribute("PRDUCT_NM", req.getParameter("PRDUCT_NM"));
		req.setAttribute("FIRST_DATE_START", req.getParameter("FIRST_DATE_START"));
		req.setAttribute("FIRST_DATE_END", req.getParameter("FIRST_DATE_END"));
		req.setAttribute("REPORT_DATE_START", req.getParameter("REPORT_DATE_START"));
		req.setAttribute("REPORT_DATE_END", req.getParameter("REPORT_DATE_END"));
		req.setAttribute("DMSTC_OUTNATN_SE", req.getParameter("DMSTC_OUTNATN_SE"));
		req.setAttribute("NORMAL", req.getParameter("NORMAL"));
		return "/pantheon/sdb/e03/SDBE0311";
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/selectVerificationForExcel.do")
	public Map<String, Object> selectVerificationForExcel(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("FILENM", req.getParameter("FILENM"));
		map.put("MAFU_NO", req.getParameter("MAFU_NO"));
		map.put("PRDUCT_NM", req.getParameter("PRDUCT_NM"));
		map.put("FIRST_DATE_START", req.getParameter("FIRST_DATE_START"));
		map.put("FIRST_DATE_END", req.getParameter("FIRST_DATE_END"));
		map.put("REPORT_DATE_START", req.getParameter("REPORT_DATE_START"));
		map.put("REPORT_DATE_END", req.getParameter("REPORT_DATE_END"));
		map.put("DMSTC_OUTNATN_SE", req.getParameter("DMSTC_OUTNATN_SE"));
		map.put("NORMAL", req.getParameter("NORMAL"));
		try {
			List<Map<String, String>> list = sdbe03Service.selectVerificationForExcel(map);
			result.put("list", list);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/updateVerificationInfo.do")
	public Map<String, Object> updateVerificationInfo(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("param", req.getParameter("data"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			System.err.println(map);
			sdbe03Service.updateVerificationInfo(map);
			result.put("result", true);
			result.put("message", "정상적으로 적용하였습니다.");
		}catch(Exception e){
			result.put("result", false);
			result.put("message", "적용에 실패하였습니다. 다시 시도하시기 바랍니다.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/e03/deleteTempVerificationInfo.do")
	public Map<String, Object> deleteTempVerificationInfo(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		try{
			map.put("FILENM", req.getParameter("FILENM"));
			sdbe03Service.deleteTempVerificationInfo(map);
			result.put("result", true);
		}catch(Exception e){
			result.put("result", false);
			result.put("message", "임시 데이터 삭제중 에러가 발생하였습니다. 관리자에게 문의하세요.");
		}
		return result;
	}
	
	@RequestMapping("/sdb/e03/selectChargeListPop.do")
	public @ResponseBody Map<String, Object> selectChargeListPop(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = sdbe03Service.selectChargeListPop(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	
	}
	
	@RequestMapping("/sdb/e03/insertSendMail.do")
	public @ResponseBody Map<String, Object> insertSendMail(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			sdbe03Service.insertSendMail(map);
			result.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("result", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;		
	}
}
