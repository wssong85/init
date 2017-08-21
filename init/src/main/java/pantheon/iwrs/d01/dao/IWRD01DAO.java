package pantheon.iwrs.d01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * ip 현황 관리를 위한 데이터 접근 클래스
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
@Repository("IWRD01DAO")
public class IWRD01DAO extends EgovComAbstractDAO {
	
	/**
	 * IP 현황 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDrugStockInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRD01.selectDrugStockInfo", param);
	}
}
