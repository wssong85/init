package realtime.shopping.hashtag.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import realtime.shopping.hashtag.mapper.HashtagMapper;
import realtime.shopping.hashtag.service.HashtagService;

@Service("HashtagService")
public class HashtagServiceImpl implements HashtagService {

	@Resource(name = "HashtagMapper")
	private HashtagMapper hashtagMapper;
	
	@Resource(name = "TB_HASHTAG_SEQ")
	private EgovIdGnrService tbHashtagSeq;
	
	@Resource(name = "TB_INTEREST_SEQ")
	private EgovIdGnrService tbInterestSeq;
	
	@Override
	public Map<String, Object> selectTbIfHashtagInterest(Map<String, Object> map) throws Exception {
		
		return hashtagMapper.selectTbIfHashtagInterest(map);
	}

	@Override
	public void insertTbIfHashtagInterest(Map<String, Object> map) throws Exception {
		
		// TODO: 추후 세션 값으로 변경
		// 아이디를 가져옴
		String id = (String) map.get("userId");
		
		System.out.println("id => "+ id);

		// 해쉬태그 값은 #으로 구분
		String hashtag = (String) map.get("hashtag");
		String[] hashtags = hashtag.split("#");
		
		// 이미 관심목록을 등록한 게 있는지 확인
		Long interestSeq = hashtagMapper.selectTbInterestExist(id);
		
		System.out.println("interestSeq => "+ interestSeq);
		
		if (interestSeq != null && interestSeq != 0) {
			
			// 관심목록이 있었다면 관심목록의 기존 시퀀스값을 사용
			map.put("INTEREST_SEQ", interestSeq);
			
			// 관심목록 수정
			hashtagMapper.updateTbInterest(map);
			
		} else {
			
			// 관심목록이 없었다면 관심목록 시퀀스값을 생성
			interestSeq = tbInterestSeq.getNextLongId();
			map.put("INTEREST_SEQ", interestSeq);
			
			// 관심목록 등록
			hashtagMapper.insertTbInterest(map);
		}
		
		List<Long> hashtagExistList = new ArrayList<>();
		Long hashtagSeq, hashtagSeqIf;
		
		// 해쉬태그 등록 처리
		for (String tag : hashtags) {
			
			tag = tag.trim();
			
			if (tag.length() == 0) {
				continue;
			}
			
			hashtagSeq = hashtagMapper.selectTbHashtagExist(tag.trim()); 
			
			System.out.println("hashtagSeq => "+ hashtagSeq);
			
			// 해쉬태그 처리
			if (hashtagSeq == null || hashtagSeq == 0) {
				
				// 해쉬태그가 없었다면 해쉬태그가 시퀀스값을 생성
				hashtagSeq = tbHashtagSeq.getNextLongId();
				
				// 해쉬태그 등록
				hashtagMapper.insertTbHashtag(hashtagSeq, tag.trim());
			}
			
			hashtagSeqIf = hashtagMapper.selectTbIfHashtagInterestExist(hashtagSeq, interestSeq); 
			
			// 관심목록과 해쉬태그 연관 처리
			if (hashtagSeqIf == null || hashtagSeqIf == 0) {
				
				// 해당 관심목록에 해쉬태그 없었다면 관심목록에 등록
				hashtagMapper.insertTbIfHashtagInterest(hashtagSeq, interestSeq);
			}
			
			// 해당 관심목록의 해쉬태그 시퀀스값을 목록을 가지고 있음
			hashtagExistList.add(hashtagSeq);
		}
		
		map.put("existList", hashtagExistList);
		
		// 최종적으로 가지고 있는 해쉬태그 목록을 제외한 나머지 해쉬태그를 삭제 처리
		hashtagMapper.deleteTbIfHashtagInterest(map);
	}

	@Override
	public List<Map<String, Object>> selecBuyTbProductList(Map<String, Object> map) throws Exception {
		
		// TODO: 해쉬태그 명 검색 추가
		return hashtagMapper.selecBuyTbProductList(map);
	}
}
