package pantheon.iwrs.g01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("IWRG01DAO")
public class IWRG01DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectTaskList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectTaskList", param);
	}
	
	public List<Map<String, String>> selectIwrsDesignList(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectIwrsDesignList", param);
	}
	
	public String selectIwrsDesignerInfo(Map<String, String> param) throws Exception{
		return (String) select("IWRG01DAO.selectIwrsDesignerInfo", param);
	}
	
	public void insertIwrsDesignerInfo(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertIwrsDesignerInfo", param);
	}
	
	public List<Map<String, String>> selectRandomizationList(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("IWRG01DAO.selectRandomizationList", param);
	}
	
	public List<Map<String, String>> selectVisitInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectVisitInfo", param);
	}
	
	public List<Map<String, String>> selectArmRaioInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectArmRaioInfo", param);
	}
	
	public String selectEdcVersion(Map<String, String> param) throws Exception{
		return (String) select("IWRG01DAO.selectEdcVersion", param);
	}
	
	public String selectGenerateCreateCode(Map<String, String> param) throws Exception{
		return (String) select("IWRG01DAO.selectGenerateCreateCode", param);
	}
	
	public int selectCreateCode(Map<String, String> param)throws Exception{
		return (int) select("IWRG01DAO.selectCreateCode", param);
	}
	
	public void insertCodeCreat(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertCodeCreat", param);
	}
	
	public void insertVisitSchdul(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertVisitSchdul", param);
	}
	
	public void insertArmRatioInfo(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertArmRatioInfo", param);
	}
	
	public void insertCodeConf(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertCodeConf", param);
	}
	
	public void insertCodeConfValue(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertCodeConfValue", param);
	}
	
	public int selectConfSn(Map<String, String> param) throws Exception{
		return (int) select("IWRG01DAO.selectConfSn", param);
	}
	
	public int selectConfValueSn(Map<String, String> param) throws Exception{
		return (int) select("IWRG01DAO.selectConfValueSn", param);
	}
	
	public void insertRandomSeed(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertRandomSeed", param);
	}
	
	public void insertBlock(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertBlock", param);
	}
	
	public int selectBlckSn(Map<String, String> param) throws Exception{
		return (int) select("IWRG01DAO.selectBlckSn", param);
	}
	
	public List<Map<String, String>> selectArmRatioInfoForGeneration(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectArmRatioInfoForGeneration", param);
	}
	
	public List<Map<String, String>> selectRandomSeedInfoForGeneration(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectRandomSeedInfoForGeneration", param);
	} 
	
	public List<Map<String, String>> selectBlockSizeInfoForGeneration(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectBlockSizeInfoForGeneration", param);
	} 
	
	public List<Map<String, String>> selectCodeConfForGeneration(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRG01DAO.selectCodeConfForGeneration", param);
	}
	
	public void insertRandomizationCode(Map<String, String> param) throws Exception{
		insert("IWRG01DAO.insertRandomizationCode", param);
	}
}
