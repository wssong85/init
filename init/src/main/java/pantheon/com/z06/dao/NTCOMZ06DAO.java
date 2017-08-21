package pantheon.com.z06.dao;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import pantheon.com.utl.Util;

@Repository("NTCOMZ06DAO")
public class NTCOMZ06DAO extends EgovComAbstractDAO{
	
	@Resource(name="nonTransaction.sqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }
	
	/**
	 * ATRAIL 입력
	 * @param map
	 */
	public void insertCmDtaAtrail(Map<String, String> map) {
		insert("COMZ06DAO.insertCmDtaAtrail", map);
	}
	
	/**
	 * ATRAIL 입력 위한 각 테이블 조회
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDynamicTable(String str) {
		return (Map<String, Object>) select("COMZ06DAO.selectDynamicTable", str);
	}
	
	/**
	 * CLOB으로 지정된 컬럼에 대해 이력을 남긴다.
	 * @param map
	 * LABEL_NM (이력남길 컬럼 이름)
	 * MODULE (모듈이름)
	 * PK_NM (TABLE_PK 의 실제 값 (2개면 2개 넣고 1개면 1개 넣음, 컬럼간 구분자는 ","로 해야한다.))
	 * TABLE_PK (테이블의 PK (2개면 2개 넣고 1개면 1개 넣음, 컬럼간 구분자는 ","로 해야한다.)
	 * COLUMN_NM (CLOB 컬럼 이름)
	 * TABLE_NM (CLOB 컬럼있는 테이블)
	 * STRE_RESN_CODE ((입력시 필수 코드)01 신규 , 04 수정, 06 삭제)
	 * STRE_ETC_RESN (string 들어감 (이유))
	 * UPDTBFE_VALUE (이전값)
	 * AFTUPD_VALUE (이후값)
	 * @throws Exception
	 */
	public void insertCmDtaAtrailForClob(Map<String, String> map) throws Exception {

		if(Util.getUserMap() != null) {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("TASK_NO", Util.getUserMap().get("TASK_NO"));
		}
		
		
		insert("COMZ06DAO.insertCmDtaAtrailForClob", map);
	}

}
