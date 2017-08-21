package pantheon.sdb.b01.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.DrmManageService;
import pantheon.sdb.b01.service.SDBB01Service;
import egovframework.com.utl.fcc.service.EgovDateUtil;

@Controller
public class SDBB01Controller {	
	
	@Resource(name="SDBB01Service")
	private SDBB01Service sdbb01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	
	
	@RequestMapping(value="/sdb/b01/SDBB0101.do")
	public String sdbb0101(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		return "/pantheon/sdb/b01/SDBB0101";	 	
	} 
	
	@RequestMapping(value="/sdb/b01/SDBB0102.do")
	public String sdbb0102(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> map74 = new HashMap<String, String>();
		Map<String, String> map_ori = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType74 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType_ori = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB044");
		map.put("task_code", "1");
		map.put("type", "type");
		map74.put("CMMN_CLCODE", "SDB074");
		map74.put("task_code", "1");
		map74.put("type", "type");
		map74.put("CMMN_CLCODE", "SDB074");
		map74.put("task_code", "1");
		map74.put("type", "type");
		map_ori.put("OTYPE", "");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			printType74 = comd01Service.selectCmCmmnCodeListByPk(map74);
			printType_ori = sdbb01Service.selectOrganCodeListByPk(map_ori);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("printType74", printType74);
		request.setAttribute("printType_ori", printType_ori);
		
		String prduct_code = request.getParameter("PRDUCT_CODE");
		request.setAttribute("req_prduct_code", prduct_code);
		return "/pantheon/sdb/b01/SDBB0102";	 	
	}
	
	@RequestMapping(value="/sdb/b01/SDBB0103.do")
	public String sdbb0103(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB001");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		 
		String prduct_code = request.getParameter("PRDUCT_CODE");			
		request.setAttribute("req_prduct_code", prduct_code);
		
		
		return "/pantheon/sdb/b01/SDBB0103";	 	
	}
	
	@RequestMapping(value="/sdb/b01/SDBB0104.do")
	public String sdbb0104(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB071");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("===============");
		System.out.println(printType);
		request.setAttribute("printType", printType);
		
		String prduct_code = request.getParameter("PRDUCT_CODE");			
		request.setAttribute("req_prduct_code", prduct_code);
		return "/pantheon/sdb/b01/SDBB0104";	 	
	}
	
