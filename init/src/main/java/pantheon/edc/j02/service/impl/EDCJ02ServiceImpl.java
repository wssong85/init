package pantheon.edc.j02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.edc.c01.dao.EDCC01DAO;
import pantheon.edc.j02.dao.EDCJ02DAO;
import pantheon.edc.j02.service.EDCJ02Service;

/**
 * Report Comment 목록을 처리하는 비지니스 구현 클래스
 * @author 오동근
 * @since 2016.03.14
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.14  오동근          최초 생성
 *  
 */
@Service("EDCJ02Service")
public class EDCJ02ServiceImpl implements EDCJ02Service{
	
	@Resource(name = "EDCJ02DAO")
    EDCJ02DAO edcj02DAO;
	
	@Resource(name = "EDCC01DAO")
	EDCC01DAO edccDao;

	@Override
	public List<Map<String, Object>> selectAtrailList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";
		
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);
		return edcj02DAO.selectAtrailList(param);
	}

}
