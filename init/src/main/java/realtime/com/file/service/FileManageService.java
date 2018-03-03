package realtime.com.file.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface FileManageService {

	List<Map<String, String>> insertTbFileMaster(HttpServletRequest request, Map<String, Object> map) throws Exception;

	void deleteTbFileMaster(List<Map<String, String>> list) throws Exception;

}
