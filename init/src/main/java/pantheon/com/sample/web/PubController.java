package pantheon.com.sample.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PubController {
	
	@RequestMapping("/sample/list.do")
	public String list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/list";
	}
	
	/*COM*/
	@RequestMapping(value="/com/d01/_COMD0101.do")
	public String _COMD0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/d01/_COMD0101";
	}

	@RequestMapping(value="/com/a01/_COMA0101.do")
	public String _COMA0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/a01/_COMA0101";
	}

	@RequestMapping(value="/com/j01/_COMJ0101.do")
	public String _COMJ0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/j01/_COMJ0101";
	}

	@RequestMapping(value="/com/z09/_COMZ0901.do")
	public String _COMZ0901(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/z09/_COMZ0901";
	}

	@RequestMapping(value="/com/z09/_COMZ0902.do")
	public String _COMZ0902(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/z09/_COMZ0902";
	}	
	
	@RequestMapping(value="/com/z09/_COMZ0903.do")
	public String _COMZ0903(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/z09/_COMZ0903";
	}
	
	
	@RequestMapping(value="/com/b02/_COMB0202.do")
	public String _COMB0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/com/b02/_COMB0202";
	}
	
	
	/*SDB*/
	@RequestMapping(value="/sdb/c01/_SDBC0101.do")
	public String _SDBC0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0101";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0102.do")
	public String _SDBC0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0102";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0104.do")
	public String _SDBC0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0104";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0106.do")
	public String _SDBC0106(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0106";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0107.do")
	public String _SDBC0107(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0107";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0108.do")
	public String _SDBC0108(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0108";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0109.do")
	public String _SDBC0109(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0109";
	}
	
	@RequestMapping(value="/sdb/c01/_SDBC0110.do")
	public String _SDBC0110(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0110";
	}

	@RequestMapping(value="/sdb/c01/popup_SDBC0103.do")
	public String _SDBC0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/_SDBC0103";
	}
	
	@RequestMapping(value="/sdb/c02/popup_SDBC0217.do")
	public String _SDBC0217(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c02/_SDBC0217";
	}

	
	@RequestMapping(value="/sdb/c02/popup_SDBC0218.do")
	public String _SDBC0218(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c02/_SDBC0218";
	}
	
	@RequestMapping(value="/sdb/b02/popup_SDBB0204.do")
	public String _SDBB0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/b02/_SDBB0204";
	}
	
	
	@RequestMapping(value="/sdb/c02/_SDBC0201.do")
	public String _SDBC0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c02/_SDBC0201";
	}

	@RequestMapping(value="/sdb/f04/_SDBF0401.do")
	public String _SDBF0401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/f04/_SDBF0401";
	}
	
	@RequestMapping(value="/sdb/b02/_SDBB0201.do")
	public String _SDBB0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/b02/_SDBB0201";
	}

	/*CTMS*/
	@RequestMapping(value="/ctms/l01/_CTML0101.do")
	public String _CTML0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/l01/_CTML0101";
	}
	
	@RequestMapping(value="/ctms/l01/_CTML0102.do")
	public String _CTML0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/l01/_CTML0102";
	}
	
	@RequestMapping(value="/ctms/v01/_CTMV0101.do")
	public String _CTMV0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/v01/_CTMV0101";
	}
	
	@RequestMapping(value="/ctms/b01/_CTMB0101.do")
	public String _ctmb0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/b01/_CTMB0101";
	}
	
	@RequestMapping(value="/ctms/b02/_CTMB0201.do")
	public String _ctmb0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/b02/_CTMB0201";
	}
	
	@RequestMapping(value="/ctms/b03/_CTMB0301.do")
	public String _CTMB0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/b03/_CTMB0301";
	}
		
	@RequestMapping(value="/ctms/j11/popup_DMCJ1102.do")
	public String _DMCJ1102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/j11/_DMCJ1102";
	}

	@RequestMapping(value="/ctms/j11/popup_DMCJ1103.do")
	public String _DMCJ1103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/j11/_DMCJ1103";
	}

	@RequestMapping(value="/ctms/j11/popup_DMCJ1104.do")
	public String _DMCJ1104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/j11/_DMCJ1104";
	}

	@RequestMapping(value="/ctms/j11/popup_DMCJ1106.do")
	public String _DMCJ1106(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/j11/_DMCJ1106";
	}
	
	@RequestMapping(value="/ctms/j07/_DMCJ0701.do")
	public String _DMCJ0701(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/j07/_DMCJ0701";
	}
	
	/*EDC*/
	@RequestMapping(value="/edc/k03/_EDCK0301.do")
	public String _EDCK0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k03/_EDCK0301";
	}

	@RequestMapping(value="/edc/k03/_selectLab.do")
	public String _EDCK0302(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k03/_EDCK0302";
	}

	@RequestMapping(value="/edc/j01/_EDCJ0102.do")
	public String _EDCJ0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/j01/_EDCJ0102";
	}

	@RequestMapping(value="/edc/a01/_EDCA0101.do")
	public String _EDCA0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/a01/_EDCA0101";
	}
	
	@RequestMapping(value="/edc/k01/_EDCK0101.do")
	public String _EDCK0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k01/_EDCK0101";
	}

	@RequestMapping(value="/edc/k01/_EDCK0102.do")
	public String _EDCK0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k01/_EDCK0102";
	}
	
	@RequestMapping(value="/edc/k02/_EDCK0201.do")
	public String _EDCK0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0201";
	}
	
	@RequestMapping(value="/edc/k02/_EDCK0202.do")
	public String _edck0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0202";
	}

	@RequestMapping(value="/edc/k02/popup_EDCK0202Sub01.do")
	public String _EDCK0202Sub01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0202Sub01";
	}

	@RequestMapping(value="/edc/k02/popup_EDCK0202Sub02.do")
	public String _EDCK0202Sub02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0202Sub02";
	}
	
	@RequestMapping(value="/edc/k02/_EDCK0204.do")
	public String _EDCK0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0204";
	}
	
	@RequestMapping(value="/edc/k02/_EDCK0207.do")
	public String _EDCK0207(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0207";
	}

	@RequestMapping(value="/edc/k02/_EDCK0208.do")
	public String _EDCK0208(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0208";
	}

	@RequestMapping(value="/edc/k02/_EDCK0209.do")
	public String _EDCK0209(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0209";
	}
	
	@RequestMapping(value="/edc/k02/popup_EDCK0210.do")
	public String _EDCK0210(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0210";
	}
	
	@RequestMapping(value="/edc/k02/_EDCK0214.do")
	public String _EDCK0214(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k02/_EDCK0214";
	}
	
	@RequestMapping(value="/edc/k05/_EDCK0501.do")
	public String _EDCK0501(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/edc/k05/_EDCK0501";
	}
	


