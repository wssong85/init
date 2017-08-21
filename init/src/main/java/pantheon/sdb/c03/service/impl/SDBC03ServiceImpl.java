package pantheon.sdb.c03.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.sdb.c03.dao.SDBC03DAO;
import pantheon.sdb.c03.service.SDBC03Service;

@Service("SDBC03Service")
public class SDBC03ServiceImpl implements SDBC03Service {
	@Resource(name = "SDBC03DAO")
	private SDBC03DAO sdbc03Dao;
	
	public List<Map<String, String>> selectUploadHistory(Map<String, String> param )throws Exception{
		return sdbc03Dao.selectUploadHistory(param);
	}
}
