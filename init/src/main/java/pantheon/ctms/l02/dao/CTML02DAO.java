package pantheon.ctms.l02.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTML02DAO")
public class CTML02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTML02DAO.class);
    //To do List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGridByTodoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML02DAO.selectGridByTodoList", map);
	}
	//공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> 	selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML02DAO.selectCommonCodeList", map);
	}

   //Todo update
	public void updateGridByTodoList(Map<String, Object> map) {
		update("CTML02DAO.updateGridByTodoList", map);
	}
	
	//Todo insert
	public void insertGridByTodoList(Map<String, Object> map) {
		update("CTML02DAO.insertGridByTodoList", map);
	}
	
	//Todo insert
	public void deleteGridByTodoList(Map<String, Object> map) {
		update("CTML02DAO.deleteGridByTodoList", map);
	}
	
}

