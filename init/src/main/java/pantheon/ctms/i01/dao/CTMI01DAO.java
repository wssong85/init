package pantheon.ctms.i01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMI01DAO")
public class CTMI01DAO extends EgovComAbstractDAO{
	
    //milestone List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalMilestoneList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMI01DAO.selectCalMilestoneList", map);
	}

}
