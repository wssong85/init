package pantheon.sdb.f09.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBF09DAO")
public class SDBF09DAO extends EgovComAbstractDAO {
	public List<Map<String,String>> selectSopPart(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF09.selectSopPart", param);
	}
	
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF09.selectSopInfo", param);
	}
	
	public void insertSopInfo(Map<String, String> param) throws Exception{
		insert("SDBF09.insertSopInfo", param);
	}
	
	public void updateSopInfo(Map<String, String> param) throws Exception{
		update("SDBF09.updateSopInfo", param);
	}
	
	public void deleteSopInfo(Map<String, String> param) throws Exception{
		update("SDBF09.deleteSopInfo", param);
	}
}
