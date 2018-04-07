package realtime.common.aop;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.lang.JoinPoint;

import realtime.shopping.user.mapper.UserMapper;

public class ApiAop {
	
	@Resource(name = "UserMapper")
	private UserMapper userMapper;
	
	public void loginCheck(JoinPoint joinPoint) throws Throwable {
		
		Object params[] = joinPoint.getArgs();
        for(Object param : params) {
        	
        	//Map일 경우
        	if(param instanceof Map) {
        		
        		if(userMapper.selectTbUserCountForCheck2((Map<String, Object>)(Object)param) == 0) {
        			throw new Exception("not user...");
        		}
        		
        	}
        	
        	//리스트 일 경우
        	if(param instanceof List) {
        		
        	}
        }

		
		
//		Object retVal = joinPoint.proceed();
//		if(retVal instanceof List) {
//		}
//		if(retVal instanceof Map) {
//		}
//		return null;
		
	}
	
}