	@RequestMapping(value="/sdb/b01/SDBB0105.do")
	public String sdbb0105(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String prduct_code = request.getParameter("PRDUCT_CODE");			
		request.setAttribute("req_prduct_code", prduct_code);
		return "/pantheon/sdb/b01/SDBB0105";	 	
	}
	
	
	
	
	/**
	 * 의약품 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b01/selectProductList.do")
	public @ResponseBody Map<String , Object> selectProductList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb01Service.selectProductList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	
	
	/**
	 * 의약품 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b01/selectProductListInfo.do")
	public Map<String, Object> selectProductListInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String prduct_code = req.getParameter("PRDUCT_CODE");			
		param.put("PRDUCT_CODE", prduct_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = sdbb01Service.selectProductListInfo(param);
		
		try {			
			result.put("CONFM_DTE", EgovDateUtil.convertDate(String.valueOf(result.get("CONFM_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 의약품 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b01/selectProductReportInfo.do")				
	public Map<String , Object> selectProductReportInfo(HttpServletRequest request, HttpServletResponse response, 
				@RequestParam Map<String, Object> map) throws Exception {
	
		System.out.println("=================:ReportInfo");
		Map<String, Object> param = new HashMap<String, Object>();
		String prduct_code = request.getParameter("PRDUCT_CODE");				
		param.put("PRDUCT_CODE", prduct_code);		
		//Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String,Object>> list = null;		
		
		try {
			list = sdbb01Service.selectProductReportInfo(param);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("=====controll Report");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 의약품 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/b01/insertProductList.do")
	public Map<String, Object> insertProductList(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		System.out.println("@@@AJax Insert!!!!!");	

		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			String txtprduct_code = sdbb01Service.insertProductList(iMap);
			result.put("success", true);
			result.put("PRDUCT_CODE", txtprduct_code);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;			
	}
	
	@ResponseBody
	@RequestMapping(value="/sdb/b01/insertProductReport.do")
	public Map<String, Object> insertProductReport(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		
		
		String txtprduct_code 	= iMap.get("PRDUCT_CODE");

		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb01Service.insertProductReport(iMap);
			result.put("success", true);
			result.put("PRDUCT_CODE", txtprduct_code);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;	
	}
	
	/**
	 * 의약품 Label 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b01/selectLabelList.do")
	public @ResponseBody Map<String , Object> selectLabelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb01Service.selectLabelList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/sdb/b01/insertLabelList.do")
	public Map<String, Object> insertLabelList(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		String txtprduct_code 	= iMap.get("PRDUCT_CODE");

		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb01Service.insertLabelList(iMap);		
			result.put("success", true);
			result.put("PRDUCT_CODE", txtprduct_code);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;		
	}
	
	/**
	 * 파일업로드 (Label)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sdb/b01/insertDmFileMstr.do")
	public @ResponseBody String multipartProcess(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
			throws Exception {
		String result = null;
		String moduleKnd = "";
		moduleKnd = map.get("moduleKnd");
		if(moduleKnd == "")	moduleKnd = "COM";
		String mstrSn = null;
		
		try {
			mstrSn = sdbb01Service.insertDmFileMstr(request, "SDB");
			result = "{\"success\": true, \"result\": \"" + mstrSn + "\"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
		}
		
		return result;
		
	}
	
	/**
	 * Label 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b01/selectLabelListInfo.do")
	public Map<String, Object> selectLabelListInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String lbl_code = req.getParameter("LBL_CODE");			
		param.put("LBL_CODE", lbl_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = sdbb01Service.selectLabelListInfo(param);
		
		try {
			result.put("EFECT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(result.get("EFECT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 파일다운로드
	 * @param request
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/sdb/b01/selectDmFileDetailByPk.do")
	public void selectDmFileDetailByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, String> fileInfo = sdbb01Service.selectDmFileDetailByPk(map);
		
		File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
		int fSize = (int) uFile.length();		
		String Filename =  URLEncoder.encode(fileInfo.get("FILE_NAME"), "utf-8"); 
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			// String mimetype = servletContext.getMimeType(requestedFile);
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			response.setHeader("Content-Disposition", "attachment; filename=\""+ Filename + "\"");
			
			response.setContentLength(fSize);
			
			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} else {
			//setContentType을 프로젝트 환경에 맞추어 변경
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"+ fileInfo.get("FILE_NAME") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}
	
	/** 파일리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sdb/b01/selectDmFileDetailListByPk.do")
	public @ResponseBody Map<String, Object> selectDmFileDetailListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> list = sdbb01Service.selectDmFileDetailListByPk(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("success", false);
		}
		
		return result;
	}
	
	/**
	 * 의약품 PSUR 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b01/selectPSURList.do")
	public @ResponseBody Map<String , Object> selectPSURList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb01Service.selectPSURList(map);
			for(Map<String, Object> pmap : list){
				pmap.put("PSUR_BGNDE", EgovDateUtil.convertDate(String.valueOf(pmap.get("PSUR_BGNDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				pmap.put("PSUR_ENDDE", EgovDateUtil.convertDate(String.valueOf(pmap.get("PSUR_ENDDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				
			}
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 의약품 PSUR 등록/수정/삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/b01/insertPSURList.do")
	public Map<String, Object> insertPSURList(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		String txtprduct_code 	= iMap.get("PRDUCT_CODE");
		
		Map<String, Object> result = new HashMap<String, Object>();
			
		try{
			sdbb01Service.insertPSURList(iMap);		
			result.put("success", true);
			result.put("PRDUCT_CODE", txtprduct_code);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;	
	}
	
	/**
	 * PSUR 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b01/selectPSURListInfo.do")
	public Map<String, Object> selectPSURListInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String psur_code = req.getParameter("PSUR_CODE");			
		param.put("PSUR_CODE", psur_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = sdbb01Service.selectPSURListInfo(param);
		
		try {			
			result.put("PSUR_BGNDE", EgovDateUtil.convertDate(String.valueOf(result.get("PSUR_BGNDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			result.put("PSUR_ENDDE", EgovDateUtil.convertDate(String.valueOf(result.get("PSUR_ENDDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 의약품 PSUR 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b01/selectNonCList.do")
	public @ResponseBody Map<String , Object> selectNonCList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb01Service.selectNonCList(map);
			for(Map<String, Object> pmap : list){
				pmap.put("FRST_CREDE", EgovDateUtil.convertDate(String.valueOf(pmap.get("FRST_CREDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				
			}
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 의약품 PSUR 등록/수정/삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/b01/insertNonCList.do")	
	public Map<String, Object> insertNonCList(HttpServletRequest req, HttpServletResponse resp,  @RequestBody Map<String, String> iMap) throws Exception {
		System.out.println("@@@AJax Insert!!!!!");
		
		
		String txtprduct_code 			= iMap.get("PRDUCT_CODE");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb01Service.insertNonCList(iMap);		
			result.put("success", true);
			result.put("PRDUCT_CODE", txtprduct_code);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
		
	}
	
	/**
	 * PSUR 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b01/selectNonCListInfo.do")
	public Map<String, Object> selectNonCListInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String detail_sn = req.getParameter("DETAIL_SN");			
		param.put("DETAIL_SN", detail_sn);
		//
		Map<String, Object> result = sdbb01Service.selectNonCListInfo(param);
		
		try {			
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
}
