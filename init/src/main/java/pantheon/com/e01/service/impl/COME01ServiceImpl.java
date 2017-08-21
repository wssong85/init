package pantheon.com.e01.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.e01.dao.COME01DAO;
import pantheon.com.e01.dao.NTCOME01DAO;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COME01Service")
public class COME01ServiceImpl implements COME01Service{

	@Resource(name = "COME01DAO")
	private COME01DAO come01DAO;
	
	@Resource(name = "NTCOME01DAO")
	private NTCOME01DAO ntcome01DAO;
	
	@Resource(name = "CM_INTRFC_SEQ")
	private EgovIdGnrService cmIntrfcSeq;
	
	@Resource(name = "ATRAIL_CM_JOBUSER")
	protected EgovPropertyService atrailCmJobUser;
	
	@Resource(name = "ATRAIL_CM_DEPTINFO")
	protected EgovPropertyService atrailCmDeptInfo;
	
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrailCmUser;
	
	@Resource(name = "ATRAIL_SAP_BCNC_INFO")
	protected EgovPropertyService atrailSapBcncInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(COME01ServiceImpl.class);
	
	@Override
	public void initialSapBcncTmpr() throws Exception {
		try {
			List<Map<String, Object>> sapBcncTmprList  = Util.setTrimByListObject(come01DAO.selectSapBcncTmprByBatch());
			for(int i = 0; i < sapBcncTmprList.size(); i++) {
				come01DAO.insertSapBcncInfoByBatch(sapBcncTmprList.get(i));
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "거래처정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
		} catch (Exception e) {
			LOGGER.debug(e.getLocalizedMessage());
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "거래처정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
	}
	
	@Override
	public void initialInfraDeptTmpr() throws Exception {
		try {
			List<Map<String, Object>> infraDeptTmprList = come01DAO.selectInfraDeptTmprByBatch();
			
			//입력
			for(int i = 0; i < infraDeptTmprList.size(); i++) {
				come01DAO.insertCmDeptInfo(infraDeptTmprList.get(i));
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "부서정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
		} catch (Exception e) {
			LOGGER.debug(e.getLocalizedMessage());
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "거래처정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
	}
	
	@Override
	public void initialInfraUserTmpr() throws Exception {
		try {
			List<Map<String, Object>> cmInfraUserTmprList = come01DAO.selectInfraUserTmprByBatch();
			
			Map<String, String> tmpMap = null;
			
			for(int i = 0; i < cmInfraUserTmprList.size(); i++) {
				
				tmpMap = new HashMap<String, String>();
				tmpMap.put("USER_ID", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CJ_ID")));
				tmpMap.put("COMP_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COMP_CD")));
				tmpMap.put("EMPL_NO", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMP_NO")));
				tmpMap.put("DEPT_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEPT_CD")));
				tmpMap.put("COST_CNTER", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COST_CD")));
				tmpMap.put("HFFC_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("WORK_YN")));
				tmpMap.put("CLSF_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("POSITION_CD")));
				tmpMap.put("ECNY_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("INS_DT")));
				tmpMap.put("RETIRE_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEL_DT")));
				tmpMap.put("DTY_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("JOB_CD")));
				tmpMap.put("DPRLR_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CHIEF_FLAG")));
				tmpMap.put("USER_NM", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMP_NM")));
				tmpMap.put("USER_ENGNM", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMP_ENG_NAME")));
				tmpMap.put("EMAIL", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMAIL")));
				tmpMap.put("TELNO", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("PHONE_NO")));
				
				if("".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEL_DT")))) {
					tmpMap.put("USE_YN", "Y");
				} else {
					tmpMap.put("USE_YN", "N");
				}
				
				tmpMap.put("PASSWORD", Util.getStrPasswordRnd());
				
				come01DAO.insertCmUserByBatch(tmpMap);
				come01DAO.insertCmJobUserByBatch(tmpMap);
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "사용자정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
		} catch (Exception e) {
			LOGGER.debug(e.getLocalizedMessage());
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "사용자정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
	}
	
	@Override
	public void batchSapBcncTmpr() throws Exception {
		if(!"Y".equals(come01DAO.selectCmSysEnvrnByEnvrnSe())) {
			return;
		}
		
		try {
			
			List<Map<String, Object>> sapBcncInfoList = Util.setTrimByListObject(come01DAO.selectSapBcncInfoByBatch());
			
			if(sapBcncInfoList.size() == 0) {
				initialSapBcncTmpr();
				come01DAO.deleteSapBcncTmprByBatch();
				return;
			}
			
			List<Map<String, Object>> sapBcncTmprList  = Util.setTrimByListObject(come01DAO.selectSapBcncTmprByBatch());
			
			//수정
			for(int i = 0; i < sapBcncTmprList.size(); i++) {
				
				for(int j = 0; j < sapBcncInfoList.size(); j++) {
					if(sapBcncTmprList.get(i).get("KUNNR").equals(sapBcncInfoList.get(j).get("KUNNR"))) {
						
						boolean bUpdate = false;
						StringBuffer sb = new StringBuffer();
						
						sb.append("UPDATE SAP_BCNC_INFO ");
						sb.append("   SET KUNNR = '" + sapBcncTmprList.get(i).get("KUNNR") +"'");
						
						if(!sapBcncTmprList.get(i).get("NAME1").equals(sapBcncInfoList.get(j).get("NAME1"))) {
							sb.append(" ,NAME1='" + sapBcncTmprList.get(i).get("NAME1").toString().trim()+ "'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("LAND1").equals(sapBcncInfoList.get(j).get("LAND1"))) {
							sb.append(" ,LAND1='" + sapBcncTmprList.get(i).get("LAND1").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("VTWEG").equals(sapBcncInfoList.get(j).get("VTWEG"))) {
							sb.append(" ,VTWEG='" + sapBcncTmprList.get(i).get("VTWEG").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("PSTLZ").equals(sapBcncInfoList.get(j).get("PSTLZ"))) {
							sb.append(" ,PSTLZ='" + sapBcncTmprList.get(i).get("PSTLZ").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("ORT01").equals(sapBcncInfoList.get(j).get("ORT01"))) {
							sb.append(" ,ORT01='" + sapBcncTmprList.get(i).get("ORT01").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("REGIO").equals(sapBcncInfoList.get(j).get("REGIO"))) {
							sb.append(" ,REGIO='" + sapBcncTmprList.get(i).get("REGIO").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("STRAS").equals(sapBcncInfoList.get(j).get("STRAS"))) {
							sb.append(" ,STRAS='" + sapBcncTmprList.get(i).get("STRAS").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("STCD1").equals(sapBcncInfoList.get(j).get("STCD1"))) {
							sb.append(" ,STCD1='" + sapBcncTmprList.get(i).get("STCD1").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("STCD2").equals(sapBcncInfoList.get(j).get("STCD2"))) {
							sb.append(" ,STCD2='" + sapBcncTmprList.get(i).get("STCD2").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("STCD3").equals(sapBcncInfoList.get(j).get("STCD3"))) {
							sb.append(" ,STCD3='" + sapBcncTmprList.get(i).get("STCD3").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("J_1KFREPRE").equals(sapBcncInfoList.get(j).get("J_1KFREPRE"))) {
							sb.append(" ,J_1KFREPRE='" + sapBcncTmprList.get(i).get("J_1KFREPRE").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("TELF1").equals(sapBcncInfoList.get(j).get("TELF1"))) {
							sb.append(" ,TELF1='" + sapBcncTmprList.get(i).get("TELF1").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("TELFX").equals(sapBcncInfoList.get(j).get("TELFX"))) {
							sb.append(" ,TELFX='" + sapBcncTmprList.get(i).get("TELFX").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("J_1KFTBUS").equals(sapBcncInfoList.get(j).get("J_1KFTBUS"))) {
							sb.append(" ,J_1KFTBUS='" + sapBcncTmprList.get(i).get("J_1KFTBUS").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("J_1KFTIND").equals(sapBcncInfoList.get(j).get("J_1KFTIND"))) {
							sb.append(" ,J_1KFTIND='" + sapBcncTmprList.get(i).get("J_1KFTIND").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("VKGRP").equals(sapBcncInfoList.get(j).get("VKGRP"))) {
							sb.append(" ,VKGRP='" + sapBcncTmprList.get(i).get("VKGRP").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("VKGRP_T").equals(sapBcncInfoList.get(j).get("VKGRP_T"))) {
							sb.append(" ,VKGRP_T='" + sapBcncTmprList.get(i).get("VKGRP_T").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("VKBUR").equals(sapBcncInfoList.get(j).get("VKBUR"))) {
							sb.append(" ,VKBUR='" + sapBcncTmprList.get(i).get("VKBUR").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("VKBUR_T").equals(sapBcncInfoList.get(j).get("VKBUR_T"))) {
							sb.append(" ,VKBUR_T='" + sapBcncTmprList.get(i).get("VKBUR_T").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("CESSION_KZ").equals(sapBcncInfoList.get(j).get("CESSION_KZ"))) {
							sb.append(" ,CESSION_KZ='" + sapBcncTmprList.get(i).get("CESSION_KZ").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("LOEVM").equals(sapBcncInfoList.get(j).get("LOEVM"))) {
							sb.append(" ,LOEVM='" + sapBcncTmprList.get(i).get("LOEVM").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("ZERDAT").equals(sapBcncInfoList.get(j).get("ZERDAT"))) {
							sb.append(" ,ZERDAT='" + sapBcncTmprList.get(i).get("ZERDAT").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("ZERZET").equals(sapBcncInfoList.get(j).get("ZERZET"))) {
							sb.append(" ,ZERZET='" + sapBcncTmprList.get(i).get("ZERZET").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(!sapBcncTmprList.get(i).get("LANDX").equals(sapBcncInfoList.get(j).get("LANDX"))) {
							sb.append(" ,LANDX='" + sapBcncTmprList.get(i).get("LANDX").toString().trim() +"'");
							bUpdate = true;
						}
						
						if(bUpdate) {
							sb.append(" ,LAST_UPDDE = SYSDATE ");
							sb.append(" ,UPDATE_ID = 'admin' ");
							sb.append(" WHERE KUNNR = '" + sapBcncTmprList.get(i).get("KUNNR").toString().trim() +"'");
							
							comz06Service.createCmDtaAtrailForUpdateByObject(sapBcncTmprList.get(i), atrailSapBcncInfo, null, null);
							if(come01DAO.updateSapBcncTmprByKunnr(sb.toString()) == 0) {
								throw new Exception("SAP_BCNC_INFO UPDATE ERROR");
							}
						}
						
						sapBcncTmprList.get(i).put("KUNNR", "00");
					}
				}
				
			}
			
			//입력
			for(int i = 0; i < sapBcncTmprList.size(); i++) {
				if("00".equals(sapBcncTmprList.get(i).get("KUNNR"))) {
					continue;
				}
				come01DAO.insertSapBcncInfoByBatch(sapBcncTmprList.get(i));
				comz06Service.createCmDtaAtrailForInsertByObject(sapBcncTmprList.get(i), atrailSapBcncInfo, null, null);
			}
			
			come01DAO.deleteSapBcncTmprByBatch();
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "거래처정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
		} catch (Exception e) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "거래처정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
		
	}
	
	@Override
	public void batchInfraDeptTmpr() throws Exception {
//		if(!"Y".equals(come01DAO.selectCmSysEnvrnByEnvrnSe())) {
//			return;
//		}
		
		try {

			List<Map<String, Object>> InfraCmDeptInfoList = Util.setTrimByListObject(come01DAO.selectCmDeptInfoByBatch());
			
			if(InfraCmDeptInfoList.size() == 0) {
				initialInfraDeptTmpr();
				come01DAO.deleteInfraDeptTmprByBatch();
				return;
			}
			
			List<Map<String, Object>> infraDeptTmprList = Util.setTrimByListObject(come01DAO.selectInfraDeptTmprByBatch());
			
			for(int i = 0; i < infraDeptTmprList.size(); i++) {
				
				for(int j  = 0; j < InfraCmDeptInfoList.size(); j++) {
					
					if(infraDeptTmprList.get(i).get("DEPT_CD").equals(InfraCmDeptInfoList.get(j).get("DEPT_CD"))
							&&infraDeptTmprList.get(i).get("COMP_CD").equals(InfraCmDeptInfoList.get(j).get("COMP_CD"))) {
						
						boolean bUpdate = false;
						StringBuffer sb = new StringBuffer();
						
						sb.append("UPDATE CM_DEPTINFO ");
						sb.append("   SET DEPT_CD = '" + infraDeptTmprList.get(i).get("DEPT_CD") + "'");
						sb.append("     , COMP_CD = '" + infraDeptTmprList.get(i).get("COMP_CD") + "'");
						
						if(!infraDeptTmprList.get(i).get("DEPT_NM").equals(InfraCmDeptInfoList.get(j).get("DEPT_NM"))) {
							sb.append(" ,DEPT_NM='" + infraDeptTmprList.get(i).get("DEPT_NM") +"'");
							bUpdate = true;
						}
						
						if(!infraDeptTmprList.get(i).get("DEPT_UP").equals(InfraCmDeptInfoList.get(j).get("DEPT_UP"))) {
							sb.append(" ,DEPT_UP='" + infraDeptTmprList.get(i).get("DEPT_UP") +"'");
							bUpdate = true;
						}
						
						if(!infraDeptTmprList.get(i).get("DEPT_LEVEL").equals(InfraCmDeptInfoList.get(j).get("DEPT_LEVEL"))) {
							sb.append(" ,DEPT_LEVEL='" + infraDeptTmprList.get(i).get("DEPT_LEVEL") +"'");
							bUpdate = true;
						}
						
						if(!infraDeptTmprList.get(i).get("DEPT_ORDER").equals(InfraCmDeptInfoList.get(j).get("DEPT_ORDER"))) {
							sb.append(" ,DEPT_ORDER='" + infraDeptTmprList.get(i).get("DEPT_ORDER") +"'");
							bUpdate = true;
						}
						
						if(!infraDeptTmprList.get(i).get("USE_YN").equals(InfraCmDeptInfoList.get(j).get("USE_YN"))) {
							sb.append(" ,USE_YN='" + infraDeptTmprList.get(i).get("USE_YN") +"'");
							bUpdate = true;
						}

						if(bUpdate) {
							sb.append(" ,LAST_UPDDE = SYSDATE ");
							sb.append(" ,UPDATE_ID = 'admin' ");
							sb.append(" WHERE DEPT_CD = '" + infraDeptTmprList.get(i).get("DEPT_CD") +"'");
							sb.append("   AND COMP_CD = '" + infraDeptTmprList.get(i).get("COMP_CD") +"'");
							
							comz06Service.createCmDtaAtrailForUpdateByObject(infraDeptTmprList.get(i), atrailCmDeptInfo, null, null);
							if(come01DAO.updateCmDeptInfoByDeptCd(sb.toString()) == 0) {
								throw new Exception("CM_DEPTINFO UPDATE ERROR");
							}
						}
						
						infraDeptTmprList.get(i).put("DEPT_CD", "00");
						infraDeptTmprList.get(i).put("COMP_CD", "00");
					}
				}
			}
			
			//입력
			for(int i = 0; i < infraDeptTmprList.size(); i++) {
				if("00".equals(infraDeptTmprList.get(i).get("DEPT_CD"))
						&&"00".equals(infraDeptTmprList.get(i).get("COMP_CD"))) {
					continue;
				}
				come01DAO.insertCmDeptInfo(infraDeptTmprList.get(i));
				comz06Service.createCmDtaAtrailForInsertByObject(infraDeptTmprList.get(i), atrailCmDeptInfo, null, null);
			}
			
			come01DAO.deleteInfraDeptTmprByBatch();
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "부서정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
		} catch (Exception e) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "부서정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
	}

	@Override
	public void batchInfraUserTmpr() throws Exception {
//		if(!"Y".equals(come01DAO.selectCmSysEnvrnByEnvrnSe())) {
//			return;
//		}
		
		try {
			Map<String, String> tmpMap = null;
			Map<String, Object> mapShallowCopy = null;
			
			List<Map<String, Object>> cmJobUserList = Util.setTrimByListObject(come01DAO.selectCmJobUserForBatch());
			
			List<Map<String, Object>> cmUserList = Util.setTrimByListObject(come01DAO.selectCmUserForBatch());
			
			if(cmJobUserList.size() == 0) {
				initialInfraUserTmpr();
				come01DAO.deleteInfraUserTmprByBatch();
				return;
			}

			//내부유저정보 비교할 시 쓰인다.
			List<Map<String, Object>> cmInfraUserTmprList = Util.setTrimByListObject(come01DAO.selectInfraUserTmprByBatch());

			//유저정보 비교할 시 쓰인다.
			List<Map<String, Object>> cmInfraUserTmprList2 = new ArrayList<Map<String, Object>>();
			
			//임시정보 얕은 복사
			for(Map<String, Object> iMap : cmInfraUserTmprList) {
				
				mapShallowCopy = new HashMap<String, Object>();
				
				for(String mapkey : iMap.keySet()) {
					mapShallowCopy.put(mapkey, iMap.get(mapkey));
				}
				
				cmInfraUserTmprList2.add(mapShallowCopy);
			}
			
			//유저정보 수정
			for(int i = 0; i < cmInfraUserTmprList2.size(); i++) {
				for(int j = 0; j < cmUserList.size(); j++) {
					if(cmInfraUserTmprList2.get(i).get("CJ_ID").equals(cmUserList.get(j).get("USER_ID"))) {
						boolean bUpdate2 = false;
						StringBuffer sb2 = new StringBuffer();
						
						sb2.append("UPDATE CM_USER");
						sb2.append("   SET USER_ID = '" +  cmInfraUserTmprList2.get(i).get("CJ_ID") + "'");
						
						if(!cmInfraUserTmprList2.get(i).get("EMP_NM").equals(cmUserList.get(j).get("USER_NM"))) {
							sb2.append(" ,USER_NM='" + cmInfraUserTmprList2.get(i).get("EMP_NM") +"'");
							bUpdate2 = true;
						}
						
						if(!cmInfraUserTmprList2.get(i).get("EMP_ENG_NAME").equals(cmUserList.get(j).get("USER_ENGNM"))) {
							sb2.append(" ,USER_ENGNM='" + cmInfraUserTmprList2.get(i).get("EMP_ENG_NAME") +"'");
							bUpdate2 = true;
						}
						
						if(!cmInfraUserTmprList2.get(i).get("EMAIL").equals(cmUserList.get(j).get("EMAIL"))) {
							sb2.append(" ,EMAIL='" + cmInfraUserTmprList2.get(i).get("EMAIL") +"'");
							bUpdate2 = true;
						}
						
						if(!cmInfraUserTmprList2.get(i).get("PHONE_NO").equals(cmUserList.get(j).get("TELNO"))) {
							sb2.append(" ,TELNO='" + cmInfraUserTmprList2.get(i).get("PHONE_NO") +"'");
							bUpdate2 = true;
						}
						
						if(!"".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("DEL_DT"))) && "Y".equals(EgovStringUtil.isNullToString(cmUserList.get(j).get("USE_YN")))) {
							sb2.append(" ,USE_YN='N' ");
							sb2.append(" ,ACNT_LOCK_AT='Y' ");
							bUpdate2 = true;
						}
						
						if("".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("DEL_DT"))) && "N".equals(EgovStringUtil.isNullToString(cmUserList.get(j).get("USE_YN")))) {
							sb2.append(" ,USE_YN='Y'");
							bUpdate2 = true;
						}
						
						if(bUpdate2) {
							sb2.append(" ,LAST_UPDDE = SYSDATE ");
							sb2.append(" ,UPDATE_ID = 'admin' ");
							sb2.append(" WHERE USER_ID = '" + cmInfraUserTmprList2.get(i).get("CJ_ID") +"'");
							
							tmpMap = new HashMap<String, String>();
							tmpMap.put("USER_ID", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("CJ_ID")));
							tmpMap.put("USER_NM", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMP_NM")));
							tmpMap.put("USER_ENGNM", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMP_ENG_NAME")));
							tmpMap.put("EMAIL", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMAIL")));
							tmpMap.put("TELNO", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("PHONE_NO")));
							
							comz06Service.createCmDtaAtrailForUpdateByString(tmpMap, atrailCmUser, null, null);
							if(come01DAO.updateCmUserForBatch(sb2.toString()) == 0) {
								throw new Exception("CM_USER UPDATE ERROR");
							}
						}
						
						cmInfraUserTmprList2.get(i).put("CJ_ID", "00");

					}
				}
			}
			
			//유저정보 입력
			for(int i = 0; i < cmInfraUserTmprList2.size(); i++) {
				if("00".equals(cmInfraUserTmprList2.get(i).get("CJ_ID"))) {
					continue;
				}
				
				tmpMap = new HashMap<String, String>();
				tmpMap.put("USER_ID", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("CJ_ID")));
				tmpMap.put("USER_NM", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMP_NM")));
				tmpMap.put("USER_ENGNM", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMP_ENG_NAME")));
				tmpMap.put("EMAIL", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("EMAIL")));
				tmpMap.put("TELNO", EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("PHONE_NO")));
				
				if("".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("DEL_DT")))) {
					tmpMap.put("USE_YN", "Y");
				} else {
					tmpMap.put("USE_YN", "N");
				}
				
				tmpMap.put("PASSWORD", Util.getStrPasswordRnd());
				come01DAO.insertCmUserByBatch(tmpMap);
				comz06Service.createCmDtaAtrailForInsertByString(tmpMap, atrailCmUser, null, null);
				
			}
			
			//내부유저 정보 수정
			for(int i = 0; i < cmInfraUserTmprList.size(); i++) {
				
				for(int j = 0; j < cmJobUserList.size(); j++) {
					if(cmInfraUserTmprList.get(i).get("CJ_ID").equals(cmJobUserList.get(j).get("USER_ID"))) {
						
						boolean bUpdate1 = false;
						StringBuffer sb1 = new StringBuffer();
						
						sb1.append("UPDATE CM_JOBUSER");
						sb1.append("   SET USER_ID = '" +  cmInfraUserTmprList.get(i).get("CJ_ID") + "'");

						if(!cmInfraUserTmprList.get(i).get("COMP_CD").equals(cmJobUserList.get(j).get("COMP_CD"))) {
							sb1.append(" ,COMP_CD='" + cmInfraUserTmprList.get(i).get("COMP_CD")  +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("EMP_NO").equals(cmJobUserList.get(j).get("EMPL_NO"))) {
							sb1.append(" ,EMPL_NO='" + cmInfraUserTmprList.get(i).get("EMP_NO") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("DEPT_CD").equals(cmJobUserList.get(j).get("DEPT_CD"))) {
							sb1.append(" ,DEPT_CD='" + cmInfraUserTmprList.get(i).get("DEPT_CD") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("COST_CD").equals(cmJobUserList.get(j).get("COST_CNTER"))) {
							sb1.append(" ,COST_CNTER='" + cmInfraUserTmprList.get(i).get("COST_CD") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("WORK_YN").equals(cmJobUserList.get(j).get("HFFC_AT"))) {
							sb1.append(" ,HFFC_AT='" + cmInfraUserTmprList.get(i).get("WORK_YN") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("POSITION_CD").equals(cmJobUserList.get(j).get("CLSF_CODE"))) {
							sb1.append(" ,CLSF_CODE='" + cmInfraUserTmprList.get(i).get("POSITION_CD") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("INS_DT").equals(cmJobUserList.get(j).get("ECNY_DE"))) {
							sb1.append(" ,ECNY_DE= '" + cmInfraUserTmprList.get(i).get("INS_DT") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("DEL_DT").equals(cmJobUserList.get(j).get("RETIRE_DE"))) {
							sb1.append(" ,RETIRE_DE= '" + cmInfraUserTmprList.get(i).get("DEL_DT") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("JOB_CD").equals(cmJobUserList.get(j).get("DTY_CODE"))) {
							sb1.append(" ,DTY_CODE='" + cmInfraUserTmprList.get(i).get("JOB_CD") +"'");
							bUpdate1 = true;
						}
						
						if(!cmInfraUserTmprList.get(i).get("CHIEF_FLAG").equals(cmJobUserList.get(j).get("DPRLR_AT"))) {
							sb1.append(" ,DPRLR_AT='" + cmInfraUserTmprList.get(i).get("CHIEF_FLAG")+"'");
							bUpdate1 = true;
						}
						
						if(!"".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("DEL_DT"))) && "Y".equals(EgovStringUtil.isNullToString(cmJobUserList.get(j).get("USE_YN")))) {
							sb1.append(" ,USE_YN='N'");
							bUpdate1 = true;
						}
						
						if("".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList2.get(i).get("DEL_DT"))) && "N".equals(EgovStringUtil.isNullToString(cmJobUserList.get(j).get("USE_YN")))) {
							sb1.append(" ,USE_YN='Y'");
							bUpdate1 = true;
						}
						
						if(bUpdate1) {
							sb1.append(" ,LAST_UPDDE = SYSDATE ");
							sb1.append(" ,UPDATE_ID = 'admin' ");
							sb1.append(" WHERE USER_ID = '" + cmInfraUserTmprList.get(i).get("CJ_ID") +"'");
							
							tmpMap = new HashMap<String, String>();
							tmpMap.put("USER_ID", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CJ_ID")));
							tmpMap.put("COMP_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COMP_CD")));
							tmpMap.put("EMPL_NO", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMP_NO")));
							tmpMap.put("DEPT_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEPT_CD")));
							tmpMap.put("COST_CNTER", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COST_CD")));
							tmpMap.put("HFFC_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("WORK_YN")));
							tmpMap.put("CLSF_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("POSITION_CD")));
							tmpMap.put("ECNY_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("INS_DT")));
							tmpMap.put("RETIRE_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEL_DT")));
							tmpMap.put("DTY_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("JOB_CD")));
							tmpMap.put("DPRLR_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CHIEF_FLAG")));
							
							comz06Service.createCmDtaAtrailForUpdateByString(tmpMap, atrailCmJobUser, null, null);
							if(come01DAO.updateCmJobUserForBatch(sb1.toString()) == 0) {
								throw new Exception("CM_JOBUSER UPDATE ERROR");
							}
						}
						
						cmInfraUserTmprList.get(i).put("CJ_ID", "00");
					}
				}
			}
			
			//내부유저정보 입력
			for(int i = 0; i < cmInfraUserTmprList.size(); i++) {
				if("00".equals(cmInfraUserTmprList.get(i).get("CJ_ID"))) {
					continue;
				}
				
				tmpMap = new HashMap<String, String>();
				tmpMap.put("USER_ID", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CJ_ID")));
				tmpMap.put("COMP_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COMP_CD")));
				tmpMap.put("EMPL_NO", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("EMP_NO")));
				tmpMap.put("DEPT_CD", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEPT_CD")));
				tmpMap.put("COST_CNTER", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("COST_CD")));
				tmpMap.put("HFFC_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("WORK_YN")));
				tmpMap.put("CLSF_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("POSITION_CD")));
				tmpMap.put("ECNY_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("INS_DT")));
				tmpMap.put("RETIRE_DE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEL_DT")));
				tmpMap.put("DTY_CODE", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("JOB_CD")));
				tmpMap.put("DPRLR_AT", EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("CHIEF_FLAG")));
				
				if("".equals(EgovStringUtil.isNullToString(cmInfraUserTmprList.get(i).get("DEL_DT")))) {
					tmpMap.put("USE_YN", "Y");
				} else {
					tmpMap.put("USE_YN", "N");
				}
				
				come01DAO.insertCmJobUserByBatch(tmpMap);
				comz06Service.createCmDtaAtrailForInsertByString(tmpMap, atrailCmJobUser, null, null);
			}
			
//			come01DAO.deleteInfraUserTmprByBatch();
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "사용자정보");
			map.put("OPERT_STTUS", "01");
			map.put("STTUS_RESN", "SUCCESS");
			
			ntcome01DAO.insertCmIntrfc(map);
			
		} catch (Exception e) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("OPERT_SN", cmIntrfcSeq.getNextStringId());
			map.put("OPERT_NM", "사용자정보");
			map.put("OPERT_STTUS", "02");
			
			if("".equals(e.getLocalizedMessage())) {
				map.put("STTUS_RESN", "FAIL");
			} else {
				map.put("STTUS_RESN", String.valueOf("ERROR:" + e.getLocalizedMessage()));
			}

			ntcome01DAO.insertCmIntrfc(map);
			LOGGER.error(this.toString(), e);
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectCmIntrfcListByCondition(Map<String, String> map) throws Exception {
		return come01DAO.selectCmIntrfcListByCondition(map);
	}

	@Override
	public int selectCmIntrfcListCountByCondition(Map<String, String> map) throws Exception {
		return come01DAO.selectCmIntrfcListCountByCondition(map);
	}

	@Override
	public void selectCmSysEnvrnByEnvrnSe() throws Exception {
		
		if(!"Y".equals(come01DAO.selectCmSysEnvrnByEnvrnSe())) {
//			throw new Exception("테스트환경에서는 입력 및 수정할 수 없습니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("come0101.msg.1"));
		}
	}
}
