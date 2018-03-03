package realtime.com.file.web;

import java.util.HashMap;
import java.util.List;
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
	
	/**
	 * 파일입력
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
		List<Map<String, String>> list = null;
		try {
			list = fileManageService.insertTbFileMaster(request, map);
			
//			result = "{\"success\": true, \"result\": \"" + strFileId + "\"}";
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
//			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
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

	
}
