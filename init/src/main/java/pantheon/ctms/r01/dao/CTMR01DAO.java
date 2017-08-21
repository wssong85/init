package pantheon.ctms.r01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMR01DAO")
public class CTMR01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMR01DAO.class);
    //protocol 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProtocolList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMR01DAO.selectProtocolList", map);
	}
	
   //protocol 정보 입력
	public void insertProtocolList(Map<String, Object> map) {
		insert("CTMR01DAO.insertProtocolList", map);
	}
	
	//protocol 정보 수정
	public void updateProtocolList(Map<String, Object> map) {
		update("CTMR01DAO.updateProtocolList", map);
	}
	
	public void deleteProtocolList(Map<String, Object> map) {
		update("CTMR01DAO.deleteProtocolList", map);
	}
}

