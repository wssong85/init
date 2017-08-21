package realtime.com.board.web;

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

import realtime.com.board.service.BoardManageService;

/**
 * 
 * @author sanguk
 *
 */
@Controller
public class BoardManageController {
	
	@Resource(name = "")
	private BoardManageService boardManageService ;
	
	/**
	 * 게시판 관리 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/board/boardManage.do")
	public String boardManage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "realtime/com/board/boardManage";
	}
	
	/**
	 * 게시판 관리 목록 조회 
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/board/selectTbBoardList.do")
	@ResponseBody
	public Map<String, Object> selectTbBoardList(HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null ;
		
		try {
			list = boardManageService.selectTbBoardList(null);
			System.out.println(list);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result ;
	}
	
	/**
	 * CRUD 게시판 관리 저장, 업데이트, 삭제 기능완료 
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/board/multiTbBoard.do")
	@ResponseBody 
	public Map<String, Object> multiTbBoard(HttpServletRequest request, HttpServletResponse response,
			@RequestParam List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			boardManageService.multiTbDetailBoard(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result ;
	}
		
}
