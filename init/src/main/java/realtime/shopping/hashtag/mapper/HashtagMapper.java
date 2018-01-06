package realtime.shopping.hashtag.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("HashtagMapper")
public interface HashtagMapper {

	Long selectTbInterestExist(String id) throws Exception;
	
	Long selectTbHashtagExist(String hashtag) throws Exception;
	
	Long selectTbIfHashtagInterestExist(@Param("HASHTAG_SEQ") long hashtagSeq, @Param("INTEREST_SEQ") long interestSeq) throws Exception;
	
	Map<String, Object> selectTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	void insertTbInterest(Map<String, Object> map) throws Exception;
	
	void insertTbHashtag(@Param("HASHTAG_SEQ") long hastagSeq, @Param("HASHTAG") String hashtag) throws Exception;
	 
	void insertTbIfHashtagInterest(@Param("HASHTAG_SEQ") long hashtagSeq, @Param("INTEREST_SEQ") long interestSeq) throws Exception;
	 
	void updateTbInterest(Map<String, Object> map) throws Exception;
	
	void deleteTbIfHashtagInterest(Map<String, Object> map) throws Exception;
}
