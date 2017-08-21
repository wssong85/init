package realtime.com.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.board.mapper.BoardManageMapper;
import realtime.com.board.service.BoardManageService;

@Service("BoardManageService")
public class BoardManageServiceImpl implements BoardManageService {
	@Resource(name = "BoardManageMapper")
	private BoardManageMapper boardManageMapper ;
	
	//BoardManage 까지 적어야한다.
	// ㅇㅋ
	@Override
	public List<Map<String, Object>> selectTbBoardList(Map<String, Object> map) throws Exception {
		return boardManageMapper.selectTbBoardList(map);
	}
	
	@Override
	public void multiTbDetailBoard(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap: list){
			if("C".equals(iMap.get("CRUD"))){
				boardManageMapper.insertTbBoardDetail(iMap);
				
				//selectProgram Pk 체크한다.
				//insertProgram id 넣는다.
				// ㅇㅋ 
				//create tb_board_1  tb_board_ (tb_board_manage_seq) 를 넣도록한다.
				//코멘트 테이블도 마찬가지.
				
				//program_id 는 context-property쪽 bean을 생성하여 그쪽 string값을 가져오도록 한다.
				//tb_menu 쪽은 나중에 넣을 수도 있으니 연결만
				
				//tb_board_manage 에서 시퀀스 기능을 하는 것을 만들어서 그것을 참고하여 넣도록 한다.
				// ㅇㅋ
				//mysql에서는 시퀀스가 없을터인데 생각해보니까
				// 스프링 내에서 제공해주는 시퀀스 없어요?
				// 그리고 마지막에 소스 새로만든거 커밋치는거랑 충돌났을때 업데이트 받는것좀 알려줘영 ㅜㅜ
				
				// 상욱아 그것도 그거인데 테이블채번 테이블도 만들어야 것네
				// 그담에 시퀀스 채번하는 함수 만들어야 한다.
				
				// 일단 형 다 적어주고 내가 보면서 이해 할께요 이해안되면 그때 전화할께요 ㅋㅋ
				
				//https://open-dba.gitbooks.io/mariadb-tips/chapter1.html
				//이거 참고해라 mariadb 테이블 채번 방식
				//ㄴㅣㄱㅏ ㅈㅓㄱㅇㅓ ㅇㅣㄱㅓ ㅎㅏㄴㄱㅡㄹ ㅇㅗㅐㅇㅣㄹㅓㄴㅑㅋㅋㅋㅋ형 왜그럼? 형 놋북만 그런듯?
				
				//nono korean is isanghae ZZZZ 난 잘 되요 
				
				//teamviewer is not good  ZZZZ 보고 한번 참고해볼께요 
				// 이거 만든 패키지 커밋 어케 ㅎ요?
				
				//see
			} else if("U".equals(iMap.get("CRUD"))){
				boardManageMapper.updateTbBoardDetail(iMap);
			} else if("D".equals(iMap.get("CRUD"))){
				boardManageMapper.deleteTbBoardDetail(iMap);
			}
			
			if(true){
				throw new Exception("Test");
			}
		}
	}
}
