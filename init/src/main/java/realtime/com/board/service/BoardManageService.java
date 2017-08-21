package realtime.com.board.service;

import java.util.List;
import java.util.Map;

public interface BoardManageService {
	/**
	 * 게시판 관리 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTbBoardList(Map<String, Object> map) throws Exception ;

	/**
	 * CRUD로 게시판 관리 저장, 업데이트, 삭제
	 * @param list
	 * @throws Exception
	 */
	public void multiTbDetailBoard(List<Map<String, Object>> list) throws Exception ;
}
