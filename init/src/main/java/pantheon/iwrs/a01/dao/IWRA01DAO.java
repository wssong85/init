package pantheon.iwrs.a01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("IWRA01DAO")
public class IWRA01DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectNotification() throws Exception{
		return (List<Map<String, String>>) list("IWRA01DAO.selectNotification");
	}
}
