package realtime.com.user.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import realtime.com.user.mapper.UserManageMapper;
import realtime.com.user.service.UserManageService;

@Service("UserManageService")
public class UserManageServiceImpl implements UserManageService {
	
	@Resource(name = "UserManageMapper")
	private UserManageMapper userManageMapper;
	
	@Override
	public List<Map<String, Object>> selectTbUserMetaData() throws Exception {
		
		return getTbUserMetaDataList();
	}

	@Override
	public List<Map<String, Object>> selectTbUserList() throws Exception {
		
		List<Map<String, Object>> metaDataList = getTbUserMetaDataList();
		
		String query = getDynamicQuerySelect("TB_USER", metaDataList, "", "", "A.ROLE", "USER_ID", "JOIN TB_AUTHORITIES A ON T.USER_ID = A.USER_ID");
		List<Map<String, Object>> userList = userManageMapper.selectTbUserList(query);
		
		for (Map<String, Object> user : userList) {
			
			String userId = (String) user.get("USER_ID");
			
			if (null != userId) {
				
				query = getDynamicQuerySelect("TB_USER_DETAIL", metaDataList, "USER_ID", userId, "", "", "");
				Map<String, Object> userDetail = userManageMapper.selectTbUserDetail(query);
				
				if (null != userDetail) {
					
					user.putAll(userDetail);
				}
			}
		}
		
		return userList;
	}

	@Override
	public void multiTbUser(List<Map<String, Object>> list) throws Exception {
		
		List<Map<String, Object>> metaDataList = getTbUserMetaDataList();
		
		String query = "";
		
		for(Map<String, Object> map : list) {
			
			if("C".equals(map.get("CRUD"))) {
				
				query = getDynamicQueryInsert("TB_USER", map, metaDataList);
				userManageMapper.insertTbUser(query);
				
				query = getDynamicQueryInsert("TB_USER_DETAIL", map, metaDataList);
				userManageMapper.insertTbUserDetail(query);
				
				// 권한등록
				userManageMapper.insertTbAuth(map);
				
			} else if("U".equals(map.get("CRUD"))) {
				
				query = getDynamicQueryUpdate("TB_USER", "USER_ID", map, metaDataList);
				userManageMapper.updateTbUser(query);
				
				query = getDynamicQueryUpdate("TB_USER_DETAIL", "USER_ID", map, metaDataList);
				userManageMapper.updateTbUserDetail(query);
				
				// 권한수정
				userManageMapper.updateTbAuth(map);
				
			} else if("D".equals(map.get("CRUD"))) {
				
				// 권한삭제
				userManageMapper.deleteTbAuth(map);
				
				userManageMapper.deleteTbUserDetail(map);
				userManageMapper.deleteTbUser(map);
			}
		}
	}
	
	// TB_USER, TB_USER_DETAIL의 테이블 정보를 가져옴
	// comment가 있는 컬럼만 화면에 표시 함
	private List<Map<String, Object>> getTbUserMetaDataList() {

		// TB_USER 테이블 정보
		List<Map<String, Object>> userMetaData = userManageMapper.selectTbUserMetaData();
		
		// TB_USER_DETAIL 테이블 정보
		List<Map<String, Object>> userMetaDataDetail = userManageMapper.selectTbUserDetailMetaData();
		
		for (Map<String, Object> metaData : userMetaData) {
			
			// 테이블 명 저장
			metaData.put("Table", "TB_USER");
		}
		
		for (Map<String, Object> metaDataDetail : userMetaDataDetail) {
			
			// 테이블 명 저장
			metaDataDetail.put("Table", "TB_USER_DETAIL");
			
			// TB_USER 테이블 정보와 합침
			userMetaData.add(metaDataDetail);
		}
		
		return userMetaData;
	}
	
	// TODO: 코드개선필요
	private String getDynamicQuerySelect(String tableName, List<Map<String, Object>> metaDataList, String whereColumn, String whereValue, String joinSelect, String joinColumn, String joinQuery) {
			
		StringBuilder selectBuilder = new StringBuilder();
		
		if(!"".equals(EgovStringUtil.isNullToString(whereValue))) {
			whereValue = "'" + whereValue + "'";
		}
			
		boolean isFirst = true;
		
		for (Map<String, Object> metaData : metaDataList) {
			
			String table = (String) metaData.get("Table");
			
			// tableName에 해당하는 컬럼인 경우
			if (!StringUtils.isEmpty(table) && table.equalsIgnoreCase(tableName)) {
				
				String columnName = (String) metaData.get("Field");
				String columnType = (String) metaData.get("Type");
				
				String comma = (isFirst) ? "" : ", ";
				
				if ("datetime".equals(columnType)) {
				
					columnName = comma + "DATE_FORMAT("+ columnName +", '%Y-%m-%d %H:%i:%s') AS "+ columnName;
					
				} else {
					
					if (joinColumn.equals(columnName)) {
						
						columnName = "T."+ columnName;
					}
					
					columnName = comma + columnName;
				}
				
				selectBuilder.append(columnName);
				
				if (isFirst) {
					isFirst = false;
				}
			}
		}
		
		if (!"".equals(joinSelect)) {
			
			selectBuilder.append(", "+ joinSelect);
		}
		
		String query = "";
		
		if (!isFirst) {
			
			query = "SELECT "+ selectBuilder.toString() + " FROM " + tableName +" T "+ joinQuery + (("".equals(whereColumn)) ? "" : " WHERE "+ whereColumn +" = "+ whereValue);
		}
		
		return query;
	}
	