/*IWRS*/	
	@RequestMapping(value="/iwrs/c01/_IWRC0101.do")
	public String _iwrs0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/iwrs/c01/_IWRC0101";
	}

	@RequestMapping(value="/iwrs/c01/popup_Iwrc0102.do")
	public String _Iwrc0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/iwrs/c01/_Iwrc0102";
	}
		
	@RequestMapping(value="/iwrs/c01/popup_Iwrc0107.do")
	public String _Iwrc0107(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/iwrs/c01/_Iwrc0107";
	}
	
	

/*new page*/
	@RequestMapping("/sample/page/icons.do")
	public String icons(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/icons";
	}

	@RequestMapping("/sample/uiModule/con_1depth.do")
	public String con_1depth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/uiModule/con_1depth";
	}

	@RequestMapping("/sample/uiModule/con_2depth.do")
	public String con_2depth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/uiModule/con_2depth";
	}
	
	@RequestMapping("/sample/uiModule/con_3depth.do")
	public String con_3depth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/uiModule/con_3depth";
	}
	
	@RequestMapping("/sample/page/_CTMA01.do")
	public String _CTMA01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMA01";
	}
	
	@RequestMapping("/sample/page/_CTMI01.do")
	public String _CTMI01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMI01";
	}
	
	@RequestMapping("/sample/page/_EDCB01.do")
	public String _EDCB01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCB01";
	}
	
	@RequestMapping("/sample/page/_IWRA01.do")
	public String _IWRA01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRA01";
	}
	
	@RequestMapping("/sample/page/_SDBA01.do")
	public String _SDBA01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBA01";
	}
	
	@RequestMapping("/sample/page/_DMCJ01.do")
	public String _DMCJ01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_DMCJ01";
	}
	
	@RequestMapping("/sample/page/_IWRE0102.do")
	public String _IWRE0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRE0102";
	}
	
	@RequestMapping("/sample/page/_COMH0109.do")
	public String _COMH0109(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0109";
	}
	
	@RequestMapping("/sample/page/_COMH0101.do")
	public String _COMH0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0101";
	}
	
	@RequestMapping("/sample/page/agree_01.do")
	public String agree_01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/agree_01";
	}
	
	@RequestMapping("/sample/page/agree_02.do")
	public String agree_02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/agree_02";
	}
	
	@RequestMapping("/sample/page/agree_03.do")
	public String agree_03(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/agree_03";
	}
	
	@RequestMapping("/sample/page/agree_04.do")
	public String agree_04(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/agree_04";
	}
	
	@RequestMapping("/sample/page/popup_01.do")
	public String popup_01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/popup_01";
	}
	
	@RequestMapping("/sample/page/_COMH0102.do")
	public String _COMH0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0102";
	}
	
	@RequestMapping("/sample/page/_COMH0103.do")
	public String _COMH0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0103";
	}
	
	@RequestMapping("/sample/page/_COMH0104.do")
	public String _COMH0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0104";
	}
	
	@RequestMapping("/sample/page/_COMH0105.do")
	public String _COMH0105(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0105";
	}
	
	@RequestMapping("/sample/page/_COMH0106.do")
	public String _COMH0106(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0106";
	}
	
	@RequestMapping("/sample/page/_COMH0107.do")
	public String _COMH0107(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMH0107";
	}
	
	@RequestMapping("/sample/page/_COMI0202.do")
	public String _COMI0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMI0202";
	}
	
	@RequestMapping("/sample/page/_COMI0203.do")
	public String _COMI0203(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMI0203";
	}

	@RequestMapping("/sample/page/_COMC0101.do")
	public String _COMC0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0101";
	}

	@RequestMapping("/sample/page/_COMC0102.do")
	public String _COMC0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0102";
	}

	@RequestMapping("/sample/page/_COMC0201.do")
	public String _COMC0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0201";
	}

	@RequestMapping("/sample/page/_COMC0202.do")
	public String _COMC0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0202";
	}

	@RequestMapping("/sample/page/_COMC0203.do")
	public String _COMC0203(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0203";
	}

	@RequestMapping("/sample/page/_COMC0204.do")
	public String _COMC0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0204";
	}

	@RequestMapping("/sample/page/_COMC0205.do")
	public String _COMC0205(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0205";
	}

	@RequestMapping("/sample/page/_COMC0301.do")
	public String _COMC0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0301";
	}

	@RequestMapping("/sample/page/_COMC0302.do")
	public String _COMC0302(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMC0302";
	}

	
	@RequestMapping("/sample/page/page_loading.do")
	public String page_loading(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/page_loading";
	}
	
	@RequestMapping("/sample/page/error_page.do")
	public String error_page(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/error_page";
	}

	@RequestMapping("/sample/page/_EDCC0101.do")
	public String _EDCC0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCC0101";
	}

	@RequestMapping("/sample/page/_EDCC0102.do")
	public String _EDCC0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCC0102";
	}

	@RequestMapping("/sample/page/_EDCC0103.do")
	public String _EDCC0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCC0103";
	}

	@RequestMapping("/sample/page/_EDCC0104.do")
	public String _EDCC0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCC0104";
	}
	
	@RequestMapping("/sample/page/_EDCE0101.do")
	public String _EDCE0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCE0101";
	}
	
	@RequestMapping("/sample/page/_EDCE0102.do")
	public String _EDCE0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCE0102";
	}
	
	@RequestMapping("/sample/page/_EDCE0103.do")
	public String _EDCE0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCE0103";
	}
	
	
	@RequestMapping("/sample/page/_SDBC0202.do")
	public String _SDBC0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0202";
	}
	
	@RequestMapping("/sample/page/_SDBC0203.do")
	public String _SDBC0203(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0203";
	}
	
	@RequestMapping("/sample/page/_SDBC0204.do")
	public String _SDBC0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0204";
	}
	
	@RequestMapping("/sample/page/_SDBC0205.do")
	public String _SDBC0205(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0205";
	}
	
	@RequestMapping("/sample/page/_SDBC0206.do")
	public String _SDBC0206(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0206";
	}
	
	@RequestMapping("/sample/page/_CTMZ0201.do")
	public String _CTMZ0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0201";
	}
	
	@RequestMapping("/sample/page/_CTMZ0202.do")
	public String _CTMZ0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0202";
	}
	
	@RequestMapping("/sample/page/_CTMZ0302.do")
	public String _CTMZ0302(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0302";
	}
	
	@RequestMapping("/sample/page/_CTMZ0303.do")
	public String _CTMZ0303(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0303";
	}
	
	@RequestMapping("/sample/page/_CTMZ0401.do")
	public String _CTMZ0401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0401";
	}
	
	@RequestMapping("/sample/page/_CTMZ0402.do")
	public String _CTMZ0402(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0402";
	}
	
	@RequestMapping("/sample/page/_CTMZ0501.do")
	public String _CTMZ0501(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0501";
	}
	
	@RequestMapping("/sample/page/_CTMZ0701.do")
	public String _CTMZ0701(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0701";
	}
	
	@RequestMapping("/sample/page/_CTMZ0801.do")
	public String _CTMZ0801(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0801";
	}
	
	@RequestMapping("/sample/page/_CTMZ0901.do")
	public String _CTMZ0901(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0901";
	}
	
	@RequestMapping("/sample/page/_CTMZ0902.do")
	public String _CTMZ0902(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ0902";
	}
	
	@RequestMapping("/sample/page/_CTMZ1001.do")
	public String _CTMZ1001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1001";
	}
	
	@RequestMapping("/sample/page/_CTMZ1002.do")
	public String _CTMZ1002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1002";
	}
	
	@RequestMapping("/sample/page/_CTMZ1101.do")
	public String _CTMZ1101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1101";
	}
	
	@RequestMapping("/sample/page/_CTMZ1201.do")
	public String _CTMZ1201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1201";
	}
	
	@RequestMapping("/sample/page/_CTMZ1401.do")
	public String _CTMZ1401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1401";
	}
	
	@RequestMapping("/sample/page/_CTMZ1501.do")
	public String _CTMZ1501(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_CTMZ1501";
	}
	
	@RequestMapping("/sample/page/_EDCD0101.do")
	public String _EDCD0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCD0101";
	}
	
	@RequestMapping("/sample/page/_EDCD0102.do")
	public String _EDCD0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCD0102";
	}
	
	@RequestMapping("/sample/page/_EDCD0105.do")
	public String _EDCD0105(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCD0105";
	}
	
	@RequestMapping("/sample/page/mail_02.do")
	public String mail_02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/mail_02";
	}
	
	@RequestMapping("/sample/page/_SDBG0102.do")
	public String _SDBG0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBG0102";
	}
	
	@RequestMapping("/sample/page/_SDBG0103.do")
	public String _SDBG0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBG0103";
	}
	
	@RequestMapping("/sample/page/_SDBG0104.do")
	public String _SDBG0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBG0104";
	}

	@RequestMapping("/sample/page/_IWRG0101.do")
	public String _IWRG0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0101";
	}
	
	@RequestMapping("/sample/page/_IWRG0102.do")
	public String _IWRG0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0102";
	}
	
	@RequestMapping("/sample/page/_IWRG0103.do")
	public String _IWRG0103(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0103";
	}
	
	@RequestMapping("/sample/page/_IWRG0104.do")
	public String _IWRG0104(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0104";
	}
	
	@RequestMapping("/sample/page/_IWRG0105.do")
	public String _IWRG0105(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0105";
	}
	
	@RequestMapping("/sample/page/_IWRG0106.do")
	public String _IWRG0106(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0106";
	}
	
	@RequestMapping("/sample/page/_IWRG0107.do")
	public String _IWRG0107(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0107";
	}
	
	@RequestMapping("/sample/page/_IWRG0108.do")
	public String _IWRG0108(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0108";
	}
	
	@RequestMapping("/sample/page/_IWRG0109.do")
	public String _IWRG0109(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0109";
	}

	@RequestMapping("/sample/page/_IWRG0110.do")
	public String _IWRG0110(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0110";
	}

	@RequestMapping("/sample/page/_IWRG0111.do")
	public String _IWRG0111(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0111";
	}
	
	
	@RequestMapping("/sample/page/_IWRG0111a.do")
	public String _IWRG0111a(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0111a";
	}
	
	@RequestMapping("/sample/page/_IWRG0112.do")
	public String _IWRG0112(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0112";
	}
	
	@RequestMapping("/sample/page/_IWRG0113.do")
	public String _IWRG0113(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0113";
	}
	
	@RequestMapping("/sample/page/_IWRG0114.do")
	public String _IWRG0114(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0114";
	}

	
	@RequestMapping("/sample/page/_IWRG0115.do")
	public String _IWRG0115(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0115";
	}
	
	@RequestMapping("/sample/page/_IWRG0116.do")
	public String _IWRG0116(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0116";
	}
	
	@RequestMapping("/sample/page/_IWRG0117.do")
	public String _IWRG0117(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0117";
	}
	
	@RequestMapping("/sample/page/_IWRG0201.do")
	public String _IWRG0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0201";
	}
	
	@RequestMapping("/sample/page/_IWRG0301.do")
	public String _IWRG0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0301";
	}
	
	@RequestMapping("/sample/page/_IWRG0302.do")
	public String _IWRG0302(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0302";
	}
	
	@RequestMapping("/sample/page/_IWRG0401.do")
	public String _IWRG0401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0401";
	}
	
	@RequestMapping("/sample/page/_IWRG0402.do")
	public String _IWRG0402(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_IWRG0402";
	}
	
	@RequestMapping("/sample/page/_EDCL0201.do")
	public String _EDCL0201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCL0201";
	}
	
	@RequestMapping("/sample/page/from_01.do")
	public String from_01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/from_01";
	}
	
	@RequestMapping("/sample/page/_COMK0101.do")
	public String _COMK0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMK0101";
	}
	
	@RequestMapping("/sample/page/_COMK0102.do")
	public String _COMK0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_COMK0102";
	}
	
	@RequestMapping("/sample/page/_SDBC0301.do")
	public String _SDBC0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0301";
	}
	
	@RequestMapping("/sample/page/_SDBC0211.do")
	public String _SDBC0211(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_SDBC0211";
	}
	
	@RequestMapping("/sample/page/_EDCL0202.do")
	public String _EDCL0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/sample/page/_EDCL0202";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
