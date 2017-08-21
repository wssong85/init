package pantheon.com.utl.service.impl;

import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

import egovframework.rte.fdl.security.securedobject.EgovSecuredObjectService;

/**
 * 역할계층 처리하는 서비스 구현 클래스
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
public class PantheonReloadableFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
	
	private String hierachyStr;
	
	private EgovSecuredObjectService securedObjectService;
	
	@Resource(name = "roleHierarchy")
	private RoleHierarchyImpl roleHierarchy;
	
	public void setSecuredObjectService(EgovSecuredObjectService securedObjectService) {
		this.securedObjectService = securedObjectService;
	}
	
	public PantheonReloadableFilterInvocationSecurityMetadataSource(String hierachyStr) {
		this.hierachyStr = hierachyStr;
	}
	
	public void reload() throws Exception {
		hierachyStr = securedObjectService.getHierarchicalRoles();
		roleHierarchy.setHierarchy(hierachyStr);
    }
	
	@Override
	public Collection<ConfigAttribute> getAttributes(Object obj)
			throws IllegalArgumentException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public boolean supports(Class<?> class1) {
		// TODO Auto-generated method stub
		return false;
	}
}