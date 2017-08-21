package pantheon.com.utl.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import pantheon.com.utl.Util;

/**
 * 지역별 시간대 변경(AOP) 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
public class PantheonTimeConvertAspect {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@SuppressWarnings("unchecked")
	public Object timeConvertSelect(ProceedingJoinPoint joinPoint) throws Throwable {
		
		//시간 변환
		Object retVal = joinPoint.proceed();
		
		if(retVal instanceof List) {
			try {
				List<Map<String, Object>> tmpVal = (List<Map<String, Object>>) retVal; 
				for(Map<String, Object> iMap : tmpVal) {
					for(String mapkey : iMap.keySet()){
						
						if(Util.isTimeConvert(mapkey))
						{
							
							if(!(EgovStringUtil.isNullToString(iMap.get(mapkey)).length() == 14)) {
								continue;
							}
							
							String sDate = EgovStringUtil.isNullToString(iMap.get(mapkey)).substring(0, 8);
							String sTime = EgovStringUtil.isNullToString(iMap.get(mapkey)).substring(8, 14);
							String strPut = null;
							if(Util.getUserMap() != null) {
								strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
							} else {
								strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
							}
							iMap.put(mapkey, EgovDateUtil.convertDate(strPut, null, null, null));
						}
						
					}
				}
				retVal = (Object) tmpVal;
			} catch (Exception e) {
				List<Map<String, String>> tmpVal = (List<Map<String, String>>) retVal; 
				for(Map<String, String> iMap : tmpVal) {
					for(String mapkey : iMap.keySet()){
						
						if(Util.isTimeConvert(mapkey))
						{
							
							if(!(EgovStringUtil.isNullToString(iMap.get(mapkey)).length() == 14)) {
								continue;
							}
							
							String sDate = EgovStringUtil.isNullToString(iMap.get(mapkey)).substring(0, 8);
							String sTime = EgovStringUtil.isNullToString(iMap.get(mapkey)).substring(8, 14);
							String strPut = null;
							if(Util.getUserMap() != null) {
								strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
							} else {
								strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
							}
							iMap.put(mapkey, EgovDateUtil.convertDate(strPut, null, null, null));
						}
					}	
				}
				retVal = (Object) tmpVal;
			}
		} else if(retVal instanceof Map) {
			try {
				Map<String, Object> tmpVal = (Map<String, Object>) retVal;
				for(String mapkey : tmpVal.keySet()){
					
					if(Util.isTimeConvert(mapkey))
					{
						
						if(!(EgovStringUtil.isNullToString(tmpVal.get(mapkey)).length() == 14)) {
							continue;
						}
						
						String sDate = EgovStringUtil.isNullToString(tmpVal.get(mapkey)).substring(0, 8);
						String sTime = EgovStringUtil.isNullToString(tmpVal.get(mapkey)).substring(8, 14);
						String strPut = null;
						if(Util.getUserMap() != null) {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
						} else {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
						}
						tmpVal.put(mapkey, EgovDateUtil.convertDate(strPut, null, null, null));
					}
				}
				retVal = (Object) tmpVal;
			} catch (Exception e) {
				Map<String, String> tmpVal = (Map<String, String>) retVal;
				for(String mapkey : tmpVal.keySet()){
					
					if(Util.isTimeConvert(mapkey))
					{
						
						if(!(EgovStringUtil.isNullToString(tmpVal.get(mapkey)).length() == 14)) {
							continue;
						}
						
						String sDate = EgovStringUtil.isNullToString(tmpVal.get(mapkey)).substring(0, 8);
						String sTime = EgovStringUtil.isNullToString(tmpVal.get(mapkey)).substring(8, 14);
						String strPut = null;
						if(Util.getUserMap() != null) {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (-9 + Integer.parseInt(Util.getUserMap().get("STD_TIME_SN"))), 0, "yyyyMMddHHmmss");	
						} else {
							strPut = EgovDateUtil.addYMDtoDayTime(sDate, sTime, 0, 0, 0, (0), 0, "yyyyMMddHHmmss");
						}
						tmpVal.put(mapkey, EgovDateUtil.convertDate(strPut, null, null, null));
					}
				}
				retVal = (Object) tmpVal;
			}
		}
		
		return retVal;
	}

}

