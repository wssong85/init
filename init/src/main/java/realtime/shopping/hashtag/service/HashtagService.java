package realtime.shopping.hashtag.service;

import java.util.List;
import java.util.Map;

public interface HashtagService {

	Map<String, Object> selectTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	void insertTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selecBuyTbProductList(Map<String, Object> map) throws Exception;
	
	String requestReverseGeocoding(String query) throws Exception;
}
