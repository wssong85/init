package realtime.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class CorsFilter implements Filter {

	@Override
	public void destroy() { }

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain filterChain) throws IOException, ServletException {

		HttpServletResponse response = (HttpServletResponse) res;

		response.setHeader("Access-Control-Allow-Origin", "*"); 
    	response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT"); 
    	response.setHeader("Access-Control-Max-Age", "3600"); 
    	response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");
    	
    	filterChain.doFilter(req, res);
	}
	
	@Override
	public void init(FilterConfig arg0) throws ServletException { }
}