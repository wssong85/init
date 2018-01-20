package realtime.shopping.product.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.shopping.product.mapper.ProductMapper;
import realtime.shopping.product.service.ProductService;


@Service("ProductService")
public class ProductServiceImpl implements ProductService{

	@Resource(name = "ProductMapper")
	private ProductMapper productMapper;

	@Override
	public Map<String, Object> selectDetail(Map<String, Object> map) throws Exception {
		return productMapper.selectProduct(map);
	}

}
