package pantheon.sdb.c02.service;

import java.util.List;
import java.util.Map;

import org.antlr.grammar.v3.ANTLRParser.exceptionGroup_return;




/**
 * @author ksm1118
 *
 */
public interface SDBC02Service {
	

	/**
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
//	public void insertMul(String code, String kor, String eng) throws Exception;
	
	/**
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
//	public void updateMul(String code, String kor, String eng) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertReason(Map<String, String> map) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertNarrativeInfo(Map<String, String> map)throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectNarrativeInfo(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> slSource(Map<String, String> param)throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertDemographics(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDemographics(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectFollow(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSiteSubject(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectLabList(Map<String, String> param) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertLabInfo(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectLabListInfo(Map<String, Object> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDemographicsLab(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDemographicsMedi(Map<String, String> param) throws Exception;

	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMedicalList(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMedicalHistoryInfo (Map<String, Object> param) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertMedicalHistory(Map<String, String> map) throws Exception;

	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDrugHistory(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDrugHistoryInfo(Map<String, Object> param) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertDrugHistory(Map<String, String> map) throws Exception;

	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCasualityList(Map<String, String> map) throws Exception;

	/**
	 * @param list
	 * @throws Exception
	 */
	public void insertCasuality(List<Map<String, Object>> list) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertDrug(Map<String, String> map)throws Exception;

	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDrugList(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDrugInfo(Map<String, Object> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectAeList(Map<String, String> param)throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAeInfo(Map<String, String> param) throws Exception;


	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDemoAeInfo(Map<String, String> param) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertAe(Map<String, String> map) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	public void insertDemoAe(Map<String, String> map)throws Exception;

	public void insertTransfer(Map<String, String> map) throws Exception;

	public Map<String, String> insertFollowUp(Map<String, String> map) throws Exception;

	public List<Map<String, Object>> selectCaseListPop(Map<String, String> param)throws Exception;

	public Map<String, Object> selectDemographics_Case(Map<String, String> param) throws Exception;

	public void insertCasuality_T(Map<String, String> map) throws Exception;

	




	



}
