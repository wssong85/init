package pantheon.com.j01.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import pantheon.com.j01.dao.COMJ01DAO;
import pantheon.com.j01.service.COMJ01Service;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.DamoService;

@Service("COMJ01Service")
public class COMJ01ServiceImpl implements COMJ01Service{
	
	@Resource(name = "COMJ01DAO")
	private COMJ01DAO comj01DAO;
	
	@Resource(name = "DamoService")
	private DamoService damoService; 
	
	@Override
	public List<Map<String, Object>> selectCmDtaAtrailListByPk(Map<String, String> map) throws Exception {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listByPaging = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listVarchar = comj01DAO.selectCmDtaAtrailListByPk(map); 
		
		//암호화된 데이터 복호화한다.
//		for(Map<String, Object> iMap : list) {
//			if(Util.isDamo(iMap.get("COLUMN_NM"))) {
//				try {
//					if(iMap.get("AFTUPD_VALUE") != null && "".equals(EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")))){
//						iMap.put("AFTUPD_VALUE", damoService.scpDecStr(EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE"))));
//					}
//					if(iMap.get("UPDTBFE_VALUE") != null && "".equals(EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")))){
//						iMap.put("UPDTBFE_VALUE", damoService.scpDecStr(EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE"))));
//					}
//				} catch (Exception e) {
//					log.debug("damo convert ERROR! : " + e.getLocalizedMessage());
//					throw e;
//				}
//			}
//		}
		
		List<Map<String, Object>> listClob = comj01DAO.selectCmDtaAtrailListByPkForClob(map);
		
		for(Map<String, Object> iMap : listVarchar) {
			list.add(iMap);
		}
		
		for(Map<String, Object> iMap : listClob) {
			list.add(iMap);
		}
		
		Collections.sort(list, new Comparator<Map<String, Object>> () {
			//내림차순
			@Override
			public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				return EgovStringUtil.isNullToString(o2.get("UPDT_DE")).compareTo(EgovStringUtil.isNullToString(o1.get("UPDT_DE"))); 
			}
		});
		
		//페이징 처리를 하기 위해선 page 와 count 파라미터를 주도록 한다.
		if(map.containsKey("page") && map.containsKey("count")) {
			
			int page = Integer.parseInt(map.get("page"));
			int count = Integer.parseInt(map.get("count"));
			
			int rn = 0;
			
			//페이징 처리 위해 RN부여
			for(Map<String, Object> iMap : list) {
				iMap.put("RN", ++rn);
			}
			
			//페이징
			for(Map<String, Object> iMap : list) {
				
				if(Integer.parseInt(String.valueOf(iMap.get("RN"))) > (page-1) * count &&  Integer.parseInt(String.valueOf(iMap.get("RN"))) <= (page * count)) {
					
					listByPaging.add(iMap);
					
				}
				
			}
			
			//시간대 처리
			for(Map<String, Object> iMap : listByPaging) {
				
				if(Util.isTimeConvert(EgovStringUtil.isNullToString(iMap.get("COLUMN_NM")))) {
					
					if(EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).length() == 14) {
						String sDate = EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).substring(0, 8);
						String sTime = EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).substring(8, 14);
						String strPut = null;
						if(Util.getUserMap() != null) {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
						} else {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
						}
						iMap.put("UPDTBFE_VALUE", EgovDateUtil.convertDate(strPut, null, null, null));
					}
					
					if(EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).length() == 14) {
						String sDate = EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).substring(0, 8);
						String sTime = EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).substring(8, 14);
						String strPut = null;
						if(Util.getUserMap() != null) {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
						} else {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
						}
						iMap.put("AFTUPD_VALUE", EgovDateUtil.convertDate(strPut, null, null, null));
					}
					
				}
				
			}
			
			return listByPaging;
		}
		
		//시간대 처리
		for(Map<String, Object> iMap : list) {
			
			if(Util.isTimeConvert(EgovStringUtil.isNullToString(iMap.get("COLUMN_NM")))) {
				
				if(EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).length() == 14) {
					String sDate = EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).substring(0, 8);
					String sTime = EgovStringUtil.isNullToString(iMap.get("UPDTBFE_VALUE")).substring(8, 14);
					String strPut = null;
					if(Util.getUserMap() != null) {
						strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
					} else {
						strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
					}
					iMap.put("UPDTBFE_VALUE", EgovDateUtil.convertDate(strPut, null, null, null));
				}
				
				if(EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).length() == 14) {
					String sDate = EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).substring(0, 8);
					String sTime = EgovStringUtil.isNullToString(iMap.get("AFTUPD_VALUE")).substring(8, 14);
					String strPut = null;
					if(Util.getUserMap() != null) {
						strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
					} else {
						strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
					}
					iMap.put("AFTUPD_VALUE", EgovDateUtil.convertDate(strPut, null, null, null));
				}
				
			}
			
		}
		
		return list;
		
	}

	@Override
	public int selectCmDtaAtrailListCountByPk(Map<String, String> map)throws Exception {
		
		int conuntVarchar = comj01DAO.selectCmDtaAtrailListCountByPk(map);
		int countClob = comj01DAO.selectCmDtaAtrailListCountByPkForClob(map);
		
		return conuntVarchar + countClob;
	}
	
}

