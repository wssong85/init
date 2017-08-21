package pantheon.ctms.c01.dao;

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
@Repository("CTMC01DAO")
public class CTMC01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMC01DAO.class);

    //시험기간 정보
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInvestInfoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMC01DAO.selectInvestInfoList", map);
	}
	


}
