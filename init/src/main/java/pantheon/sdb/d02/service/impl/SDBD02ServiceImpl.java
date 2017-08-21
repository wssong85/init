package pantheon.sdb.d02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.sdb.d02.dao.SDBD02DAO;
import pantheon.sdb.d02.service.SDBD02Service;

@Service("SDBD02Service")
public class SDBD02ServiceImpl implements SDBD02Service {
	@Resource(name ="SDBD02DAO")
	private SDBD02DAO sdbd02Dao;

	@Override
	public int selectReportDelayCount(Map<String, String> param) throws Exception {
		return sdbd02Dao.selectReportDelayCount(param);
	}

	@Override
	public List<Map<String, String>> selectReportDelayList(Map<String, String> param) throws Exception {
		return sdbd02Dao.selectReportDelayList(param);
	}
}
