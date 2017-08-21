package pantheon.sdb.g01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("SDBG01DAO")
public class SDBG01DAO  extends EgovComAbstractDAO{
	/**
	 * 다국어 등록
	 * 
	 * @param map
	 * @return
	 */
	public void insertMul(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		System.out.println(iMap);
		insert("SDBC02DAO.insertMul", iMap);
	}
	
	/**
	 * 다국어 수정
	 * 
	 * @param map
	 * @return
	 */
	public void updateMul(Map<String, String> iMap) {
		// TODO Auto-generated method stub
		System.out.println(iMap);
		update("SDBC02DAO.updateMul", iMap);
	}




}
