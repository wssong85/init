package pantheon.com.h01.dao;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("NTCOMH01DAO")
public class NTCOMH01DAO extends EgovComAbstractDAO{

	@Resource(name="nonTransaction.sqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }
	
	public int updateCmUserForAcntLockAt(Map<String, String> map) {
		return update("NTCOMH01DAO.updateCmUserForAcntLockAt", map);
	}

}
