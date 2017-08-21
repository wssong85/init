package pantheon.sdb.d02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBD02DAO")
public class SDBD02DAO extends EgovComAbstractDAO {
	public int selectReportDelayCount(Map<String, String> param) throws Exception{
		return (int) select("SDBD02DAO.selectReportDelayCount", param);
	}
	
	public List<Map<String, String>> selectReportDelayList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBD02DAO.selectReportDelayList", param);
	}
}
