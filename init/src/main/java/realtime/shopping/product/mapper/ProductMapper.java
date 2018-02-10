package realtime.shopping.product.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ProductMapper")
public interface ProductMapper {
	
	Map<String, Object> selectProduct(Map<String, Object> map) throws Exception;

}
