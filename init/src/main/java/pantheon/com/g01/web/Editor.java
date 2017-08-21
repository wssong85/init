package pantheon.com.g01.web;

import org.springframework.web.multipart.MultipartFile;

/**
 * 에디터 파일 관리를 위한 VO 클래스
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
public class Editor {
	private MultipartFile Filedata;
	
	public MultipartFile getFiledata() {
		return Filedata;
	}
	
	public void setFiledata(MultipartFile filedata) {
		Filedata = filedata;
	}
}

