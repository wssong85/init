package egovframework.com.sec.security.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import pantheon.com.f04.service.COMF04Service;
import pantheon.com.i01.service.COMI01Service;
import pantheon.com.utl.Util;
import egovframework.com.utl.slm.EgovMultiLoginPreventor;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


/**
 *
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 8. 29.
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information)
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 29.    서준식        최초생성
 *
 *  </pre>
 */

public class EgovSpringSecurityLogoutFilter implements Filter{

	@SuppressWarnings("unused")
	private FilterConfig config;

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSpringSecurityLogoutFilter.class);

	public void destroy() {}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		String requestURL = ((HttpServletRequest)request).getRequestURI();
		LOGGER.debug(requestURL);
		
		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		COMF04Service comf04Service = (COMF04Service) act.getBean("COMF04Service");
		EgovIdGnrService cmSysConectSeq =  (EgovIdGnrService) act.getBean("CM_SYS_CONECT_SEQ");
		
		//로그아웃 이력 등록
		Map<String, String> mapCmSysConect = new HashMap<String, String>();
		try {
			mapCmSysConect.put("CONECT_SN", cmSysConectSeq.getNextStringId());
			mapCmSysConect.put("USER_ID", Util.getUserMap().get("USER_ID"));
			mapCmSysConect.put("CONECT_SE", "04");
			mapCmSysConect.put("CONECT_IP", request.getRemoteAddr());
			comf04Service.insertCmSysConectByLogin(mapCmSysConect);
		} catch (FdlException e1) {
			LOGGER.error(e1.getLocalizedMessage());
		} catch (Exception e) {
			LOGGER.error(e.getLocalizedMessage());
		}
		
		try {
			if(Util.getUserMap() != null) {
				EgovMultiLoginPreventor.invalidateByLoginId(Util.getUserMap().get("USER_ID"));
			}
		} catch (Exception e) {
			LOGGER.debug(e.getLocalizedMessage());
		}
		
		((HttpServletRequest)request).getSession().setAttribute("loginVO", null);
		((HttpServletRequest)request).getSession().setAttribute("loginMap", null);
		((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getContextPath() + "/j_spring_security_logout");
	}

	public void init(FilterConfig filterConfig) throws ServletException {

		this.config = filterConfig;

	}
}
