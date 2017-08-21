package pantheon.iwrs.d02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * ip현황(약국) 관리를 위한 데이터 접근 클래스
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
@Repository("IWRD02DAO")
public class IWRD02DAO extends EgovComAbstractDAO {
	
	/**
	 * IP현황(약국) 리스트 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDrugStock(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>)list("IWRD02.selectDrugStock", param);
	}
}
