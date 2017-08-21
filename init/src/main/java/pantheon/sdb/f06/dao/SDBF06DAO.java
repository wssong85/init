package pantheon.sdb.f06.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 전자이력서 등록 관리를 위한 데이터 접근 클래스
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
@Repository("SDBF06DAO")
public class SDBF06DAO extends EgovComAbstractDAO {
	
	/**
	 * 전자이력서 정보 조회 
	 * @param param
	 * @return List<Map<String, String>>
	 */
	public List<Map<String, String>> selectResumeInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("SDBF06.selectResumeInfo", param);
	}
	
	/**
	 * 전자이력서 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertResumeInfo(Map<String, String> param) throws Exception{
		insert("SDBF06.insertResumeInfo", param);
	}
	
	/**
	 * 전자이력서 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateResumeInfo(Map<String, String> param) throws Exception{
		update("SDBF06.updateResumeInfo", param);
	}
	
	/**
	 * 등록된 첨부파일 개별 삭제 
	 * @param param
	 * @return
	 */
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		delete("SDBF06.deleteFileInfo", param);
	}
	
	/**
	 * 등록된 전자이력서 정보 삭제 
	 * @param param
	 * @return
	 */
	public void deleteResumeInfo(Map<String, String> param) throws Exception{
		update("SDBF06.deleteResumeInfo", param);
	}
}
