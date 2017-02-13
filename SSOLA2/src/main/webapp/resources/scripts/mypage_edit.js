/**
 * registerform 내 정규식 등 
 */

var passCheck = false;
var nameCheck = false;
var emailCheck = false;

var befName; // 이전 닉네임을 저장할 값


$(function() {
	$("#submitButton").on("click", function(event) {
		if(!passCheck) {
			alert("잘못된 password 입력입니다. password를 확인해주세요.");
			$("#password").focus();
		} else if (!nameCheck) {
			alert("잘못된 nickname 입력입니다. nickname을 확인해주세요.")
			$("#nickname").focus();
		} else if (!emailCheck) {
			alert("잘못된 email 입력입니다. email을 확인해주세요.")
			$("#email").focus();
		} else {
			$("#edit").submit();
		}
	});

	//id

	$("#nicknameCheckButton").on("click", function(event) {
		// 중복 확인 버튼 누를 시 id 내용 가져와 db와 대조 필요
		var nickname = /^.*(?=.{2,15})(?=.*[ㄱ-ㅎ가-힣a-zA-Z0-9]).*$/;
		if (nickname.test($("#nickname").val())){
			$.ajax({
				"url" : "/ssola2/account/nicknamecheck.action",
				"method" : "get",
				"data" : { nickname : $("#nickname").val() },
				"dataType" : "text",
				success : function(data) {
					if (!data) {
						$("#nicknameMessage").css('color', 'red').text("다른 닉네임을 입력하세요");
						nameCheck = false;
						return false;
					}
					$("#nicknameMessage").css('color', 'blue').text("사용할 수 있는 닉네임 입니다.");
					befName = $("#nickname").val();
					nameCheck = true;
					return;
				}
			});
		} else {
			$("#nicknameMessage").css('color', 'red').text("닉네임이 형식에 맞지 않습니다.");
		}
	});

//id 

	$("#password").on('keyup', function (event) {
		var password = /^.*(?=.{8,16})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(password.test($("#password").val())){
			
			$("#passwordMessage").css('color', 'red').text("사용할 수 없는 형식입니다.(6-20글자 영어 숫자 최소 1)");
		}
	});

	$("#confirm").on('keyup', function (event) {
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		
	});

	$("#nickname").on('keyup', function(event) {
		var nickname = /^.*(?=.{2,15})(?=.*[ㄱ-ㅎ가-힣a-zA-Z0-9]).*$/;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(nickname.test($("#nickname").val())){
			if($("#nickname").val() != befName) {
				nameCheck = false;
				$("#nicknameMessage").css('color', 'gray').text("중복 확인이 필요합니다.");
			} else {
				if($("#nickname").val().length > 1){
					nameCheck = true;
					$("#nicknameMessage").css('color', 'blue').text("사용할 수 있는 닉네임 입니다.");
				}
			}
		} else {
			$("#nicknameMessage").css('color', 'red').text("사용할 수 없는 형식입니다.(2-15글자 한글,영어,숫자)");
		}
	});

	$("#email").on('keyup', function(event) {
		emailCheck = false;
		var email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
			$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(!$("#email").val()) {
			$("#emailMessage").css('color', 'gray').text("이메일을 입력해 주세요");
		} else {
			if(!email.test($("#email").val())) {
				$("#emailMessage").css('color', 'red').text("이메일 주소가 유효하지 않습니다.");
			} else {
				$("#emailMessage").css('color', 'blue').text("Good");
				emailCheck = true;
			}
		}
	});

	
});
