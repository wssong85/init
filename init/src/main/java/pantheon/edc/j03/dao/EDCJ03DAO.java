package pantheon.edc.j03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

	/**
	 * Report AE 목록을 위한 데이터 접근 클래스
	 * @author 오동근
	 * @since 2016.03.16
	 * @version 1.0
	 * @see
	 * 
	 *   수정일      수정자          수정내용
	 *  -------    --------    ---------------------------
	 *  2016.03.16  오동근          최초 생성
	 *  
	 */
@Repository("EDCJ03DAO")
public class EDCJ03DAO extends EgovComAbstractDAO {
	
	/**
	 * Report AE 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAeList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCJ03DAO.selectAeList", param);
	}

}
