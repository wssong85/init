package pantheon.iwrs.d03.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.iwrs.d03.dao.IWRD03DAO;
import pantheon.iwrs.d03.service.IWRD03Service;

/**
 * IP Error Log 처리하는 비지니스 구현 클래스
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
@Service("IWRD03Service")
public class IWRD03ServiceImpl implements IWRD03Service {
	@Resource(name = "IWRD03DAO")
	private IWRD03DAO iwrd03Dao;
	
	public List<Map<String, String>> selectErrorLog(Map<String, String> param) throws Exception{
		return iwrd03Dao.selectErrorLog(param); 
	}
}
