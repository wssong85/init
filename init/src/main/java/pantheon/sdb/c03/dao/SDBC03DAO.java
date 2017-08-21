package pantheon.sdb.c03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository
public class SDBC03DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectUploadHistory(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBC03DAO.selectUploadHistory", param);
	}
}
