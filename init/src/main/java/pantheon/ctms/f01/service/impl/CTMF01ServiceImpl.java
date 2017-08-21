package pantheon.ctms.f01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.ctms.f01.dao.CTMF01DAO;
import pantheon.ctms.f01.service.CTMF01Service;

@Service("CTMF01Service")
public class CTMF01ServiceImpl implements CTMF01Service{

	@Resource(name = "CTMF01DAO")
	private CTMF01DAO ctmf01DAO;
	
	
	@Override
	public List<Map<String, Object>> selectPaperContractList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectPaperContractList(map);
	}

	@Override
	public void deleteTaskUserRoleInfo(List<Map<String, Object>> list)
			throws Exception {
		// TODO Auto-generated method stub
		for(Map<String, Object> iMap : list) {
			ctmf01DAO.deleteTaskUserRoleInfo(iMap);
		}
	}
	
	@Override
	public void insertPaperContractByCNT(List<Map<String, Object>> list) 
			throws Exception {
		
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				if(iMap.get("INSTT_CODE") == null || iMap.get("INSTT_CODE") == ""){
					ctmf01DAO.insertCM_INSTT(iMap);
				}				
				ctmf01DAO.insertPaperContractByCNT(iMap); //계약정보
				ctmf01DAO.insertPaperContractByUSER(iMap);				
				ctmf01DAO.insertPaperContractByRSRCHUSER(iMap);
				ctmf01DAO.insertTaskUserInfo(iMap);
				ctmf01DAO.insertUserRoleInfo(iMap);
				ctmf01DAO.insertTaskUserRoleInfo(iMap);
				
				
			}else{
				ctmf01DAO.updatePaperContractByCNT(iMap);
				ctmf01DAO.updatePaperContractByUSER(iMap);
				ctmf01DAO.updatePaperContractByRSRCHUSER(iMap);
				
			}
			
		}		
	}
	
	/**
	 * 중복체크조회
	 */
	@Override
	public List<Map<String, Object>> selectRsrchUserOverlap(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectRsrchUserOverlap(map);
	}

	@Override
	public List<Map<String, Object>> selectContractPopUpList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectContractPopUpList(map);
	}
	
	//IRB여부 공통코드 조회
	@Override
	public List<Map<String, Object>> selectCommonCodeListByIRB_AT(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectCommonCodeListByIRB_AT(map);
	}
	
	//상태 공통코드 조회
	@Override
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectCommonCodeListBySTTUS(map);
	}
	/*------------------------------------------------------------------------------------------------------------------*/
	@Override
	public List<Map<String, Object>> selectTotalContractList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectTotalContractList(map);
	}

	@Override
	public List<Map<String, Object>> selectElectContractList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmf01DAO.selectElectContractList(map);
	}

	@Override
	public void updateElectContractStatus(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			ctmf01DAO.updateElectContractStatus(iMap);		
		}		
	}

	

	














}
