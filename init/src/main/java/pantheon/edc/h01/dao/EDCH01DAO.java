package pantheon.edc.h01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("EDCH01DAO")
public class EDCH01DAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDmFileDetailList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCH01DAO.selectDmFileDetailList", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcLabDtaList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCH01DAO.selectEdcLabDtaList", param);
	}
	
	/**
	 * 양식 다운로드
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectLabTemplate(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("EDCH01DAO.selectLabTemplate", param);
	}
	
	/**
	 * 기관양식 순번 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectInsttFormSn(Map<String, Object> param) throws Exception{
		return (String) select("EDCH01DAO.selectInsttFormSn", param);
	}
	
	/**
	 * SUBJECT_NO 건수 조회(유무)
	 * @param subjectNo
	 * @return
	 * @throws Exception
	 */
	public int selectSubjectNoCount(String subjectNo) throws Exception{
		return (int) select("EDCH01DAO.selectSubjectNoCount", subjectNo);
	}
	
	/**
	 * STUDY NO 건수 조회(유무)
	 * @param subjectNo
	 * @return
	 * @throws Exception
	 */
	public int selectStydyNoCount(String subjectNo) throws Exception{
		return (int) select("EDCH01DAO.selectStydyNoCount", subjectNo);
	}
	
	/**
	 * 실험실 명 건수 조회(유무)
	 * @param subjectNo
	 * @return
	 * @throws Exception
	 */
	public int selectLabCount(String subjectNo) throws Exception{
		return (int) select("EDCH01DAO.selectLabCount", subjectNo);
	}
	
	/**
	 * 방문 건수 조회(유무)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectVisitCount(Map<String, String> param) throws Exception{
		return (int) select("EDCH01DAO.selectVisitCount", param);
	}
	
	/**
	 * AnalysisParameter 조회(유무) 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectAnalParamCount(Map<String, String> param) throws Exception{
		return (int) select("EDCH01DAO.selectAnalParamCount", param);
	}
	
	public int selectCfGroupCount(Map<String, Object> param) throws Exception{
		return (int) select("EDCH01DAO.selectCfGroupCount", param);
	}
	
	public int selectCfRowCount(Map<String, Object> param) throws Exception{
		return (int) select("EDCH01DAO.selectCfRowCount", param);
	}
	
	public int selectCfVriablCount(Map<String, Object> param) throws Exception{
		return (int) select("EDCH01DAO.selectCfVriablCount", param);
	}
	
	/**
	 * EDC_LAB_DTA_FILE 테이블에 INSERT
	 * @param map
	 * @throws Exception
	 */
	public void insertLabDataFile(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.insertLabDataFile", map);
	}
	
	/**
	 * EDC_LAB_DTA 테이블에 INSERT
	 * @param map
	 * @throws Exception
	 */
	public void insertLabData(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.insertLabData", map);
	}
	
	/**
	 * EDC_LAB_DTA Select
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLabDta(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>) list("EDCH01DAO.selectLabDta", map);
	}
	
	/**
	 * VRIABL 중 나이에 대한 값을 가져온다. 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectAgeVriablValue(Map<String, Object> map) throws Exception{
		return (String) select("EDCH01DAO.selectAgeVriablValue", map);
	}
	
	/**
	 * VRIABL 중 성별에 대한 값을 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectSexVriablValue(Map<String, Object> map) throws Exception{
		return (String) select("EDCH01DAO.selectSexVriablValue", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectVriablKey(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) select("EDCH01DAO.selectVriablKey", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNorValue(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) select("EDCH01DAO.selectNorValue", map);
	}
	
	public void insertCfGroup(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.insertCfGroup", map);
	}
	
	public void insertCfRow(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.insertCfRow", map);
	}
	
	public void insertCfVraiabl(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.insertCfVraiabl", map);
	}
	
	public void updateCfVriabl(Map<String, Object> map) throws Exception{
		insert("EDCH01DAO.updateCfVriabl", map);
	}
	
	public void updateLabDtaFile(Map<String, Object> map) throws Exception{
		update("EDCH01DAO.updateLabDtaFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLabDetailData(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) select("EDCH01DAO.selectLabDetailData", map);
	}
	
}
