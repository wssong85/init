package pantheon.com.z02.service;

/**
 * DRM 처리하는 비지니스 인터페이스 클래스
 * @author 송원석
 * @since 2016.03.04
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.04  송원석          최초 생성
 *  
 */
public interface DrmManageService {
	
	/**
	 * drm처리 지원 여부
	 * @param pathName
	 * @return
	 * @throws Exception
	 */
	public boolean isSupportFile(String pathName) throws Exception;
	
	/**
	 * drm처리 되어있는지 여부
	 * @param pathName
	 * @return
	 * @throws Exception
	 */
	public boolean isDrmFile(String pathName) throws Exception;
	
	/**
	 * drm처리한다.
	 * @param path
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public boolean doPackage(String originalFile, String copyFile) throws Exception;
	
	/**
	 * drm을 해제한다.
	 * @param path
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public boolean doExtract(String originalFile, String copyFile) throws Exception;
	
	/**
	 * drm 지원과 처리 여부를 확인하여 drm처리한다.
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void doFilePackage(String pathName) throws Exception;
	
	/**
	 * drm 지원과 처리 여부를 확인하여 drm을 해제한다.
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void doFileExtract(String pathName) throws Exception;
}
