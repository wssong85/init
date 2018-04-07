package realtime.com.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class Util {

	/**
	 * 사용자 세션을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static HttpSession getHttpSession() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request.getSession();
	}
	
	/**
	 * 요청정보를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static HttpServletRequest getHttpServletRequest() throws Exception {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	}
	
}
