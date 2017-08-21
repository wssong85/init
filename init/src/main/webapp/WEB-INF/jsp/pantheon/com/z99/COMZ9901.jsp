<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<a href="/com/z99/changeLocale.do?locale=kr">한국어</a><br>
<a href="/com/z99/changeLocale.do?locale=en">영어</a><br>
<a href="/com/z99/changeLocale.do?locale=jp">일본어</a><br>
<a href="/com/z99/changeLocale.do?locale=ch_1">중국어_1</a><br>
<a href="/com/z99/changeLocale.do?locale=ch_2">중국어_2</a><br>
<spring:message code="global.lang" /><br>
current locale: ${pageContext.response.locale}
<script type="text/javascript">
var jsTest = '<spring:message code="global.lang" />';
alert(jsTest);
</script>