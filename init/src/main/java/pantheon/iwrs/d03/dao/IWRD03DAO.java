package pantheon.iwrs.d03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * IP Error Log 관리를 위한 데이터 접근 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
@Repository("IWRD03DAO")
public class IWRD03DAO extends EgovComAbstractDAO {
	
	/**
	 * IP Error Log 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectErrorLog(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>)list("IWRD03.selectErrorLog", param);
	}
}
