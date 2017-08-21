package pantheon.com.utl.service;

import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * PDF(itext) 관리 인터페이스 (openoffice로 대체하여 이제 안쓴다.)
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
public interface PantheonPdfWriterService {
	
	/**
	 * pdf 만든다.
	 * @param egovPeopertyService
	 * @param uploadPath
	 * @param uploadFileNm
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public long pdfWriter(EgovPropertyService egovPeopertyService, String uploadPath, String uploadFileNm, Map<String, String> map) throws Exception;
}
