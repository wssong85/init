package pantheon.sdb.f05.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 교육이수리스트 등록 관리를 위한 데이터 접근 클래스
 * @author 이원민
 * @since 2016.03.22
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.2   이원민                    최초 생성
 *  
 */
@Repository("SDBF05DAO")
public class SDBF05DAO extends EgovComAbstractDAO {
	
	/**
	 * 교육이수리스트 정보 조회 
	 * @param param
	 * @return List<Map<String, String>>
	 */
	public List<Map<String, String>> selectEducationInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("SDBF05.selectEducationInfo", param);
	}
	
	/**
	 * 교육이수리스트 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertEducationInfo(Map<String, String> param) throws Exception{
		insert("SDBF05.insertEducationInfo", param);
	}
	
	/**
	 * 교육이수리스트 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateEducationInfo(Map<String, String> param) throws Exception{
		update("SDBF05.updateEducationInfo", param);
	}
	
	/**
	 * 등록된 첨부파일 개별 삭제 
	 * @param param
	 * @return
	 */
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		delete("SDBF05.deleteFileInfo", param);
	}
	
	/**
	 * 등록된 교육이수 리스트 정보 삭제 
	 * @param param
	 * @return
	 */
	public void deleteEducationInfo(Map<String, String> param) throws Exception{
		update("SDBF05.deleteEducationInfo", param);
	}
}
