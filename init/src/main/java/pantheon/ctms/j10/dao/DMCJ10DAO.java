package pantheon.ctms.j10.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ10DAO")
public class DMCJ10DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ10DAO.class);
    //계약 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectContractList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ10DAO.selectContractList", map);
	}
	
	//IRB유무 공통코드 조회
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> selectCommonCodeListByIRB_AT(Map<String, String> map) {
			return (List<Map<String, Object>>) list("DMCJ10DAO.selectCommonCodeListByIRB_AT", map);
		}
		
	//계약구분 공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeListByCNTRCT_SE(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ10DAO.selectCommonCodeListByCNTRCT_SE", map);
	}
	
	//상태 공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ10DAO.selectCommonCodeListBySTTUS", map);
	}
	
		
}

