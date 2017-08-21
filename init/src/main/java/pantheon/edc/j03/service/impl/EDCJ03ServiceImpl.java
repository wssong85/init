package pantheon.edc.j03.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.edc.j03.dao.EDCJ03DAO;
import pantheon.edc.j03.service.EDCJ03Service;

/**
 * Report AE 목록을 처리하는 비지니스 구현 클래스
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
@Service("EDCJ03Service")
public class EDCJ03ServiceImpl implements EDCJ03Service{
	
	@Resource(name = "EDCJ03DAO")
    EDCJ03DAO edcj03DAO;

	@Override
	public List<Map<String, Object>> selectAeList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj03DAO.selectAeList(param);
	}

}
