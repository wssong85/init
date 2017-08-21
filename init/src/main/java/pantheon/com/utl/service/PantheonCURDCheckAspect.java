package pantheon.com.utl.service;


import javax.annotation.Resource;

import org.aspectj.lang.JoinPoint;

import egovframework.com.cmm.EgovMessageSource;
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
public class PantheonCURDCheckAspect {
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	public void CURDCheck(JoinPoint joinPoint) throws Exception {
		
		//쓰기, 읽기 체크
		if(Util.getUserMap() != null && Util.getUserMap().get("WRITE_AT") != null && Util.getUserMap().get("REDNG_AT") != null) {
			System.out.println(Util.getUserMap());
			String strMethodName = joinPoint.getSignature().getName();
			
			if(Util.isCURDCheck(strMethodName)) {
				return;
			}
			
			if(strMethodName.startsWith("select") && "N".equals(Util.getUserMap().get("REDNG_AT"))) {
				
				throw new Exception(egovMessageSource.getPantheonMessageByReadWrite("global.error.3"));
				
			} else if(strMethodName.startsWith("insert") && "N".equals(Util.getUserMap().get("WRITE_AT"))) {
				
				throw new Exception(egovMessageSource.getPantheonMessageByReadWrite("global.error.4"));
				
			} else if(strMethodName.startsWith("update") && "N".equals(Util.getUserMap().get("WRITE_AT"))) {
				
				throw new Exception(egovMessageSource.getPantheonMessageByReadWrite("global.error.4"));
				
			} else if(strMethodName.startsWith("delete") && "N".equals(Util.getUserMap().get("WRITE_AT"))) {
				
				throw new Exception(egovMessageSource.getPantheonMessageByReadWrite("global.error.4"));
				
			}
			
		}

	}

}

