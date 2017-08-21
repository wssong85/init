package pantheon.sdb.f04.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * SOP 등록 관리를 위한 데이터 접근 클래스
 * @author 이원민
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17   이원민                    최초 생성
 *  
 */
@Repository("SDBF04DAO")
public class SDBF04DAO extends EgovComAbstractDAO {
	
	/**
	 * SOP 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertSopInfo(Map<String, String> param) throws Exception{
		insert("SDBF04.insertSopInfo", param);
	}
	
	/**
	 * SOP 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateSopInfo(Map<String, String> param) throws Exception{
		update("SDBF04.updateSopInfo", param);
	}
	
	/**
	 * SOP 정보 조회 
	 * @param param
	 * @return List<Map<String, String>>
	 */
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception{
		return (ArrayList<Map<String, String>>)list("SDBF04.selectSopInfo", param);
	}
	
	/**
	 * 등록된 첨부파일 개별 삭제 
	 * @param param
	 * @return
	 */
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		delete("SDBF04.deleteFileInfo", param);
	}
	
	/**
	 * 등록된 SOP 정보 삭제 
	 * @param param
	 * @return
	 */
	public void deleteSopInfo(Map<String, String> param) throws Exception{
		update("SDBF04.deleteSopInfo", param);
	}
}
