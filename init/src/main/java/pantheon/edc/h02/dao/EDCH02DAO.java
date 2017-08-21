package pantheon.edc.h02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("EDCH02DAO")
public class EDCH02DAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public String selectEdcVer(Map<String, Object> param) throws Exception{
		return (String) select("EDCH02DAO.selectEdcVer", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLabSubjectList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCH02DAO.selectLabSubjectList", param);
	}
}
