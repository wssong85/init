package egovframework.com.sec.security.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.f04.service.COMF04Service;
//import egovframework.com.cmm.LoginVO;
import pantheon.com.i01.web.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.slm.EgovHttpSessionBindingListener;
import egovframework.com.utl.slm.EgovMultiLoginPreventor;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
//import egovframework.com.uat.uia.service.EgovLoginService;
import pantheon.com.i01.service.COMI01Service;
import pantheon.com.utl.Util;
import realtime.com.login.service.LoginService;
import realtime.com.role.service.RoleManageService;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.context.support.WebApplicationContextUtils;

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
 *     수정일                 수정자        	  수정내용
 *  -----------    --------   ---------------------------
 *  2011.08.29    	 서준식        	 최초생성
 *  2011.12.12      유지보수        사용자 로그인 정보 간섭 가능성 문제(멤버 변수 EgovUserDetails userDetails를 로컬변수로 변경)
 *  2014.03.07      유지보수        로그인된 상태에서 다시 로그인 시 미처리 되는 문제 수정 (로그인 처리 URL 파라미터화)
 *
 *  </pre>
 */

public class EgovSpringSecurityLoginFilter implements Filter {

	private FilterConfig config;

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSpringSecurityLoginFilter.class);

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		LOGGER.info("EgovSpringSecurityLoginFilter called...");
		
//		A.USER_ID
//		,A.USER_NAME
//		,A.PASSWORD
//		,B.BIRTH_DT
//		,B.AGE
//		,B.PHONE
//		,B.ADDR
//		,B.EMAIL
		
		// 로그인 URL
//		/com/login/loginUsr.do
		String loginURL = config.getInitParameter("loginURL");
		loginURL = loginURL.replaceAll("\r", "").replaceAll("\n", "");

//		/com/login/processLoginUsr.do
		String loginProcessURL = config.getInitParameter("loginProcessURL");
		loginProcessURL = loginProcessURL.replaceAll("\r", "").replaceAll("\n", "");

		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		LoginService loginService = (LoginService) act.getBean("LoginService");
		RoleManageService roleManageService = (RoleManageService) act.getBean("RoleManageService");
		
//		COMI01Service loginService = (COMI01Service) act.getBean("COMI01Service");
//		COMF04Service comf04Service = (COMF04Service) act.getBean("COMF04Service");
//		EgovIdGnrService cmSysConectSeq =  (EgovIdGnrService) act.getBean("CM_SYS_CONECT_SEQ");
//		EgovMessageSource egovMessageSource = (EgovMessageSource) act.getBean("egovMessageSource");
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		//String isLocallyAuthenticated = (String)session.getAttribute("isLocallyAuthenticated");
		String isRemotelyAuthenticated = (String) session.getAttribute("isRemotelyAuthenticated");

		String requestURL = ((HttpServletRequest) request).getRequestURI();
		
		//접속이력 등록
