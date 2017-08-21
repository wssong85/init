package pantheon.ctms.z13.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

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
@Repository("CTMZ13DAO")
public class CTMZ13DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMZ13DAO.class);

    //IRB 기초 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ13DAO.selectIRBBasicInfoList", map);
	}

	//IRB 기초 정보 입력
	public void insertIRBBasicInfo(Map<String, Object> map) {
		insert("CTMZ13DAO.insertIRBBasicInfo", map);
	}
	
	//IRB 기초 정보 수정
	public void updateIRBBasicInfo(Map<String, Object> map) {
		update("CTMZ13DAO.updateIRBBasicInfo", map);
	}

    //IRB 기초 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ13DAO.selectUserInfoList", map);
	}
	
	//IRB 기초 정보 삭제
	public void deleteIRBBasicInfo(Map<String, Object> map) {
		update("CTMZ13DAO.deleteIRBBasicInfo", map);
	}

}
