package realtime.com.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import realtime.com.board.mapper.BoardManageMapper;
import realtime.com.board.service.BoardManageService;
import realtime.com.role.mapper.RoleManageMapper;

@Service("BoardManageService")
public class BoardManageServiceImpl implements BoardManageService {
	
	@Resource(name = "BoardManageMapper")
	private BoardManageMapper boardManageMapper;
	
	@Resource(name = "RoleManageMapper")
	private RoleManageMapper roleManageMapper;
	
	@Resource(name = "TB_BOARD_MANAGE_SEQ")
	private EgovIdGnrService tbboardManageSeq;
	
	@Override
	public void multiTbBoardManage(List<Map<String, Object>> list) throws Exception {
		
		String strBoardManageSeq = "";
		
		for(Map<String, Object> iMap: list){
			if("C".equals(iMap.get("CRUD"))){
				
				strBoardManageSeq = tbboardManageSeq.getNextStringId();
				
				iMap.put("BOARD_MANAGE_SEQ", strBoardManageSeq);
				iMap.put("PROGRAM_ID", "BD_" + strBoardManageSeq);
				
				boardManageMapper.insertTbBoardManage(iMap);
				
				iMap.put("PROGRAM_NM", iMap.get("BOARD_NM"));
				iMap.put("PROGRAM_URL", "/com/board/board_" + strBoardManageSeq + ".do");
				iMap.put("USE_YN", "Y");
				
				roleManageMapper.insertTbProgram(iMap);
				
				iMap.put("createTbBoard", getStrForDecisionTable("CREATE_TB_BOARD",strBoardManageSeq));
				boardManageMapper.createTbBoard(iMap);
				
				iMap.put("createTbComment", getStrForDecisionTable("CREATE_TB_COMMENT",strBoardManageSeq));
				boardManageMapper.createTbComment(iMap);
				
			} else if("U".equals(iMap.get("CRUD"))){
				
				boardManageMapper.updateTbBoardManage(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))){
				
				boardManageMapper.deleteTbBoardManage(iMap);
				
				iMap.put("dropTbBoard", getStrForDecisionTable("DROP_TB_BOARD", iMap.get("BOARD_MANAGE_SEQ").toString()));
				boardManageMapper.dropTbBoard(iMap);
				
				iMap.put("dropTbComment", getStrForDecisionTable("DROP_TB_COMMENT", iMap.get("BOARD_MANAGE_SEQ").toString()));
				boardManageMapper.dropTbComment(iMap);
				
				iMap.put("PROGRAM_ID", "BOARD_" + iMap.get("BOARD_MANAGE_SEQ").toString());
				roleManageMapper.deleteTbProgram(iMap);
			}
		}
		
	}


	@Override
	public List<Map<String, Object>> selectTbBoardManageList(Map<String, Object> map) throws Exception {
		return boardManageMapper.selectTbBoardManageList(map);
	}
	
	public String getStrForDecisionTable(String strTbNm, String strId) throws Exception {
		
		String strReturn = "";
		
		if("CREATE_TB_BOARD".equals(strTbNm)) {
			strReturn = 
					"CREATE TABLE TB_BOARD_" + strId + "(         "
							+ "    BOARD_SEQ NUMERIC  NOT NULL,  "
							+ "    USER_ID VARCHAR(50)  NOT NULL,"
							+ "    TITLE VARCHAR(200)  NULL,     "
							+ "    DETAIL LONGTEXT  NULL,        "
							+ "    FILE_ID VARCHAR(50)  NULL,    "
							+ "    READ_CT NUMERIC  NULL,        "
							+ "    GOOD_CT NUMERIC  NULL,        "
							+ "    BAD_CT NUMERIC  NULL,         "
							+ "    USE_YN VARCHAR(1)  NULL,      "
							+ "    IN_DT DATETIME  NULL,         "
							+ "    UP_DT DATETIME  NULL,         "
							+ "    WRITE_ID VARCHAR(50)  NULL    "
							+ ")";

		} else if("CREATE_TB_COMMENT".equals(strTbNm)) {
			
			strReturn = 
					 "CREATE TABLE TB_COMMENT_" + strId + " ( "
								+ "		    USER_ID VARCHAR(50)  NOT NULL,  "
								+ "		    BOARD_SEQ NUMERIC  NOT NULL,    "
								+ "		    COMMNET_SEQ NUMERIC  NULL,      "
								+ "		    COMMENT_LV NUMERIC  NULL,       "
								+ "		    GOOD_CT NUMERIC  NULL,          "
								+ "		    BAD_CT NUMERIC  NULL,           "
								+ "		    IN_DT DATETIME  NULL,           "
								+ "		    UP_DT DATETIME  NULL,           "
								+ "		    WRITE_ID VARCHAR(50)  NULL      "
								+ "		)";

		} else if("DROP_TB_BOARD".equals(strTbNm)) {
			
			strReturn = "DROP TABLE TB_BOARD_" + strId;
			
		} else if("DROP_TB_COMMENT".equals(strTbNm)) {
			
			strReturn = "DROP TABLE TB_COMMENT_" + strId;
			
		}
		
		return strReturn;
	}
}
