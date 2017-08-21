package pantheon.sdb.f08.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SDBF08DAO")
public class SDBF08DAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReconciliationList(
			Map<String, String> map) {
		
		return (List<Map<String, Object>>) list("SDBF08DAO.selectReconciliationList", map);
	}

}
