package pantheon.sdb.f03.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import pantheon.sdb.f03.service.SDBF03Service;

@Controller
public class SDBF03Controller {
	@Resource(name = "SDBF03Service")
	private SDBF03Service sdbf03Service;
	
	@RequestMapping("/sdb/f03/SDBF0301.do")
	public String SDBF0301(HttpServletRequest req, HttpServletResponse res) throws Exception{
		return "/pantheon/sdb/f03/SDBF0301";
	}
	

}
