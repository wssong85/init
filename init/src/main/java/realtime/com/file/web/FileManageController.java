package realtime.com.file.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping(value = "/com/file/insertTbFileMaster.do")
	public @ResponseBody String insertTbFileMaster(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
			throws Exception {
		
		String result = null;
		String strFileId = "";
		try {
			strFileId = fileManageService.insertTbFileMaster(request);
			result = "{\"success\": true, \"result\": \"" + strFileId + "\"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
		}
		
		return result;
	}
	
}
