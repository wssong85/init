package pantheon.edc.h01.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.edc.h01.service.EDCH01Service;


@Controller
@RequestMapping("/edc/h01")
public class EDCH01Controller {
	
	@Resource(name = "EDCH01Service")
	EDCH01Service EDCH01Service;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@RequestMapping("/EDCH0101.do")
	public String EDCH0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/h01/EDCH0101";
	}
	
	@RequestMapping("/popupEDCH0102.do")
	public String popupEDCH0102(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/h01/EDCH0102";
	}
	
	@RequestMapping("/popupEDCH0103.do")
	public String popupEDCH0103(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/h01/EDCH0103";
	}
	
	@RequestMapping("/EDCH0103.do")
	public String EDCH0103(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/h01/EDCH0103";
	}
	
	/**
	 * LAB 파일 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectDmFileDetailList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcCrInsttForm(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCH01Service.selectDmFileDetailList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}	
	
	/**
	 * LAB Data 파일 상세 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcLabDtaList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcLabDtaList(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCH01Service.selectEdcLabDtaList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	@RequestMapping("/selectDownTemplate.do")
	public @ResponseBody Map<String, Object> selectDownTemplate(@RequestParam Map<String, String> map, 
			ModelMap model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			result = EDCH01Service.selectLabTemplate(map);
			
			result.put("success", true);
	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 파일다운로드
	 * @param request
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectOpenFile.do", produces="text/plain;charset=UTF-8")
	public void selectOpenFile(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		File uFile = new File(map.get("FILE_PATH"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
			String filename = map.get("FILE_NAME") + ".xls";
			if(userAgent.indexOf("MSIE") > -1){
				filename = URLEncoder.encode(filename, "utf-8");
			}else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
				filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "\\ ");
		    }else{
		    	filename = new String(filename.getBytes("utf-8"), "iso-8859-1");
			}
			response.setHeader("Content-Disposition", "attachment; filename=\""+ filename + "\"");
			response.setContentLength(fSize);
			
			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
			uFile.delete();
		} else {
			//setContentType을 프로젝트 환경에 맞추어 변경
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"+ map.get("FILE_NAME") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
			uFile.delete();
		}
	}
	
	/**
	 * Data Upload와 동시에 Lab 파일을 읽어 유효성을 체크를 한 후 결과값을 리턴한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/selectLabListByExcel.do")
	public @ResponseBody String selectLabListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)		throws Exception {
		String result = null;
		String moduleKnd = "EDC";
		try {
			String mstrSn = comz02Service.insertDmFileMstr(request, moduleKnd);
			map.put("FILE_MASTR_SN", mstrSn);
			
			List<Map<String, Object>> detailInfo = comz02Service.selectDmFileDetailListByPk(map);
			
			for(Map<String, Object> data : detailInfo){
				map.put("DETAIL_SN", data.get("DETAIL_SN").toString());
			
				Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(map);
				String filePath = fileInfo.get("DWLD_PHYSIC_COURS") + fileInfo.get("UPLOAD_FILE_NM");
				map.put("filePath", filePath);
				File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
				int fSize = (int) uFile.length();
				
				if (fSize > 0) {
					Map<String, Object> resultMap = EDCH01Service.selectLabListByExcel(request, map);
					result = "{\"success\": true, \"count\": " + resultMap.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)resultMap.get("list"))+"}";
				}
			}
			
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	@RequestMapping(value="/insertLabData.do")
	public @ResponseBody Map<String, Object> insertLabData(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			EDCH01Service.insertLabData(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 저장된 LabDta 테이블의 데이터로 이상반응 유효성 검사 후 EDC_CF_VRIABL 테이블에 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertLabCfValue.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertLabCfValue(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			EDCH01Service.insertLabCfValue(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	
}
