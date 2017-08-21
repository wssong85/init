package pantheon.com.sample.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;


import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
//import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
//import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("SampleDAO")
public class SampleDAO extends EgovComAbstractDAO{
	public void insertSample(Map<String, String> param) {
		insert("SampleDAO.insertSample", param);
	}
	public void insertSample2(Map<String, String> param) {
		insert("SampleDAO.insertSample2", param);
	}
	
}
