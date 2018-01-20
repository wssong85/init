package realtime.com.board.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("BoardManageMapper")
public interface BoardManageMapper {

	List<Map<String, Object>> selectTbBoardManageList(Map<String, Object> map);

	void insertTbBoardManage(Map<String, Object> iMap);

	void updateTbBoardManage(Map<String, Object> iMap);

	void deleteTbBoardManage(Map<String, Object> iMap);
	
	void createTbBoard(Map<String, Object> map);
	
	void createTbComment(Map<String, Object> map);
	
	void dropTbBoard(Map<String, Object> map);
	
	void dropTbComment(Map<String, Object> map);
	
}
