package pantheon.iwrs.e01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("IWRE01DAO")
public class IWRE01DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectVisitLabel(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectVisitLabel", param);
	}
	
	public int selectDispenseCnt(Map<String, String> param) throws Exception{
		return (int) select("IWRE01DAO.selectDispenseCnt", param);
	}
	
	public List<Map<String, String>> selectDispenseList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectDispenseList", param);
	}
	
	public List<Map<String, String>> selectSubjectList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectSubjectList", param);
	}
	
	public List<Map<String, String>> selectDispenseListForSubject(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("IWRE01DAO.selectDispenseListForSubject", param);
	}
	
	public List<Map<String, String>> selectDispenseForView(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectDispenseForView", param);
	}
	
	public List<Map<String, String>> selectDispenseReturnInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectDispenseReturnInfo", param);
	}
	
	public void insertDispenseInfo(Map<String, String> param) throws Exception{
		insert("IWRE01DAO.insertDispenseInfo", param);
	}
	
	public void updateDispenseInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateDispenseInfo", param);
	}
	
	public void updateReturnInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateReturnInfo", param);
	}
	
	public void updateConfirmInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateConfirmInfo", param);
	}
	
	public void updateErrorInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateErrorInfo", param);
	}
	
	public List<Map<String, String>> selectIpInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectIpInfo", param); 
	}
	
	public String selectQuerySeq(Map<String, String> param) throws Exception{
		return (String) select("IWRE01DAO.selectQuerySeq", param); 
	}
	
	public void insertRtunQuery(Map<String, String> param) throws Exception{
		insert("IWRE01DAO.insertRtunQuery", param);
	}
	
	public void insertQueryMaster(Map<String, String> param) throws Exception{
		insert("IWRE01DAO.insertQueryMaster", param);
	}
	
	public void updateQueryMaster(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateQueryMaster", param);
	}
	
	public void updateEndQuery(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateEndQuery", param);
	}
	
	public String selectQueryDetailCode(Map<String, String> param) throws Exception{
		return (String) select("IWRE01DAO.selectQueryDetailCode", param); 
	}
	
	public void insertQueryDetail(Map<String, String> param) throws Exception{
		insert("IWRE01DAO.insertQueryDetail", param);
	}
	
	public void insertQueryInfo(Map<String, String> param) throws Exception{
		insert("IWRE01DAO.insertQueryInfo", param);
	}
	
	public void updateEndQueryInfo(Map<String, String> param) throws Exception{
		update("IWRE01DAO.updateEndQueryInfo", param);
	}
	
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRE01DAO.selectQueryInfo", param);
	}
}
