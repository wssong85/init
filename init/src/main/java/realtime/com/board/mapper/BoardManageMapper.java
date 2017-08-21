package realtime.com.board.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("BoardManageMapper")
public interface BoardManageMapper {
	List<Map<String, Object>> selectTbBoardList(Map<String, Object> map) ;
	
	void insertTbBoardDetail(Map<String, Object> map);
	
	void updateTbBoardDetail(Map<String, Object> map);
	
	void deleteTbBoardDetail(Map<String, Object> map);
}
