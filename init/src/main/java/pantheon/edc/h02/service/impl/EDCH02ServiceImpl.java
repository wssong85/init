package pantheon.edc.h02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import pantheon.edc.h02.dao.EDCH02DAO;
import pantheon.edc.h02.service.EDCH02Service;


@Service("EDCH02Service")
public class EDCH02ServiceImpl implements EDCH02Service{

	@Resource(name = "EDCH02DAO")
	EDCH02DAO EDCH02DAO;
	
	public List<Map<String, Object>> selectLabSubjectList(Map<String, Object> param) throws Exception{
		String edcVer = EDCH02DAO.selectEdcVer(param);
		param.put("EDC_VER", edcVer);
		return (List<Map<String, Object>>)EDCH02DAO.selectLabSubjectList(param);
	}
}
