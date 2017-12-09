package realtime.common.aop;

import org.apache.poi.util.SystemOutLogger;
import org.aspectj.lang.JoinPoint;

public class ApiAop {
	
	public void loginCheck(JoinPoint joinPoint) throws Exception {
		System.out.println("1");
	}
	
}
