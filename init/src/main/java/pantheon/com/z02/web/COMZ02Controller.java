package pantheon.com.z02.web;

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

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z02.service.DrmManageService;

/**
 * 업로드 처리하는 컨트롤러 클래스
 * @author 송원석
 * @since 2016.03.02
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.02  송원석          최초 생성
 *  
 */
@Controller
public class COMZ02Controller {
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	/** EgovPropertyService */
	@Resource(name = "comPdfService")
	protected EgovPropertyService comPdfService;

	/**
	 * 파일업로드 샘플 페이지 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/com/z02/COMZ0201.do")
	public String comz0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/z02/COMZ0201";
	}
	
	/**
	 * 파일업로드 샘플 다운로드 페이지 호출 
	 * @param request
	 * @param response
	 * @param strParam
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/z02/COMZ0201_DOWN.do")
	public String comz0201_down(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="MstrSn") String strParam, ModelMap model) {
		if(strParam != null) {
			model.addAttribute("MstrSn", strParam);
		}
		return "/pantheon/com/z02/COMZ0201_DOWN";
	}
	
	/**
	 * pdf 입력 테스트
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/com/z02/insertTestPdf.do")
	public void insertTestPdf(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		String moduleKnd = "";
		moduleKnd = map.get("moduleKnd");
		if(moduleKnd == "")	moduleKnd = "COM";
		
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		map.put("URL", "URL파싱되나 보자");
		
		try {
			String mstrSn = comz02Service.insertDmFileMstrForPdf(comPdfService, moduleKnd, "test", map);
			System.out.println(mstrSn);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}

	}

	/**
	 * 파일업로드 (샘플)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/z02/insertDmFileMstr.do")
	public @ResponseBody String multipartProcess(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
			throws Exception {
		
		String result = null;
		String moduleKnd = "";
		moduleKnd = map.get("moduleKnd");
		if(moduleKnd == "")	moduleKnd = "COM";
		String mstrSn = null;
		
		try {
			mstrSn = comz02Service.insertDmFileMstr(request, moduleKnd);
			result = "{\"success\": true, \"result\": \"" + mstrSn + "\"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
		}
		
		return result;
	}
	
	/**
	 * 파일 상세업로드
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/z02/insertDmFileDetail.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> D(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
					throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			String mstrSn = comz02Service.insertDmFileDetail(request, "COM", "205");
			result.put("result", mstrSn);
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
	@RequestMapping(value = "/com/z02/selectDmFileDetailByPk.do", produces="text/plain;charset=UTF-8")
	public void selectDmFileDetailByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(map);
		
		File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			// String mimetype = servletContext.getMimeType(requestedFile);
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
			String filename = fileInfo.get("FILE_NAME");
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
	
	/**
	 * 파일다운로드
	 * @param request
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/anonymous/selectDmFileDetailByPk.do", produces="text/plain;charset=UTF-8")
	public void selectDmFileDetailByPk2(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(map);
		
		File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			// String mimetype = servletContext.getMimeType(requestedFile);
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
			String filename = fileInfo.get("FILE_NAME");
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
	
	/**
	 * 파일리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/z02/selectDmFileDetailListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectDmFileDetailListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> list = comz02Service.selectDmFileDetailListByPk(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("success", false);
		}
		
		return result;
	}
	
	
	@RequestMapping(value = "/com/z02/downloadAuiGridFile.do")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(value="data") String data, @RequestParam(value="extension") String extension) throws Exception {
		
		byte[] dataByte = Base64.decodeBase64(data.getBytes());
		String filename = "export." + extension;
		
		if (dataByte.length > 0) {
			
			String userAgent 	= request.getHeader("User-Agent");
			
			if(userAgent.indexOf("MSIE") > -1){
				filename = URLEncoder.encode(filename, "utf-8");
			}else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
				filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "\\ ");
		    }else{
		    	filename = new String(filename.getBytes("utf-8"), "iso-8859-1");
			}
				
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition","attachment; filename=" + filename );
			response.setHeader("Content-Length",String.valueOf(dataByte.length));
			
			FileCopyUtils.copy(dataByte, response.getOutputStream());
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} else {
			//setContentType을 프로젝트 환경에 맞추어 변경
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"+ filename + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}
	
	/**
	 * 계약서 word 파일 pdf 변환 후 임시 패스 반환
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/anonymous/selectEdcCrTaskForWord.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectTaskWordForPdf(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			String strResultPath = comz02Service.selectEdcCrTaskForWord(map);
			
			result.put("result", strResultPath);
			result.put("success", true);
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("success", false);
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
	@RequestMapping(value = "/com/anonymous/pdfActionView.do", produces="text/plain;charset=UTF-8")
	public void pdfActionView(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		if(!map.containsKey("FILE_NAME")) {
			throw new Exception("PARAMETER IS NULL");
		}
		
		File uFile = new File(map.get("FILE_NAME"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			// String mimetype = servletContext.getMimeType(requestedFile);
			String mimetype = "text/html";
			String fileName = map.get("FILE_NAME");
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
//			String filename = fileName;
			if(userAgent.indexOf("MSIE") > -1){
				fileName = URLEncoder.encode(map.get("FILE_NAME"), "utf-8");
			}else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ");
			}else{
				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
			}
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+ fileName + "\"");
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
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"+ map.get("FILE_NAME") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}

	
}
