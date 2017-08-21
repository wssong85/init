package pantheon.iwrs.d01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.iwrs.d01.dao.IWRD01DAO;
import pantheon.iwrs.d01.service.IWRD01Service;

/**
 * ip현황 처리하는 비지니스 구현 클래스
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
@Service("IWRD01Service")
public class IWRD01ServiceImpl implements IWRD01Service {
	@Resource(name = "IWRD01DAO")
	private IWRD01DAO iwrd01Dao;
	
	public List<Map<String, String>> selectDrugStockInfo(Map<String, String> param) throws Exception{
		return iwrd01Dao.selectDrugStockInfo(param);
	}
}
