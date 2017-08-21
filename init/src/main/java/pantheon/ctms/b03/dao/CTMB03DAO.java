package pantheon.ctms.b03.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;






import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMB03DAO")
public class CTMB03DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMB03DAO.class);
    
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNISTask_NoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB03DAO.selectNISTask_NoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAssignmentbyNisGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB03DAO.selectAssignmentbyNisGrid", map);
	}
		
	public void insertAssignmentbyNisGrid(Map<String, Object> map) {
		insert("CTMB03DAO.insertAssignmentbyNisGrid", map);
	}
	
	public void updateAssignmentbyNisGrid(Map<String, Object> map) {
		update("CTMB03DAO.updateAssignmentbyNisGrid", map);
	}
	
	public void deleteAssignmentbyNisGrid(Map<String, Object> map) {
		update("CTMB03DAO.deleteAssignmentbyNisGrid", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNisStatusGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB03DAO.selectNisStatusGrid", map);
	}

	
	
	
}

