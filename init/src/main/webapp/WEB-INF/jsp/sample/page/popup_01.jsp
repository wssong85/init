

<%@page pageEncoding="UTF-8"%>    

<script>
$("#btnClose").click(function(){ 				
	layerClose();
});
</script>

<section class="popupWrap">
	<div class="popup wd760">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h6>개인정보취급방침</h6>
			<article class="mgT5">

				
				<div class="agreebox_01">
					<div class="agreebox_01div" style="height:400px;">
						<%@include file="./agree_04.jsp"%>
					</div>
				</div>

				
			</article>
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


