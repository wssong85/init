

<%@page pageEncoding="UTF-8"%>    

<script>
$(function() {

	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});

});


</script>

<section class="popupWrap">
	<div class="popup wd760">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>CDISC 일괄 업로드</h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>버전</th>
							<td><input type="text" style="width:100%;"></td>
							<th>규칙명</th>
							<td><input type="text" style="width:100%;"></td>
						</tr>
						<tr>
							<th>설명</th>
							<td colspan="3" style="padding:7px 4px 0px 12px;">
								<textarea id="txtreason" rows="1" style="width:100%;"></textarea>
							</td>
						</tr>
						<tr>
							<th>업로드파일</th>
							<td colspan="3">
				 				<div class="fileInputArea" style="width:70%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:79%;">
					 				<input type="button" value="파일 선택" class="fileInputBtn" />
					 				<input type="file" class="fileIuputHid" style="width:100%;">
				 				</div>
								<input type="button" id="" value="업로드" />
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<h6 class="mgT10">Variable List - 유효성 검사 : Fail(3)</h6>
			<article class="mgT5">
 				<div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
 				<div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
			</article>
			
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="저장" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


