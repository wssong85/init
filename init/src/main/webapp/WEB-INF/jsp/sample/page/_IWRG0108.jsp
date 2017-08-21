

<%@page pageEncoding="UTF-8"%>    

<style>
table.graph_01{ border:none;}
table.graph_01 tr{border:none;}
table.graph_01 td{ text-align:center; height: 49px; vertical-align: bottom; padding-bottom:5px; border:none;}
table.graph_01 tr:nth-child(1) td{ vertical-align: middle; background: url(/images/pantheon/contents/graph_01.png) no-repeat 0 0;}
table.graph_01 tr:nth-child(2) td{ background: url(/images/pantheon/contents/graph_02.png) no-repeat 0 0;}
table.graph_01 tr:nth-child(3){ border:none;}
table.graph_01 tr:nth-child(3) td{background: url(/images/pantheon/contents/graph_03.png) no-repeat 0 0;}
table.graph_01 td .graph_inputbox{ width: 92px; text-align: center;}
</style>


<script>
$(function() {
	
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	

});


</script>

<section class="popupWrap">
	<div class="popup" style="width:476px;">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>무작위배정코드 배정표</h5>
			<article class="mgT5">
				
				<div style="text-align: center; font-family:'NanumGothicBold';">
					<h6>Diagram (블록, 층화 적용, 추가 코드)</h6>
				</div>
				<table class="tb001 graph_01">
					<colgroup>
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<input type="text" class="graph_inputbox" value="CJ-xxx-xxx">
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" class="graph_inputbox" value="Sex(Male)">
								<span style="padding:0 50px;"></span>
								<input type="text" class="graph_inputbox" value="Sex(Female)">
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" class="graph_inputbox" value="SBP(<100)">
								<input type="text" class="graph_inputbox" value="SBP(>=100)">
								<span style="padding:0 10px;"></span>
								<input type="text" class="graph_inputbox" value="SBP(<100)">
								<input type="text" class="graph_inputbox" value="SBP(>=100)">
							</td>
						</tr>
					</tbody>
				</table>

				<div style="height:10px;"></div>
			
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>기존 생성 수</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>추가 생성 수</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>부분 합계</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>합계</th>
							<td colspan="4"></td>
						</tr>
					</tbody>
				</table>
			</article>
			

			
			
			<article class="mgT10">
				<div style="text-align:center">
					<!-- <input type="button" id="" value="저장" /> -->
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


