package pantheon.edc.j01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EDCJ01DAO")
public class EDCJ01DAO extends EgovComAbstractDAO{
	
	/**
	 * 이상반응 신속보고 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSaeRep(Map<String, Object> param)	throws Exception {
		return (Map<String, Object>) select("EDCJ01DAO.selectSaeRep", param);
	}
	
	/**
	 * 이상반응 신속보고 상세 이상약물반응 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSaeRepAetList(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("EDCJ01DAO.selectSaeRepAetList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 약물정보 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepDreAList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepDreAList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 기타병용약물 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepDreBList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepDreBList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 주요 병력 및 동반 질환 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepHstcsList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepHstcsList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 이상약물반응 관련 약물 과거력 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepDreHstcsList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepDreHstcsList", map);
	}
	
	/**
	 * 이상반응 신속보고 상세 원인규명을 위한 검사 결과 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSaeRepInspctList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) list("EDCJ01DAO.selectSaeRepInspctList", map);
	}
	
	/**
	 * 이상반응 신속보고 이상약물반응이 현재 보고서 키값으로 있는지 없는지 count 조회.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectRmAetCnt(Map<String, Object> param) throws Exception {
		return (int) select("EDCJ01DAO.selectRmAetCnt", param);
	}
	
	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateSaeList(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.updateSaeList", param);
	}
	
	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void insertRmAet(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.insertRmAet", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateRmAet(Map<String, Object> param) throws Exception {
		update("EDCJ01DAO.updateRmAet", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void insertRepDre(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.insertRepDre", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateRepDre(Map<String, Object> param) throws Exception {
		update("EDCJ01DAO.updateRepDre", param);
	}
	
	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void insertRepHstcs(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.insertRepHstcs", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateRepHstcs(Map<String, Object> param) throws Exception {
		update("EDCJ01DAO.updateRepHstcs", param);
	}
	
	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void insertRepDreHstcs(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.insertRepDreHstcs", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateRepDreHstcs(Map<String, Object> param) throws Exception {
		update("EDCJ01DAO.updateRepDreHstcs", param);
	}
	
	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void insertRepInspct(Map<String, Object> param) throws Exception {
		insert("EDCJ01DAO.insertRepInspct", param);
	}

	/**
	 * 이상반응 신속보고 보고서 테이블 update
	 * @param param
	 * @throws Exception
	 */
	public void updateRepInspct(Map<String, Object> param) throws Exception {
		update("EDCJ01DAO.updateRepInspct", param);
	}

}
