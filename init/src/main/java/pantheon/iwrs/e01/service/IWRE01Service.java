package pantheon.iwrs.e01.service;

import java.util.List;
import java.util.Map;

public interface IWRE01Service {
	public List<Map<String, String>> selectVisitLabel(Map<String, String> param) throws Exception;
	public int selectDispenseCnt(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectDispenseList(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectSubjectList(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectDispenseListForSubject(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectDispenseForView(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectDispenseReturnInfo(Map<String, String> param) throws Exception;
	public void insertDispenseInfo(Map<String, String> param) throws Exception;
	public void updateDispenseInfo(Map<String, String> param) throws Exception;
	public void updateReturnInfo(Map<String, String> param) throws Exception;
	public void updateConfirmInfo(Map<String, String> param) throws Exception;
	public void updateErrorInfo(Map<String, String> param) throws Exception;
	public void insertQuery(Map<String, String> param) throws Exception;
	public void updateQuery(Map<String, String> param) throws Exception;
	public void updateEndQuery(Map<String, String> param) throws Exception;
	public void insertEndQueryInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception;
	public void insertAnswerQueryInfo(Map<String, String> param )throws Exception;
}
