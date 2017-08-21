package pantheon.com.e01.dao;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("NTCOME01DAO")
public class NTCOME01DAO extends EgovComAbstractDAO{
	
	@Resource(name="nonTransaction.sqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }
	
	public void insertCmIntrfc(Map<String, String> map) {
		insert("NTCOME01DAO.insertCmIntrfc", map);
	}
	
}
