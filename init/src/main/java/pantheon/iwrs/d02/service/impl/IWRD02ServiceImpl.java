package pantheon.iwrs.d02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.iwrs.d02.dao.IWRD02DAO;
import pantheon.iwrs.d02.service.IWRD02Service;

/**
 * ip현황(약국) 처리하는 비지니스 구현 클래스
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
@Service("IWRD02Service")
public class IWRD02ServiceImpl implements IWRD02Service {
	@Resource(name = "IWRD02DAO")
	private IWRD02DAO iwrd02Dao;
	
	@Override
	public List<Map<String, String>> selectDrugStock(Map<String, String> param) throws Exception{
		return iwrd02Dao.selectDrugStock(param);
	}
}
