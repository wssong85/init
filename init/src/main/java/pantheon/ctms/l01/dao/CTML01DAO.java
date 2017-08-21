package pantheon.ctms.l01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 공통코드 관리를 위한 데이터 접근 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
@Repository("CTML01DAO")
public class CTML01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTML01DAO.class);

    //공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectComCodeList", map);
	}
	
    //CRA 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRAList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectCRAList", map);
	}
	
    //과제 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectInsttList", map);
	}	

    //Milestone 계획 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMileStonePlanList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectMileStonePlanList", map);
	}

	//Milestone 계획 입력
	public void insertMileStonePlanInfo(Map<String, Object> map) {
		insert("CTML01DAO.insertMileStonePlanInfo", map);
	}
	

	//Milestone 계획 수정
	public void updateMileStonePlanInfo(Map<String, Object> map) {
		update("CTML01DAO.updateMileStonePlanInfo", map);
	}
	
	//Milestone 계획 삭제
	public void deleteMileStonePlanInfo(Map<String, Object> map) {
		update("CTML01DAO.deleteMileStonePlanInfo", map);
	}


    //과제정보 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMilestoneColWidthInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTML01DAO.selectMilestoneColWidthInfo", map);
	}
	
	//과제정보 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTaskInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTML01DAO.selectTaskInfo", map);
	}

    //과제정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMilestoneYearInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectMilestoneYearInfo", map);
	}
	
    //과제정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMilestonerPlanBarList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTML01DAO.selectMilestonerPlanBarList", map);
	}

}
