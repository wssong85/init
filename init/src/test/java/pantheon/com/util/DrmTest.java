package pantheon.com.util;

import com.fasoo.adk.packager.WorkPackager;

public class DrmTest {
	public static void main(String[] args) {
 		WorkPackager wp = new WorkPackager();
 		wp.DoExtract("C:/pantheon/fasoo/fsdinit", "0000000000010105", "C:/test/excel/test_atc_sample.xlsx", "C:/test/excel/test_atc_sample.xlsx");
	}
}
