

<%@page pageEncoding="UTF-8"%>

<script>
	$("#btnClose").click(function() {
		layerClose();
	});
</script>




<section class="popupWrap">
	<div class="popup wd600">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>신규등록</h5>
			<article class="mgT5" style="h8eight:200px;">
				<table class="tb001">
					<colgroup>
						<col width="16%" />
						<col width="25%" />
						<col width="16%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>패스워드</th>
							<td>
								<input type="checkbox" name="" id="c01" ><label for="c01" class="chcLab"><span>발급</span></label>
							</td>
							<th>권한</th>
							<td>
								<select id="" style="width:100%;">
									<option>===선택===</option>
									<option value="">마스터</option>
									<option value="">손님</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" id="" style="width:100%;" />
							</td>
							<th>이메일</th>
							<td>
								<input type="text" id="" style="width:100%;" />
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" id="" style="width:100%;" />
							</td>
							<th>전화번호</th>
							<td>
								<input type="text" style="width:22%;"> - 
								<input type="text" style="width:33%;"> - 
								<input type="text" style="width:33%;">
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			

			
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="등록" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>












