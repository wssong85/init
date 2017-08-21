package pantheon.edc.k05.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 공통코드 관리를 위한 데이터 접근 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
@Repository("EDCK05DAO")
public class EDCK05DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(EDCK05DAO.class);

    //IRB 기초 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCK05DAO.selectIRBBasicInfoList", map);
	}

    //IRB 기초 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBBasicEndInfoList(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCK05DAO.selectIRBBasicEndInfoList", map);
	}
	
	//IRB 기초 정보 수정
	public void updateIRBBasicInfo(Map<String, Object> map) {
		update("EDCK05DAO.updateIRBBasicInfo", map);
	}
	
    //old 과제별 역할권한 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOldTaskByBtnList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("EDCK05DAO.selectOldTaskByBtnList", map);
	}	
}
