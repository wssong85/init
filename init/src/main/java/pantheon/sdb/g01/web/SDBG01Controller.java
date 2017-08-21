package pantheon.sdb.g01.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.d01.service.COMD01Service;
import pantheon.sdb.g01.service.SDBG01Service;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Controller
public class SDBG01Controller {
	@Resource(name="SDBG01Service")
	private SDBG01Service sdbg01Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "SDB_CHANGE_REASON_SEQ")
	private EgovIdGnrService sdbChangereasonseq;
	
	@RequestMapping(value="/sdb/g01/SDBG0101.do")
	public String sdbg0101(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		
		return "/pantheon/sdb/g01/SDBG0101";
	}	
	
	@RequestMapping(value="/sdb/g01/SDBG0102.do")
	public String sdbg0102(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		
		return "/pantheon/sdb/g01/SDBG0102";
	}
}





