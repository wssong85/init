package pantheon.com.b01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.b01.dao.COMB01DAO;
import pantheon.com.b01.service.COMB01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.service.impl.PantheonReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.z06.service.COMZ06Service;


/**
 * 역할관리 처리하는 비지니스 구현 클래스
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
@Service("COMB01Service")
public class COMB01ServiceImpl implements COMB01Service{

	@Resource(name = "COMB01DAO")
	private COMB01DAO comb01DAO;
	
//	@Resource(name ="databaseSecurityMetadataSource2")
//	private PantheonReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource2;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name = "ATRAIL_CM_ROLE")
	protected EgovPropertyService atrailCmRole;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public List<Map<String, String>> selectCmRoleForComboBox(Map<String, String> map) throws Exception {
		return comb01DAO.selectCmRoleForComboBox(map);
	}

	@Override
	public void insertCmRoleByCmRole(List<Map<String, Object>> list) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(comb01DAO.selectCmUserRoleCountByUserId(iMap) > 0) {
				
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmRole, null, null);
				comb01DAO.updateCmUserRoleByUserId(iMap);
				
			} else {
				
				comb01DAO.insertCmUserRoleByUserId(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmRole, null, null);
				
			}
		}
		
	}

	@Override
	public List<Map<String, Object>> selectCmRole(Map<String, String> map) throws Exception {
		return comb01DAO.selectCmRole(null);
	}

	@Override
	public void insertCmRole(List<Map<String, Object>> list) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(comb01DAO.selectCmRoleForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comb0101.msg.2"));
				}
				
				comb01DAO.insertCmRole(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmRole, null, null);
				
				//역할계층 입력
				comb01DAO.insertComtnrolesHierarchyForExtends(iMap);
				comb01DAO.insertComtnrolesHierarchyForAdmin(iMap);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmRole, null, null);
				comb01DAO.updateCmRoleByRoleId(iMap);
				
//				if("N".equals(iMap.get("USE_YN"))) {
//					if(comb01DAO.selectCmRoleAuthorForDupCheck(iMap) > 0 || comb01DAO.selectCtmsDmcTaskRoleForDupCheck(iMap) > 0) {
//						throw new Exception(egovMessageSource.getPantheonExceptionMessage("comb0101.msg.3"));
//					}
					//역할계층 삭제
//					comb01DAO.deleteComtnrolesHierarchyForExtends(iMap);
//					comb01DAO.deleteComtnrolesHierarchyForAdmin(iMap);
//				}
				
				//admin 가 입력이 안되어 있다면 다시 입력
				if(comb01DAO.selectComtnrolesHierarchyForDupCheckByAdmin(iMap) == 0 && iMap.get("USE_YN") != null && "Y".equals(iMap.get("USE_YN"))) {
					//역할계층 입력
					comb01DAO.insertComtnrolesHierarchyForAdmin(iMap);
				}
				
				//extends 가 입력이 안되어 있다면 다시 입력
				if(comb01DAO.selectComtnrolesHierarchyForDupCheckByExtends(iMap) == 0 && iMap.get("USE_YN") != null &&  "Y".equals(iMap.get("USE_YN"))) {
					//역할계층 입력
					comb01DAO.insertComtnrolesHierarchyForExtends(iMap);
				}
				
			} else if(iMap.get("CURD").equals("D")) {
				
				if(comb01DAO.selectCmRoleAuthorForDupCheck(iMap) > 0 || comb01DAO.selectCtmsDmcTaskRoleForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comb0101.msg.3"));
				}
				
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmRole, null, null);
				comb01DAO.updateCmRoleForDelete(iMap);
				
				//역할계층 삭제
				comb01DAO.deleteComtnrolesHierarchyForExtends(iMap);
				comb01DAO.deleteComtnrolesHierarchyForAdmin(iMap);
				
			}
			
			//스프링 시큐리티 역할계층 reload
//			databaseSecurityMetadataSource2.reload();
			
		}
	}

	@Override
	public List<Map<String, String>> selectComtnrolesHierarchy(Map<String, String> map) throws Exception {
		return comb01DAO.selectComtnrolesHierarchy(null);
	}

	@Override
	public void insertComtnrolesHierarchy(List<Map<String, Object>> list) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		comb01DAO.deleteComtnrolesHierarchy(null);
		
		for(Map<String, Object> iMap : list) {
			comb01DAO.insertComtnrolesHierarchy(iMap);
		}
	}
}
