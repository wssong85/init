package pantheon.com.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.common.dao.PantheonCommonDAO;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;

@Service("PantheonCommonService")
public class PantheonCommonServiceImpl implements PantheonCommonService {

	@Resource(name = "PantheonCommonDAO")
	private PantheonCommonDAO pantheonCommonDAO;

	@Override
	public List<Map<String, Object>> selectQueryDataList(Map<String, String> map) throws Exception {
		if (!map.containsKey("QUERY")) {
			throw new Exception("query parameter null");
		}
		map.put("LOCALE", Util.getStrLocale());
		return pantheonCommonDAO.selectQueryDataList(map);
	}

	@Override
	public List<Map<String, Object>> selectQueryDataList2(Map<String, Object> map) throws Exception {
		if (!map.containsKey("QUERY")) {
			throw new Exception("query parameter null");
		}
		map.put("LOCALE", Util.getStrLocale());
		return pantheonCommonDAO.selectQueryDataList2(map);
	}

	@Override
	public Map<String, Object> selectQueryData(Map<String, String> map) throws Exception {
		if (!map.containsKey("QUERY")) {
			throw new Exception("query parameter null");
		}
		
		if(Util.getStrLocale() != null) {
			map.put("LOCALE", Util.getStrLocale());
		}
		
		return pantheonCommonDAO.selectQueryData(map);
	}

	@Override
	public int selectQueryListCount(Map<String, String> map) throws Exception {
		if (!map.containsKey("QUERY")) {
			throw new Exception("query parameter null");
		}
		map.put("LOCALE", Util.getStrLocale());
		return pantheonCommonDAO.selectQueryListCount(map);
	}

}