	// TODO: 코드개선필요
	private String getDynamicQueryInsert(String tableName, Map<String, Object> value, List<Map<String, Object>> metaDataList) {
		
		StringBuilder insertBuilder = new StringBuilder();
		StringBuilder valuesBuilder = new StringBuilder();
		
		boolean isFirst = true;
		
		for (Map<String, Object> metaData : metaDataList) {
			
			String table = (String) metaData.get("Table");
			
			// tableName에 해당하는 컬럼인 경우
			if (!StringUtils.isEmpty(table) && table.equalsIgnoreCase(tableName)) {
				
				String columnName = (String) metaData.get("Field");
				String columnType = (String) metaData.get("Type");
			
				// 컬럼명이 있다면 
				if (!StringUtils.isEmpty(columnName)) {
					
					String columnValue = getColumnValue(columnType, value.get(columnName));
					
					String comma = (isFirst) ? "" : ", ";
					
					columnName = comma + columnName;
					insertBuilder.append(columnName);
					
					if (null == columnValue) {
						
						valuesBuilder.append(comma);
						valuesBuilder.append(columnValue);
						
					} else {
						
						columnValue = comma + getQueryValue(columnType, columnValue);
						valuesBuilder.append(columnValue);
					}
					
					if (isFirst) {
						isFirst = false;
					}
				}
			}
		}
		
		String query = "";
		
		if (!isFirst) {
			
			query = "INSERT INTO "+ tableName + " (" + insertBuilder.toString() +") VALUES ("+ valuesBuilder.toString() +")";
		}
		
		return query;
	}
	
	// TODO: 코드개선필요
	private String getDynamicQueryUpdate(String tableName, String whereColumn, Map<String, Object> value, List<Map<String, Object>> metaDataList) {
		
		StringBuilder updateBuilder = new StringBuilder();
		
		String whereValue = "";
		boolean isFirst = true;
		
		for (Map<String, Object> metaData : metaDataList) {
			
			String table = (String) metaData.get("Table");
			
			// tableName에 해당하는 컬럼인 경우
			if (!StringUtils.isEmpty(table) && table.equalsIgnoreCase(tableName)) {
				
				String columnName = (String) metaData.get("Field");
				String columnType = (String) metaData.get("Type");
			
				// 컬럼명이 있다면 
				if (!StringUtils.isEmpty(columnName)) {
					
					String columnValue = getColumnValue(columnType, value.get(columnName));
					
					// 조건컬럼인 경우 값만 가져옴
					if (whereColumn.equals(columnName)) {
						
						whereValue = getQueryValue(columnType, columnValue);
						continue;
					}
					
					String comma = (isFirst) ? "" : ", ";
					
					columnName = comma + columnName +" = ";
					updateBuilder.append(columnName);
					
					if (null == columnValue) {
						
						updateBuilder.append(columnValue);
						
					} else {
						
						updateBuilder.append(getQueryValue(columnType, columnValue));
					}
					
					if (isFirst) {
						isFirst = false;
					}
				}
			}
		}
		
		String query = "";
		
		if (!isFirst) {
			
			query = "UPDATE "+ tableName + " SET " + updateBuilder.toString() +" WHERE "+ whereColumn +" = "+ whereValue;
		}
		
		return query;
	}
	
	// TODO: 더 많은 컬럼 타입에 대한 처리가 필요
	private String getColumnValue(String type, Object obj) {
		
		if (null == obj && type.indexOf("datetime") == -1) { return null; }
		
		return String.valueOf(obj);
	}
	
	// TODO: 더 많은 컬럼 타입에 대한 처리가 필요
	private String getQueryValue(String type, String value) {
		
		if (type.indexOf("varchar")  != -1) {
			
			return "'"+ value +"'";
			
		} else if (type.indexOf("decimal") != -1) {
			
			return value;
			
		} else if (type.indexOf("datetime") != -1) {
			
			return "NOW()";
		}
		
		return "";
	}
}
