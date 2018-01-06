package realtime.shopping.hashtag.service;

import java.util.Map;

public interface HashtagService {

	Map<String, Object> selectTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	void insertTbIfHashtagInterest(Map<String, Object> map) throws Exception;
}
