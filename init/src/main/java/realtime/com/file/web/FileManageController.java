package realtime.com.file.web;

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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import realtime.com.file.service.FileManageService;

@Controller
public class FileManageController {
	
	@Resource(name ="FileManageService")
	private FileManageService fileManageService;
	
	/**
	 * 파일업로드샘플 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/com/sample/FileUploadSample.do")
	public String fileUploadSample(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "realtime/com/sample/FileUploadSample";
	}
	
	/**
	 * 파일입력 (map return)
	 * @param request  file일 경우 file 이름은 abcd.jpg 일 경우 abcd_1.jpg, abcd_2.jpg 로 파일명을 시퀀스 붙이고 바꿔서 보내주도록 한다.
	 * @param response
	 * @param map  [{PROCESS_SE : C(새로입력), U(입력된 후 다시 입력)}, {FILE_ID: ""(PROCESS_SE가 C일 경우)}, {FILE_DETAIL_ID: ""(PROCESS_SE가 C일 경우, PROCESS_SE가 U일 경우)}]
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/file/apiInsertTbFileMaster.do")
	public @ResponseBody Map<String, Object> apiInsertTbFileMaster(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> map)
			throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, String>> list = fileManageService.insertTbFileMaster(request, map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 파일입력 (string return)
	 * @param request  file일 경우 file m이름은 abcd.jpg 일 경우 abcd_1.jpg, abcd_2.jpg 로 파일명을 시퀀스 붙이고 바꿔서 보내주도록 한다.
	 * @param response
	 * @param map  [{PROCESS_SE : C(새로입력), U(입력된 후 다시 입력)}, {FILE_ID: ""(PROCESS_SE가 C일 경우)}, {FILE_DETAIL_ID: ""(PROCESS_SE가 C일 경우, PROCESS_SE가 U일 경우)}]
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/file/apiInsertTbFileMasterForString.do")
	public @ResponseBody String apiInsertTbFileMasterForString(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> map)
					throws Exception {
		
		String result = "";
		
		try {
			
			List<Map<String, String>> list = fileManageService.insertTbFileMaster(request, map);
			
			result = "{\"success\": true, \"result\" : " + Util.geStrJsonByString(list)+ "}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
		}
		
		return result;
	}
	
	/**
	 * 파일삭제
	 * @param request
	 * @param response
	 * @param map[{FILE_ID: ""}, {FILE_DETAIL_ID: ""}]
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/file/apiDeleteTbFileMaster.do")
	public @ResponseBody Map<String, Object> apiDeleteTbFileMaster(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam List<Map<String, String>> list)
			throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			fileManageService.deleteTbFileMaster(list);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 파일다운로드 
	 * @param request (ex : http://localhost/com/file/apiSelectTbFileDetail.do?FILE_ID=6&FILE_DETAIL_ID=7&FILE_SEQ=1 )
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/file/apiSelectTbFileDetail.do", produces="text/plain;charset=UTF-8")
	public void apiSelectTbFileDetail(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, String> fileInfo = fileManageService.selectTbFileDetail(map);
		
		File uFile = new File(fileInfo.get("FILE_PATH"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			// String mimetype = servletContext.getMimeType(requestedFile);
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
			String filename = fileInfo.get("FILE_NAME") + "." + fileInfo.get("FILE_EXT");
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
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fileInfo.get("FILE_NAME") + "."+ fileInfo.get("FILE_EXT") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}


	
}
