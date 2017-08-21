package pantheon.ctms.v01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.ctms.v01.dao.CTMV01DAO;
import pantheon.ctms.v01.service.CTMV01Service;

@Service("CTMV01Service")
public class CTMV01ServiceImpl implements CTMV01Service{

	@Resource(name = "CTMV01DAO")
	private CTMV01DAO CTMV01DAO;
	
	@Resource(name = "CTMS_CO_IRB_SEQ")
	private EgovIdGnrService ctmsCoIrbSeq;
	
	@Override
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBBasicInfoList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectIRBCttpcList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBCttpcList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectIRBDlbrtctList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBDlbrtctList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectIRBRsrcctList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBRsrcctList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectIRBDlbrtList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBDlbrtList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectIRBSaeList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBSaeList(map);
	}

	@Override
	public List<Map<String, Object>> selectIRBInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMV01DAO.selectIRBInfoList(map);
	}


	@Override
	public void insertIRBBasicInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("IRB_BSIS_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBBasicInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBBasicInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteMasterIRBCttpcInfo(iMap);
				CTMV01DAO.deleteMasterIRBDlbrtctInfo(iMap);
				CTMV01DAO.deleteMasterIRBRsrcctInfo(iMap);
				CTMV01DAO.deleteMasterIRBDlbrtInfo(iMap);
				CTMV01DAO.deleteMasterIRBInfoInfo(iMap);
				CTMV01DAO.deleteMasterIRBSaeInfo(iMap);
				CTMV01DAO.deleteIRBBasicInfo(iMap);
			}
		}		
	}

	
	@Override
	public void insertIRBCttpcInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("CTTPC_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBCttpcInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBCttpcInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBCttpcInfo(iMap);
			}
		}		
	}


	@Override
	public void insertIRBDlbrtctInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("DLBRTCT_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBDlbrtctInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBDlbrtctInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBDlbrtctInfo(iMap);
			}
		}		
	}


	@Override
	public void insertIRBRsrcctInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("RSRCCT_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBRsrcctInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBRsrcctInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBRsrcctInfo(iMap);
			}
		}		
	}


	@Override
	public void insertIRBDlbrtInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("DLBRT_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBDlbrtInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBDlbrtInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBDlbrtInfo(iMap);
			}
		}		
	}


	@Override
	public void insertIRBInfoInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("E_IRB_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBInfoInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBInfoInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBInfoInfo(iMap);
			}
		}		
	}


	@Override
	public void insertIRBSaeInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("SAE_SN", ctmsCoIrbSeq.getNextStringId());
				CTMV01DAO.insertIRBSaeInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTMV01DAO.updateIRBSaeInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTMV01DAO.deleteIRBSaeInfo(iMap);
			}
		}		
	}


}
