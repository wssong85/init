package realtime.com.board.service;

import java.util.List;
import java.util.Map;

public interface BoardManageService {
	
	public List<Map<String, Object>> selectTbBoardManageList(Map<String, Object> map) throws Exception;

	public void multiTbBoardManage(List<Map<String, Object>> list) throws Exception;
	
	
}
