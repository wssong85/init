package pantheon.com.utl.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.penta.scpdb.ScpDbAgent;

import egovframework.com.cmm.service.EgovProperties;
import pantheon.com.utl.service.DamoService;

@Service("DamoService")
public class DamoServiceImpl implements DamoService{

	private static final Logger log = LoggerFactory.getLogger(DamoServiceImpl.class);
	
	@Override
	public String scpEncStr(String str) throws Exception {
		
		ScpDbAgent agt = new ScpDbAgent();
		
		int ret = agt.AgentInit(EgovProperties.getProperty("damo.ini"));
		
		if (ret != 0 && ret != 118) {
			Thread.sleep(2000);
			log.debug("DAMO ERROR(ENC)!! ERROR CODE: " + String.valueOf(ret));
			throw new Exception(String.valueOf("DAMO ERROR(ENC)!! ERROR CODE: " + String.valueOf(ret)));
		}
		
		return agt.ScpEncB64(EgovProperties.getProperty("damo.ini"), "KEY1", str, "UTF-8");
	}

	@Override
	public String scpDecStr(String str) throws Exception {
		
		ScpDbAgent agt = new ScpDbAgent();
		
		int ret = agt.AgentInit(EgovProperties.getProperty("damo.ini"));
		
		if (ret != 0 && ret != 118) {
			Thread.sleep(2000);
			log.debug("DAMO ERROR(DEC)!! ERROR CODE: " + String.valueOf(ret));
			throw new Exception(String.valueOf("DAMO ERROR(DEC)!! ERROR CODE: " + String.valueOf(ret)));
		}
		return agt.ScpDecB64(EgovProperties.getProperty("damo.ini"), "KEY1", str, "UTF-8");
		
	}
	
	@Override
	public String scpSha512Str(String str) throws Exception {
		
		ScpDbAgent agt = new ScpDbAgent();
		
		int ret = agt.AgentInit(EgovProperties.getProperty("damo.ini"));
		
		if (ret != 0 && ret != 118) {
			Thread.sleep(2000);
			log.debug("DAMO ERROR(ENC)!! ERROR CODE: " + String.valueOf(ret));
			throw new Exception(String.valueOf("DAMO ERROR(ENC)!! ERROR CODE: " + String.valueOf(ret)));
		}
		
		return agt.AgentCipherHashString(73, str);
	}
}
