package pantheon.ctms.d01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.d01.dao.CTMD01DAO;
import pantheon.ctms.d01.service.CTMD01Service;

@Service("CTMD01Service")
public class CTMD01ServiceImpl implements CTMD01Service{

	@Resource(name = "CTMD01DAO")
	private CTMD01DAO CTMD01DAO;
	
	

}
