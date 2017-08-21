package pantheon.com.z02.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasoo.adk.packager.WorkPackager;

import egovframework.com.cmm.service.EgovProperties;
import pantheon.com.z02.service.DrmManageService;

@Service("DrmManageService")
public class DrmManageServiceImpl implements DrmManageService{
	
	private static final Logger log = LoggerFactory.getLogger(DrmManageServiceImpl.class);
	
	@Override
	public boolean isDrmFile(String pathName) throws Exception {
		WorkPackager wp = new WorkPackager();
		boolean flag = wp.IsPackageFile(pathName);
		
		if(!flag) {
			log.debug("IsPackageFile ErrorNum : " + wp.getLastErrorNum());
			log.debug("IsPackageFile ErrorStr : " + wp.getLastErrorStr());
		}
		
		return flag;

	}

	@Override
	public boolean isSupportFile(String pathName) throws Exception {
		WorkPackager wp = new WorkPackager();
		boolean flag = wp.IsSupportFile(EgovProperties.getProperty("drm.fsdinit"), EgovProperties.getProperty("drm.key"), pathName);
		
		if(!flag) {
			log.debug("isSupportFile ErrorNum : " + wp.getLastErrorNum());
			log.debug("isSupportFile ErrorStr : " + wp.getLastErrorStr());
		}
		
		return flag;
	}

	@Override
	public boolean doPackage(String originalFile, String copyFile) throws Exception {
		WorkPackager wp = new WorkPackager();
		boolean flag = wp.DoPackaging(EgovProperties.getProperty("drm.fsdinit"), EgovProperties.getProperty("drm.key"), originalFile, copyFile);
		
		if(!flag) {
			log.debug("doPackage ErrorNum : " + wp.getLastErrorNum());
			log.debug("doPackage ErrorStr : " + wp.getLastErrorStr());
		}
		
		return flag;
	}

	@Override
	public boolean doExtract(String originalFile, String copyFile) throws Exception {
		WorkPackager wp = new WorkPackager();
		boolean flag = wp.DoExtract(EgovProperties.getProperty("drm.fsdinit"), EgovProperties.getProperty("drm.key"), originalFile, copyFile);
		
		if(!flag) {
			log.debug("doExtract ErrorNum : " + wp.getLastErrorNum());
			log.debug("doExtract ErrorStr : " + wp.getLastErrorStr());
		}
		
		return flag;

	}

	@Override
	public void doFilePackage(String pathName) throws Exception {
		if(isSupportFile(pathName)) {
			if(!isDrmFile(pathName)) {
				doPackage(pathName, pathName);
			}
		}
	}

	@Override
	public void doFileExtract(String pathName) throws Exception {
		if(isDrmFile(pathName)) {
			doExtract(pathName, pathName);
		}
	}
}