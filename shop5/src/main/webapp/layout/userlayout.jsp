<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<title><decorator:title /></title>
<script type="text/javascript" 
	src="http://www.chartjs.org/dist/2.9.3/Chart.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif;}
.w3-sidebar {
  z-index: 3; 
  width: 250px;
  top: 43px;
  bottom: 0;
  height: inherit;
}
</style>
<script type="text/javascript"
	src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<decorator:head />
<link rel="stylesheet" href="${path}/css/main.css">
<body>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-theme w3-top w3-left-align w3-large">
    <span style="float:right">
		<c:if test="${empty sessionScope.loginUser}">
			<a href="${path}/user/login.shop">�α���</a>
			<a href="${path}/user/userEntry.shop">ȸ������</a>
		</c:if>
		<c:if test="${!empty sessionScope.loginUser}">
			${sessionScope.loginUser.username}��&nbsp;
			<a href="${path}/user/logout.shop">�α׾ƿ�</a>
		</c:if></span>
  </div>
</div>

<!-- Sidebar -->
<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
    <i class="fa fa-remove"></i>
  </a>
  <h4 class="w3-bar-item"><b>Menu</b></h4>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path}/user/main.shop">ȸ������</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path}/item/list.shop">��ǰ����</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path}/board/list.shop">�Խ���</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path}/chat/chat.shop">ä��</a>

	<div class="w3-container">
		<%--ajax�� ���� ���� ȯ�� ���� ���� ��� --%>
		<div id="exchange1">
		</div>
	</div>
	<div class="w3-container">
		<%--KEB�ϳ����� ���� ����ϱ�:
		USD, JPY, EUR, CNY: �Ÿű�����, ������Ƕ�, �����ĽǶ� --%>
		<div id="exchange2">
		</div>
	</div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main" style="margin-left:250px">

  <div class="w3-row w3-padding-64">
  
	<div class="w3-row-padding w3-margin-bottom">
		<div class="w3-half">
			<div class="w3-container w3-padding-16">
				<div id="piecontatiner" style=" width:80%; border: 1px solid #000000">
				<canvas id="canvas1" style="width:100%;"></canvas>
				</div>			
			</div>
		</div>
		<div class="w3-half">
			<div class="w3-container w3-padding-16">
				<div id="barcontatiner" style=" width:80%; border: 1px solid #000000">
				<canvas id="canvas2" style="width:100%;"></canvas>
				</div>			
			</div>
		</div>
	</div>
	
    <div class="w3-threequarter w3-container" style="text-align: left; vertical-align: top">
      <decorator:body/>
    </div>
    
  </div>
  


  <footer id="myFooter">
    <div class="w3-container w3-theme-l2 w3-padding-32">
      <h4>�����ī���� Since 2016</h4>
    </div>

    <div class="w3-container w3-theme-l1">
      <p>Powered by <a href="http://www.gdu.co.kr/main/main.html" target="_blank">�����ī����</a></p>
    </div>
  </footer>

<!-- END MAIN -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>
<script type="text/javascript">
	var randomColorFactor = function(){
		return Math.round(Math.random() * 255);
	}
	var randomColor = function(opa){
		return "rgba(" + randomColorFactor() + ","
				+ randomColorFactor() + ","
				+ randomColorFactor() + ","
				+ (opa || '.3') + ")";
	}
	$(function(){
		piegraph();
		bargraph();
		exchangeRate1();	//ȯ�������� ajax�� ���� ũ�Ѹ��ϱ�.
		exchangeRate2();
	})
	
	function exchangeRate1(){
		$.ajax("${path}/ajax/exchange1.shop",{
			success: function(data){
				$("#exchange1").html(data);
			},
			error: function(e){
				alert("ȯ�� ��ȸ�� ���� ����:" + e.status);
			}
		})
	}
	
	function exchangeRate2(){
		$.ajax("${path}/ajax/exchange2.shop",{
			success: function(data){
				$("#exchange2").html(data);
			},
			error: function(e){
				alert("ȯ�� ��ȸ�� ���� ����:" + e.status);
			}
		})
	}
	
	function piegraph(){
		$.ajax("${path}/ajax/graph1.shop",{
			//data: json.toString()���� ���޹��� data
			//json������ ���ڿ��� ������
			success: function(data){
				pieGraphPrint(data);
			},
			error: function(e){
				alert("���� ����:" + e.status);
			}
		})
	}
	function bargraph(){
		$.ajax("${path}/ajax/graph2.shop",{
			success: function(data){
				barGraphPrint(data);
			},
			error: function(e){
				alert("���� ����:" + e.status);
			}
		})
	}
	function pieGraphPrint(data){
		console.log(data)
		//JSON.parse(data): json���·� ����(parse)
		var rows = JSON.parse(data);
		var names = []
		var datas = []
		var colors = []
		$.each(rows,function(index,item){
			names[index] = item.name;
			datas[index] = item.cnt;
			colors[index] = randomColor(1);
		})
		var config = {
			type: 'pie',
			data: {
				datasets: [{
					data: datas,
					backgroundColor: colors
				}],
				labels: names
			},
			options: {
				responsive: true,
				legend: {position: 'top'},
				title:{
					display: true,
					text: '�۾��� �� �Խ��� ��� �Ǽ�',
					position: 'bottom'
				}
			}		
		}
		var ctx = document.getElementById("canvas1").getContext("2d");
		new Chart(ctx,config);
	}
	function barGraphPrint(data){
		console.log(data)
		var rows = JSON.parse(data);
		var dates = []
		var datas = []
		var colors = []
		$.each(rows,function(index,item){
			dates[index] = item.date;
			datas[index] = item.cnt;
			colors[index] = randomColor(1);
		})
		var config = {
				type: 'bar',
				data: {	labels: dates,
						datasets:[
						{
							type: 'line',
							borderColor: colors,
							borderWidth: 2,
							label: '�Ǽ�',
							fill: false,
							data: datas
						},{
							type: 'bar',
							label: '�Ǽ�',
							backgroundColor: colors,
							data: datas,
							borderWidth: 2
						}]
				},
				options:{
					responsive: true,
					title: {display: true,
							text: '�ϼ� �� �Խ��� ��� �Ǽ�',
							position: 'bottom'
					},
					legend: {display: false},
					scales:{
						xAxes:[{
							display: true,
							scaleLabel: {
								display: true,
								labelString: "�Խù� �ۼ���"
							},
							stacked: true	
						}],
						yAxes: [{
							display: true,
							scaleLabel: {
								display: true,
								labelString: "�Խù� �ۼ��Ǽ�"
							},
							stacked: true	//�⺻�� 0���� ����
						}]
					}
				}
			};
			var ctx = document.getElementById("canvas2").getContext("2d");
			new Chart(ctx, config);
	}
</script>
</body>
</html>
