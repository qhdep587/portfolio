<#import "/spring.ftl" as spring />

<html>
<head>
<meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content=0>
    <meta http-equiv="pragma" content="no-cache">

<title>Smart Checker</title>

<link rel="stylesheet" href="${rc.contextPath}/style/public.css" type="text/css">

<script src="${rc.contextPath}/alert/js/es6-promise.auto.min.js"></script>
<script src="${rc.contextPath}/alert/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="${rc.contextPath}/alert/css/sweetalert2.css" type="text/css">

<script type="text/javascript" src="js/i18n/resource_locale_${lang}.js"></script>

<script language="javascript">
var innerIp = "${innerIp?default("")}";
var navigatorInfo = "";

function checkEnter(event)
{
	if(event.keyCode == 13) {
		checkValidate();
	}
}

function checkValidate(check)
{
	//form = document.forms[0];
	form = document.userForm;
	if(!form.j_username.value) {
		swal({
			html : JSLocale.MSG_ALERT_REQ_ID_INPUT,
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
		return false;
	}
	else if(!form.j_password.value) {
		swal({
			html : JSLocale.MSG_ALERT_REQ_PWD_INPUT,
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
		return false;
	}
	
	var pw = form.j_password.value;
	var adminId= form.j_username.value;
	
	if(adminId.indexOf(">") > 0 || adminId.indexOf("<") > 0) {
		swal({
			html : "허용되지 않은 특수문자가 포함되어 있습니다.",
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
		return false;
	}
	else if(pw.indexOf(">") > 0 || pw.indexOf("<") > 0) {
		swal({
			html : "허용되지 않은 특수문자가 포함되어 있습니다.",
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
		return false;
	}
	
	form.j_password.value=adminId+pw;
	
	form.submit();
}

function security_ok() {
	frmLogin = document.userForm;
	frmLogin.target="";
	frmLogin.action="loginProc.do";
	frmLogin.submit();
}

function initLoginInfo() {
	var mainpanel = top.window.document.getElementById('mainpanel');
	if(mainpanel) {
		top.window.alert(JSLocale.MSG_ALERT_INFO_SESS_EXPIRED_RELOGIN);
		top.window.document.location = "login.do";
	}
	else {	
		var body = document.getElementById('loginBody');
		body.style.display="";
		
		form = document.forms[0];
		form.j_username.focus();
	}
}

function showMsg() {
	var msgTimeout = '${MSG_TIMEOUT?default("0")}';
	if(msgTimeout == '1') {
		swal({
			html : JSLocale.MSG_ALERT_INFO_SESS_EXPIRED_RELOGIN,
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
	}
	
	var msgRemoteRelogin = '${MSG_REMOTE_RE_LOGIN?default("0")}';
	if(msgRemoteRelogin == '1') {
		swal({
			html : "다른 장소에서 로그인 되어 로그아웃 됩니다.",
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
	}
}

function browserCheck() {
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
        (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
        
        if(Sys.ie == null)document.write(JSLocale.STRING_DESC_NOT_IE_DISPLAY);
        //if(Sys.ie) document.write('IE: '+Sys.ie);
        //if(Sys.firefox) document.write('Firefox: '+Sys.firefox);
        //if(Sys.chrome) document.write('Chrome: '+Sys.chrome);
        //if(Sys.opera) document.write('Opera: '+Sys.opera);
        //if(Sys.safari) document.write('Safari: '+Sys.safari);
}

${msg?default("")}
</script>

<style>
input::placeholder {color: #999999;}
input:focus {outline:none;}
@font-face {
    font-family: "MyFont"; /* 임의로 폰트 이름  */
    src: url(${rc.contextPath}/style/font/NANUMSQUARE_ACR.TTF");
}
.loginbutton{
	cursor:pointer;
	border-radius:7px;
	border:none;
	background:radial-gradient(circle, rgba(11,11,11,0.1) 0%, rgba(1,1,11,0.25) 50%, rgba(11,11,11,0.45) 100%);
	box-shadow:1.5px 1.5px 3px -1px rgba(1,1,1,1);
	color:rgba(255,255,255,0.9);
	font: 105% MyFont !important;
}
.loginbutton:hover{
	background:radial-gradient(circle, rgba(11,11,11,0.25) 0%, rgba(1,1,11,0.4) 50%, rgba(11,11,11,0.6) 100%);
}
.modalbutton:hover{
	background:radial-gradient(circle, rgba(11,11,11,0.25) 0%, rgba(1,1,11,0.4) 50%, rgba(11,11,11,0.6) 100%);
}
a:hover{
	color:#93edbb !important;
}
body{
	-ms-user-select: none;
	-moz-user-select: -moz-none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	user-select:none;
}

.pwmodal{
	position:absolute;
	display:none;
	width:100%;
	height:100%;
	bottom:0.1%;
	background:rgba(1,1,1,0.3);
}
.passwordmodal{
	position:absolute;
	width:500px;
	height:320px;
	bottom:50%;
	left:50%;
	margin-left:-250px;
	margin-bottom:-160px;
	background-image:url(${rc.contextPath}/images/graybg.jpg);
	border-radius:20px;
	box-shadow:4px 5px 6px 5px rgba(1,1,1,0.4);
	text-align:center !important;
}
.passwordmodal2{
	width:100%;
	height:100%;
	background:rgba(255,255,255,0.03);
	border-radius:20px;
	box-shadow:4px 5px 6px 5px rgba(1,1,1,0.4);
	text-align:center !important;
}
.jmodal{
	position:absolute;
	display:none;
	width:100%;
	height:100%;
	bottom:0.1%;
	background:rgba(1,1,1,0.3);
}
.joinmodal{
	position:absolute;
	width:600px;
	height:800px;
	bottom:50%;
	left:50%;
	margin-left:-300px;
	margin-bottom:-400px;
	background-image:url(${rc.contextPath}/images/graybg.jpg);
	border-radius:20px;
	box-shadow:4px 5px 6px 5px rgba(1,1,1,0.4);
	text-align:center !important;
}
.joinmodal2{
	width:100%;
	height:100%;
	background:rgba(255,255,255,0.03);
	border-radius:20px;
	box-shadow:4px 5px 6px 5px rgba(1,1,1,0.4);
	text-align:center !important;
}

</style>

</head>

<body onContextMenu="return false">
<form method="post" action="${rc.contextPath}/j_security_check" name="userForm" onkeydown="checkEnter(event)">
<div id="loginBody" style="display:none">
<div style="display:block;width:368px;left:50%;margin-left:-184px;height:674px;top:50%;margin-top:-337px;background-color:rgba(52,58,64,0.5);position:absolute;
border-radius:20px;box-shadow:4px 5px 6px 5px rgba(1,1,1,0.4);"></div>
<table width="100%" height="100%" border="0" style="background-image:url(${rc.contextPath}/images/graybg.jpg); background-size: cover;">
	<tbody width="100%" valign="middle">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0" align="center" style="position:relative;top:-180px;">
					<tr height="400" >
						<td style="text-align:center; position:relative; top:30px;">
							<!--<img align="absmiddle" src="${rc.contextPath}/images/sdr_title.png">-->
							
							<label><!--<img width="65%" height="65%" align="absmiddle" src="${rc.contextPath}/images/sclogo1.png">-->
								<font style="font-size:52px; color:snow;">Smart</font>
								<font style="font-size:27px; color:lightgray;">Checker</font>
								<img style="position:relative;bottom:2.3px;width:25px; height:25px;"align="absmiddle" src="${rc.contextPath}/images/tick.png">
								<br>
								<font style="font:107% MyFont; color:snow;">원스톱 보안 / 장애 관리 솔루션</font>
							</label>
						</td>
					</tr>
					<br><br>
					<tr>
					<br><br><br><br>
						<td style="width:300px !important;text-align:center;position:relative;top:10px;">
						<label style="float:left; color:snow;">ID</label>
							<input type="text" id="j_username" name="j_username" size="14" maxlength="50" style="height:35;width:100%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="user ID" autocomplete="off">
						<label style="float:left; color:snow;">Password</label>	
							<input type="password" name="j_password" size="14" maxlength="20" style="height:35;width:100%;padding:4px;margin-top:2px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="*******" autocomplete="off">
						<a class="alink" onclick="document.getElementById('pwmodal').style.display='block'" style="font:98% MyFont;color:lightgray;float:right;position:relative;top:5px;">비밀번호 찾기</a>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td style="text-align:center;position:relative;top:15px;">
							<div class="loginbutton" onclick="document.getElementById('jmodal').style.display='block'" style="display:inline-block;width:70px; height:32px;"><font style="position:relative;top:7px;">회원가입</font></div>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="loginbutton" onClick="checkValidate()" style="display:inline-block;width:60px; height:32px;"><font style="position:relative;top:7px;">로그인</font></div>
							<div class="loginbutton" onClick="javascript:alert('asd');" style=" display:inline-block;width:95%; height:35px; 
							font-size:105% !important; font-weight:bold;position:relative; top:95px;"><font style="position:relative;top:9px;">사용자 매뉴얼 다운로드</font></div>
						</td>
					</tr>
					<tr>
						<td style="text-align:center;position:relative; top:130px;">
							<hr style="height:0px;">
							<font>Copyright 2020(c) WidgetNuri. All Right Reserved</font>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>

<div id="pwmodal" class="pwmodal">
	    <div  class="passwordmodal">
			<div class="passwordmodal2">
			
			    <font style="font: 110% MyFont !important; color:white; font-weight:bold; position:relative; top:20px; ">비밀번호 찾기
			    </font>
			    
			    <hr style="position:relative; top:17px; color:white; width:30%;">
			    
			    <br><br>
			    
			    <label style="color:lightgray;font: 90% MyFont !important;">* ID를 입력하시면 회원가입 시 등록한 이메일 주소로 <br>임시 비밀번호를 보내드립니다.
			    </label>
			    
			    <br><br><br>
			    
			    <input type="text" name="#" size="14" maxlength="20" style="height:35;width:70%;padding:4px;margin-top:2px;
				border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); 
				color:D1D9DF; font-size:17px;" placeholder="user ID" autocomplete="off">
				
			    <button class"modalbutton" onclick="#"
			    style="
			    position:relative;top:65%;right:5%;float:right;width:60px; height:32px;cursor:pointer;border-radius:7px;border:none;
			    background:radial-gradient(circle, rgba(11,211,111,0.1) 0%, rgba(1,201,111,0.25) 50%, rgba(11,211,111,0.45) 100%);
				box-shadow:1.5px 1.5px 3px -1px rgba(1,1,1,1);color:rgba(255,255,255,0.9);font: 100% MyFont !important;
				">전송
				</button>
				
				<br><br><br><br>
				
			    <button class"modalbutton" onclick="closeModal1();"
			    style="
			    position:relative;top:65%;width:60px; height:32px;cursor:pointer;border-radius:7px;border:none;
			    background:radial-gradient(circle, rgba(11,11,11,0.1) 0%, rgba(1,1,11,0.25) 50%, rgba(11,11,11,0.45) 100%);
				box-shadow:1.5px 1.5px 3px -1px rgba(1,1,1,1);color:rgba(255,255,255,0.9);font: 100% MyFont !important;
				">닫기
				</button>
				
		  </div>
	</div>
</div>

<script>
function closeModal1(){
	document.getElementById('pwmodal').children[0].children[0].children[8].value="";
	document.getElementById('pwmodal').style.display='none'
}
</script>


<div id="jmodal" class="jmodal">
	    <div  class="joinmodal">
			<div class="joinmodal2">
			
			    <font style="font: 115% MyFont !important; color:white; font-weight:bold; position:relative; top:20px; ">회원가입
			    </font>
			    
			    <hr style="position:relative; top:17px; color:white; width:30%;">
			    <br><br>
			    <br>
			    
			    <form name="join-confirm" novalidate="" autocomplete="false" style="position:relative;left:6.5%; width:90%;">
						<div class="join">
						
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">이메일 *</label>
								<input type="email" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="user@email.com" autocomplete="off">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">비밀번호 *</label>
								<input type="password" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="******" autocomplete="new-password">
								<br>
								<small id="error_zpwe" style="position:relative;left:7.5%;font-size:10px; color:lightgray;">* 하나 이상의 문자 및 숫자, 특수문자가 포함되어야 합니다(8~20자)</small>
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">비밀번호 확인 *</label>
								<input type="text" name="prevent_autofill" id="prevent_autofill" value="" style="display:none;" />
								<input type="password"   value="" style="display:none;" />
								<input type="password" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="******" autocomplete="new-password">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">회사명 *</label>
								<input type="password"   value="" style="display:none;" />
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="" autocomplete="false">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">성명 *</label>
								<input type="text"   value="" style="display:none;" />
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="" autocomplete="off">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">전화번호 *</label>
								<input type="password"   value="" style="display:none;" />
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="00-0000-0000" autocomplete="off">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">휴대폰 번호</label>
								<input type="password"   value="" style="display:none;" />
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="000-0000-0000" autocomplete="off">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">사번</label>
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="" autocomplete="off">
							</div>
							
							<br>
							
							<div class="form-group">
								<label for="company" style="float:left; color:white; width:22%; display:block; text-align:left;">소속</label>
								<input type="text" id="#" name="#" size="14" maxlength="50" style="height:35;width:70%;padding:4px;margin-bottom:10px;
							border:none;border-bottom:2.5px solid snow;background-color:rgba(18,34,48,0); color:D1D9DF; font-size:17px;" placeholder="" autocomplete="off">
							</div>
						</div>							
					</form>
			    
				<br><br>
				
			    <button class"modalbutton" onclick="closeModal2();"
			    style="
			    position:relative;top:65%;width:60px; height:32px;cursor:pointer;border-radius:7px;border:none;
			    background:radial-gradient(circle, rgba(11,11,11,0.1) 0%, rgba(1,1,11,0.25) 50%, rgba(11,11,11,0.45) 100%);
				box-shadow:1.5px 1.5px 3px -1px rgba(1,1,1,1);color:rgba(255,255,255,0.9);font: 100% MyFont !important;
				">닫기
				</button>
				&nbsp;&nbsp;
				<button class"modalbutton" onclick="#"
			    style="
			    position:relative;top:65%;width:90px; height:32px;cursor:pointer;border-radius:7px;border:none;
			    background:radial-gradient(circle, rgba(11,211,111,0.1) 0%, rgba(1,201,111,0.25) 50%, rgba(11,211,111,0.45) 100%);
				box-shadow:1.5px 1.5px 3px -1px rgba(1,1,1,1);color:rgba(255,255,255,0.9);font: 100% MyFont !important;
				">가입하기
				</button>
				
		  </div>
	</div>
</div>

<script>
function closeModal2(){
	document.getElementById('jmodal').style.display='none'

	for(var i = 0; i<document.getElementById('jmodal').children[0].children[0].getElementsByTagName("form")[0].getElementsByTagName("input").length;i++){
	console.log(i);
	document.getElementById('jmodal').children[0].children[0].getElementsByTagName("form")[0].getElementsByTagName("input")[i].value="";
	}
}
</script>

<script language="javascript">

<#if error_code?default("") == "1">
	swal({
		html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
		width: "340px",
		confirmButtonText: "확인",
		confirmButtonColor: "#2051ED"
	});
	
<#elseif error_code?default("") == "2">
	swal({
		html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
		width: "340px",
		confirmButtonText: "확인",
		confirmButtonColor: "#2051ED"
	});
	
<#elseif error_code?default("") == "3">
	swal({
		html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
		width: "340px",
		confirmButtonText: "확인",
		confirmButtonColor: "#2051ED"
	});
	
<#elseif error_code?default("") == "4">
	if('${authFailExcess?default("false")}' == "false") {
		swal({
			html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
	}
	else{
		swal({
			html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
			width: "340px",
			confirmButtonText: "확인",
			confirmButtonColor: "#2051ED"
		});
	}
<#elseif error_code?default("") == "5">
	swal({
		html : JSLocale.MSG_ALERT_ERROR_LOGIN_AUTH_FAIL,
		width: "340px",
		confirmButtonText: "확인",
		confirmButtonColor: "#2051ED"
	});
</#if>

initLoginInfo();
setTimeout(function() {
	showMsg();
}, 1*1000);

</script>
</body>
</html>