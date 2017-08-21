package pantheon.edc.i01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import pantheon.com.utl.Util;

/**
 * Blind 관리를 위한 데이터 접근 클래스
 * @author 오동근
 * @since 2016.03.03
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.03  오동근          최초 생성
 *  
 */
@Repository("EDCI01DAO")
public class EDCI01DAO extends EgovComAbstractDAO {
	/**
	 * Blind 목록(연구자)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResearchSubjectList(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCI01DAO.selectResearchSubjectList", param);
	}
	
	/**
	 * Blind 목록(현업)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFieldSubjectList(Map<String, Object> param)	throws Exception {
		return (List<Map<String, Object>>) list("EDCI01DAO.selectFieldSubjectList", param);
	}


	/**
	 * Task BlindPk 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTaskBlindPk(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) select("EDCI01DAO.selectTaskBlindPk", map);
	}
	
	public int updateEdcCfSubjectByInfo(Map<String, Object> map) {
		return update("EDCI01DAO.updateEdcCfSubjectByInfo", map);
	}

	/**
	 * Sanctn Request 입력
	 * 
	 * @param map
	 * @return
	 */
	public void insertEdcSanctnRequstByEdcSanClineDetailInfo(Map<String, Object> map) {
		insert("EDCI01DAO.insertEdcSanctnRequstByEdcSanClineDetailInfo", map);
	}

	/**
	 * Sanctn Process 입력
	 * 
	 * @param map
	 * @return
	 */
	public void insertCmSanctnProcessByCmSanClineDetailInfo(Map<String, Object> map) {
		insert("COMD09DAO.insertCmSanctnProcessByCmSanClineDetailInfo", map);
	}
	
	public List<Map<String, Object>> selectCmSanclineDetailInfo(Map<String, Object> map){
		return (List<Map<String, Object>>)list("EDCI01DAO.selectCmSanclineDetailInfo", map);
	}
	
	/**
	 * 눈가림 해제 승인 popup 창 select
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCfSubject(Map<String, Object> param)	throws Exception {
		return (Map<String, Object>) select("EDCI01DAO.selectCfSubject", param);
	}
	

	/**
	 * 눈가림 해제 승인번호 check
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int selectRelisConfmNoInfo(Map<String, String> param) throws Exception{
		return (int) select("EDCI01DAO.selectRelisConfmNoInfo", param);
	}
	
	/**
	 * /눈가림 해제 승인번호 입력 popup 창 update
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateEdcCfSubjectByBlindSttusCd(Map<String, Object> param) {
		update("EDCI01DAO.updateEdcCfSubjectByBlindSttusCd", param);
	}
	

	/**
	 * 결제상태 확인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectSanctnRequstSttus(Map<String, String> param) throws Exception{
		return (Map<String, String>) select("EDCI01DAO.selectSanctnRequstSttus", param);
	}
	

	/**
	 * 결제상태 확인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectSendInfo(Map<String, String> param) throws Exception{
		return (Map<String, String>) select("EDCI01DAO.selectSendInfo", param);
	}

	/**
	 * 결재선의 기안자 강제 insert
	 * 
	 * @param map
	 * @return
	 */
	public void insertCmSanctnProcessDraft(Map<String, Object> map) {
		insert("EDCI01DAO.insertCmSanctnProcessDraft", map);
	}
	
	/**
	 * CM_SANCLINE_DETAIL Table Data 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCmSanclineDetail(Map<String, Object> map){
		return (List<Map<String, Object>>)list("EDCI01DAO.selectCmSanclineDetail", map);
	}
	
	/**
	 * /눈가림 즉시해제 인증번호 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateEdcCfSubjectByCnfmNo(Map<String, String> param) {
		update("EDCI01DAO.updateEdcCfSubjectByCnfmNo", param);
	}
	
	public String selectCmSanctnProcessBySeq(){
		return (String)select("EDCI01DAO.selectCmSanctnProcessBySeq", null);
	}

}
