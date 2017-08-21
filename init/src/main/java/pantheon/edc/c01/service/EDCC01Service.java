package pantheon.edc.c01.service;

import java.util.List;
import java.util.Map;

public interface EDCC01Service {

	public List<Map<String, Object>> selectEdcSubjectList(Map<String, Object> param) throws Exception;

	public String selectEdcSubjectListCount(Map<String, Object> param) throws Exception;

	public Map<String, Object> insertSubject(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectSubjectMenuList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisitList(Map<String, Object> param) throws Exception;

	public String selectVisitListCount(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisitViewList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisitViewSnList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisitViewHeaderList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCRFVisitList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCRFLayoutList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCRFCommentList(Map<String, Object> param) throws Exception;

	public void insertCRFValue(Map<String, Object> param) throws Exception;

	public void insertCRFQuery(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectGroupInfo(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCRFQueryList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectCRFSDVList(Map<String, Object> param) throws Exception;

	public void insertSDVList(List<Map<String, Object>> list) throws Exception;

	public void insertSDVcompletion(Map<String, Object> param) throws Exception;

	public void updateCRFSign(Map<String, String> map) throws Exception;

	public List<Map<String, Object>> selectPatientList(Map<String, Object> param) throws Exception;

	public void updatePatientList(List<Map<String, Object>> list) throws Exception;

}
