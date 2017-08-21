package pantheon.com.sample.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.sample.dao.SampleDAO;
import pantheon.com.sample.service.SampleService;
import pantheon.ctms.g01.dao.CTMG01DAO;

@Service("SampleService")
public class SampleServiceImpl implements SampleService{
	
	@Resource(name="SampleDAO")
	private SampleDAO sampleDAO;
	
	@Override
	public void insertSample(Map<String, String> param) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		
//		if(true) {
//			throw new Exception("테스트 exception");
//		}
		
		map.put("", "");
		map.put("", "");
		map.put("", "");
		map.put("", "");
		map.put("", "");
		map.put("", "");
//		CTMG01DAO.insertUserTaskInfo(map);
		sampleDAO.insertSample(param);
		sampleDAO.insertSample2(param);
	}

}
