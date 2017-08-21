package pantheon.sdb.c02.service;

import java.util.Map;

public interface MultiLangManageService {
//	public insertMul()
	/**
	 * 다국어 입력
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
	public void insertMul(String code, String kor, String eng) throws Exception;
	
	/**
	 * 다국어 수정
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
	public void updateMul(String code, String kor, String eng) throws Exception;
	
	/**
	 * @param kor
	 * @param eng
	 * @param colName
	 * @param iMap
	 * @throws Exception
	 */
	public void mullangInsert (String kor, String eng, String colName,  Map<String, String> iMap) throws Exception;
	
	/**
	 * @param code
	 * @param kor
	 * @param eng
	 * @param colName
	 * @param iMap
	 * @throws Exception
	 */
	public void mullangUpdate (String code, String kor, String eng, String colName,  Map<String, String> iMap) throws Exception;
}
