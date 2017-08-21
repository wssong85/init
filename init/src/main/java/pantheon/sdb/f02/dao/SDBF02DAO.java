package pantheon.sdb.f02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBF02DAO")
public class SDBF02DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectLiteratureList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF02.selectLiteratureList", param);
	}
	
	public void insertLiteratureInfo(Map<String, String> param) throws Exception{
		insert("SDBF02.insertLiteratureInfo", param);
	}
	
	public void updateLiteratureInfo(Map<String, String> param)throws Exception{
		update("SDBF02.updateLiteratureInfo", param);
	}
	
	public void deleteLiteratureInfo(Map<String, String> param) throws Exception{
		update("SDBF02.deleteLiteratureInfo", param);
	}
	
	public int selectLiteratureSeq() throws Exception{
		return (int) select("SDBF02.selectLiteratureSeq");
	}
}
