package pantheon.iwrs.g01.service;

import java.util.List;
import java.util.Map;

public interface IWRG01Service {
	public List<Map<String, String>> selectTaskList(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectIwrsDesignList(Map<String, String> param) throws Exception;
	public String selectIwrsDesignerInfo(Map<String, String> param) throws Exception;
	public void insertIwrsDesignerInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectRandomizationList(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectVisitInfo(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectArmRaioInfo(Map<String, String> param) throws Exception;
	public String selectEdcVersion(Map<String, String> param)throws Exception;
	public String insertCodeCreat(Map<String, String> param) throws Exception;
	public int insertArmRatioInfo(Map<String, String> param) throws Exception;
	public void insertCodeConf(Map<String, String> param) throws Exception;
	public void insertRandomSeed(Map<String, String> param) throws Exception;
	public void insertRandomizationInfo(Map<String, String> param) throws Exception;
	public void test() throws Exception;
}