//		Map<String, String> mapCmSysConect = null;
		
		//스프링 시큐리티 인증이 처리 되었는지 EgovUserDetailsHelper.getAuthenticatedUser() 메서드를 통해 확인한다.
		//context-common.xml 빈 설정에 egovUserDetailsSecurityService를 등록 해서 사용해야 정상적으로 동작한다.
		if (EgovUserDetailsHelper.getAuthenticatedUser() == null || requestURL.contains(loginProcessURL)) {

			if (isRemotelyAuthenticated != null && isRemotelyAuthenticated.equals("true")) {
				try {
					//세션 토큰 정보를 가지고 DB로부터 사용자 정보를 가져옴
//					LoginVO loginVO = (LoginVO) session.getAttribute("loginVOForDBAuthentication");
					
					@SuppressWarnings("unchecked")
					Map<String, Object> mapActrionLogin = (Map<String, Object>) session.getAttribute("loginVOForDBAuthentication");
					
//					loginVO = loginService.actionLoginByEsntlId(loginVO);

					if (mapActrionLogin != null && mapActrionLogin != null && "".equals(EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID")))) {
						//세션 로그인
						session.setAttribute("loginMap", mapActrionLogin);
						
						//메뉴담기
						session.setAttribute("ROLE_MENUS", roleManageService.selectTbMenuProgramForUserMenu(EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID"))));
						
						//로컬 인증결과 세션에 저장
						session.setAttribute("isLocallyAuthenticated", "true");

						//스프링 시큐리티 로그인
						//httpResponse.sendRedirect(httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getUserSe() + loginVO.getId() + "&j_password=" + loginVO.getUniqId());

						UsernamePasswordAuthenticationFilter springSecurity = null;

						Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
						if (beans.size() > 0) {
							springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
						} else {
							LOGGER.error("No AuthenticationProcessingFilter");
							throw new IllegalStateException("No AuthenticationProcessingFilter");
						}
						//springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

						LOGGER.debug("before security filter call....");
						springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID")), EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID"))), httpResponse, chain);
						LOGGER.debug("after security filter call....");

					}

				} catch (Exception ex) {
					//DB인증 예외가 발생할 경우 로그를 남기고 로컬인증을 시키지 않고 그대로 진행함.
					LOGGER.debug("Local authentication Fail : {}", ex.getMessage());
				}

			} else if (isRemotelyAuthenticated == null) {
				if (requestURL.contains(loginProcessURL)) {

					String password = httpRequest.getParameter("loginPassword");
					
					// 보안점검 후속 조치(Password 검증)
//					if (password == null || password.equals("") || password.length() < 8 || password.length() > 20) {
					if (password == null || password.equals("")) {
//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login.password"));
						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
						dispatcher.forward(httpRequest, httpResponse);

						//chain.doFilter(request, response);

						return;
					}

//					LoginVO loginVO = new LoginVO();
//					loginVO.setUserId(httpRequest.getParameter("loginId"));
//					loginVO.setPassword(password);
					Map<String, Object> mapLogin = new HashMap<String, Object>();
					
					mapLogin.put("USER_ID", httpRequest.getParameter("loginId"));
					mapLogin.put("PASSWORD", password);
					
					
					try {

						//사용자 입력 id, password로 DB 인증을 실행함
//						loginVO = loginService.actionLogin(loginVO);
						
						Map<String, Object> mapActrionLogin = loginService.actionLogin(mapLogin);  
						
						if (mapActrionLogin != null && mapActrionLogin.get("USER_ID") != null && !"".equals(EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID")))) {
							
							//로그인시 글로벌 세션에 사용자가 들어있다면, 삭제한다.
//							if(EgovMultiLoginPreventor.findByLoginId(loginVO.getUserId())) {
//								EgovMultiLoginPreventor.invalidateByLoginId(loginVO.getUserId());
//							}
							
							//접속이력 등록
//							mapCmSysConect = new HashMap<String, String>();
//							mapCmSysConect.put("CONECT_SN", cmSysConectSeq.getNextStringId());
//							mapCmSysConect.put("USER_ID", loginVO.getUserId());
//							mapCmSysConect.put("CONECT_SE", "01");
//							mapCmSysConect.put("CONECT_IP", request.getRemoteAddr());
//							comf04Service.insertCmSysConectByLogin(mapCmSysConect);
							
//							Map<String, String> loginMap = new HashMap<String, String>();
							
							//세션 로그인
//							session.setAttribute("loginMap", mapActrionLogin);
							
							//글로벌 세션 저장
							EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
							session.setAttribute(EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID")), listener);
							session.setAttribute("loginMap", mapActrionLogin);
							session.setAttribute("ROLE_MENUS", roleManageService.selectTbMenuProgramForUserMenu(EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID"))));
							
//							loginMap.put("USER_ID", loginVO.getUserId());
//							loginMap.put("USER_NM", loginVO.getUserNm());
//							loginMap.put("STD_TIME_SN", loginVO.getStdTimeStdr());
//							loginMap.put("EMAIL", loginVO.getEmail());
							
							//사용자 세션 저장
//							session.setAttribute("loginMap", loginMap);
							

//							Map<String, String> progrmMap = new HashMap<String, String>();
							//프로그램 정보 세션 저장
//							session.setAttribute("progrmMap", progrmMap);

							//로컬 인증결과 세션에 저장
							session.setAttribute("isLocallyAuthenticated", "true");

							//스프링 시큐리티 로그인
							//httpResponse.sendRedirect(httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getUserSe() + loginVO.getId() + "&j_password=" + loginVO.getUniqId());

							UsernamePasswordAuthenticationFilter springSecurity = null;

							Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
							if (beans.size() > 0) {
								springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
							} else {
								LOGGER.error("No AuthenticationProcessingFilter");
								throw new IllegalStateException("No AuthenticationProcessingFilter");
							}
							//springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

							LOGGER.debug("before security filter call....");
							springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID")), EgovStringUtil.isNullToString(mapActrionLogin.get("USER_ID"))), httpResponse, chain);
							LOGGER.debug("after security filter call....");

						} else {
							
							//사용자 정보가 없는 경우 로그인 화면으로 redirect 시킴
//							httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
							RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
							dispatcher.forward(httpRequest, httpResponse);
							
							//chain.doFilter(request, response);

							return;

						}

					} catch (Exception ex) {
						//DB인증 예외가 발생할 경우 로그인 화면으로 redirect 시킴
						LOGGER.error("Login Exception : {}", ex.getCause(), ex);
//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
						dispatcher.forward(httpRequest, httpResponse);
						//chain.doFilter(request, response);

						return;

					}
					return;
				}

			}
		}

		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;
	}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}

	@Override
	public String getRequestURI() {
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/j_spring_security_check";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("j_username")) {
			return username;
		}

		if (name.equals("j_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}
