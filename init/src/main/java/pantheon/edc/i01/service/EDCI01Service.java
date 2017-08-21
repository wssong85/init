package pantheon.edc.i01.service;

import java.util.List;
import java.util.Map;

public interface EDCI01Service {

	public List<Map<String, Object>> selectResearchSubjectList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectFieldSubjectList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> selectTaskBlindPk(Map<String, Object> param) throws Exception;
	
	public void insertEdcSanctnRequstByEdcSanClineDetailInfo(Map<String, Object> list) throws Exception;
	
	//눈가림 해제 승인 popup 창 select
	public Map<String, Object> selectCfSubject(Map<String, Object> param) throws Exception;
	
	//눈가림 즉시해제 저장
	public void updateEdcCfSubjectByBlindSttusCd(Map<String, Object> param) throws Exception;

	//SMS or EMAIL 전송시 필요한 데이터들 가져오기
	public Map<String, String> selectSendInfo(Map<String, String> param) throws Exception;
	
	//눈가림 즉시해제 승인번호 전송
	public void updateEdcCfSubjectBySendInfo(Map<String, String> param) throws Exception;
	
	//결재 Proccess
	public Map<String, String> updateScanProcess(Map<String, String> param) throws Exception;
}
