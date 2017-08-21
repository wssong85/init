package pantheon.iwrs.f01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("IWRF01DAO")
public class IWRF01DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("IWRF01DAO.selectQueryList", param);
	}
	
	public int selectQueryCnt(Map<String, String> param) throws Exception{
		return (int) select("IWRF01DAO.selectQueryCnt", param);
	}
	
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRF01DAO.selectQueryInfo", param);
	}
}
