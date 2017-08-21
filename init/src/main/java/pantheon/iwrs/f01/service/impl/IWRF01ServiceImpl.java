package pantheon.iwrs.f01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.iwrs.f01.dao.IWRF01DAO;
import pantheon.iwrs.f01.service.IWRF01Service;

@Service("IWRF01Service")
public class IWRF01ServiceImpl implements IWRF01Service {
	@Resource(name = "IWRF01DAO")
	private IWRF01DAO iwrf01Dao;
	
	@Override
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception{
		return iwrf01Dao.selectQueryList(param);
	}
	
	@Override
	public int selectQueryCnt(Map<String, String> param) throws Exception{
		return iwrf01Dao.selectQueryCnt(param);
	}
	
	@Override
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception{
		return iwrf01Dao.selectQueryInfo(param);
	}
}
